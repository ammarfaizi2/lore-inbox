Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277431AbRKNXZB>; Wed, 14 Nov 2001 18:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRKNXYv>; Wed, 14 Nov 2001 18:24:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30472 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277431AbRKNXYi>; Wed, 14 Nov 2001 18:24:38 -0500
Subject: Re: 2.4.14 reboot on/before boot
To: jmadden@ivy.tec.in.us (John Madden)
Date: Wed, 14 Nov 2001 23:31:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <50915.168.215.193.74.1005779564.squirrel@mail.ivy.tec.in.us> from "John Madden" at Nov 14, 2001 06:12:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1649VZ-0006K9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Two machines, identical hardware (Dell 2450's, Dual PIII/667, 1gig ram).
> One one, 2.4.14 boots and runs nicely, as one would expect.  On the other,
> "as close to exact as I can imagine" compile configs, the machine reboots
> just after LILO's "Loading Linux..."  Same version of LILO on both as well.
> 
> Has anyone else experienced this?  Any ideas on a fix?

Check they are the same BIOS. If so run memtest86 across them. The Lilo
load/unpack might be enough to stress memory and find real faults
