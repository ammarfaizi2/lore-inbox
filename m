Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317010AbSFFQvj>; Thu, 6 Jun 2002 12:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317011AbSFFQvi>; Thu, 6 Jun 2002 12:51:38 -0400
Received: from smtp.WPI.EDU ([130.215.24.62]:10770 "EHLO smtp.WPI.EDU")
	by vger.kernel.org with ESMTP id <S317010AbSFFQvh>;
	Thu, 6 Jun 2002 12:51:37 -0400
Date: Thu, 6 Jun 2002 12:51:38 -0400 (EDT)
From: "Brian J. Conway" <bconway@WPI.EDU>
To: linux-kernel@vger.kernel.org
Subject: Promise Ultra100 hang
Message-ID: <Pine.OSF.4.43.0206061239390.14804-100000@cpu.WPI.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running into trouble with an Ultra100 card (no raid or other features,
I think it's a PDC20267) with BIOS 2.01b27 when moving from two Maxtor
20GB 5400 RPM ATA66 drives to a Maxtor 80GB 5400 RPM ATA100 drive.  The
previous drives worked fine, but when trying to install Mandrake 8.2 on
only the new 80GB drive, it detects the controller correctly and goes to
check partitions and hangs at "hde" with the drive light going constant
and nothing happening.  I'm pretty sure the drive is fine as it works fine
on the controller card at ATA100 (recognized by the BIOS correctly as
Ultra DMA Mode 5) in Win2k, and I can plug it onto the motherboard PIIX4
controller and install Mandrake 8.2 that way without an issue.  Moving it
to the controller card after install with the generic 2.4.18 kernel or
compiling 2.4.19-pre8 (the last kernel version I used on the previous
drives which worked fine) all produces the hang at detecting partitions on
hde.  I don't have the machine in front of me, but can provide more info
as necessary.  Please CC me as I'm not on the list, any ideas would be
appreciated as to why the older drives work perfectly but the new one
hangs on detection.

Brian J. Conway
bconway@wpi.edu

