Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291088AbSCDDNk>; Sun, 3 Mar 2002 22:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291102AbSCDDNb>; Sun, 3 Mar 2002 22:13:31 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:29474 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S291088AbSCDDNV>; Sun, 3 Mar 2002 22:13:21 -0500
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C01102091@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Wakko Warner'" <wakko@animx.eu.org>, Kevin Herzig <Kevin@Herzig.Net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: DAC960 Driver - problem with DAC960PL
Date: Sun, 3 Mar 2002 22:12:08 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  Has anyone had any luck getting a DAC960PL card working in a HP Netserver
> LS2?

> I have recently acquired two of these beasts.  It has 4 Pentium 166
> processors,
> 640Meg Ram, and 6 4GB Quantum SCSI drives.  I've applied the latest
firmware
> patch (2.73) to the controller and made sure the system's BIOS was up to
> date
> (relatively speaking).

A couple of years ago, I had an HP netserver with Quad Pentium 100 CPU's,
and the same controller.  I bet it was similar to yours.  IIRC, HP had
modified that controller, and had their own PROM in it.  I never spent much
time working on getting it running, but we could never get Linux to
recognize it, and from what I read at the time, it was the firmware that
caused this.  We were able to get replacement PROM chips from Mylex, but I
think the ones we had were for the dual PROM chip, not the single PROM
controller, because after the replacement, the board would not see the
drives in the machine.  We gave up the gun quickly, and I went with a
software raid on it, as it was not a critical machine.  May not help you
much, but see if you have the HP modified Mylex controllers in it.  This is
all from my memory, so YMMV...

Thanks,
Bruce H.
