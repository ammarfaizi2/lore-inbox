Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288165AbSAMVpD>; Sun, 13 Jan 2002 16:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288160AbSAMVox>; Sun, 13 Jan 2002 16:44:53 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:4556 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S288159AbSAMVoq>; Sun, 13 Jan 2002 16:44:46 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200201132144.g0DLikH27385@devserv.devel.redhat.com>
Subject: Linux 2.4.18pre3-ac1
To: linux-kernel@vger.kernel.org
Date: Sun, 13 Jan 2002 16:44:46 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People keep bugging me about the -ac tree stuff so this is whats in my
current internal diff with the ll patch and the ide changes excluded.

Much of this is stuff just waiting to go to Marcelo but it has the 32bit
uid quota that some folks consider pretty critical and the rmap-11b VM
which I consider pretty essential

(Marcelo I'll be sending you stuff I've done from this anyway, if there
 is other stuff you want extracting just ask)

Linux 2.4.18pre3-ac1

o	32bit uid quota
o	rmap-11b VM					(Rik van Riel,
							 William Irwin etc)
o	Make scsi printer visible			(Stefan Wieseckel)
o	Report Hercules Fortissimo card			(Minya Sorakinu)
o	Fix O_NDELAY close mishandling on the following	(me)
	sound cards: cmpci, cs46xx, es1370, es1371,
	esssolo1, sonicvibes
o	tdfx pixclock handling fix			(Jurriaan)
o	Fix mishandling of file system size limiting	(Andrea Arcangeli)
o	generic_serial cleanups				(Rasmus Andersen)
o	serial.c locking fixes for SMP - move from cli	(Kees)
	too
o	Truncate fixes from old -ac tree		(Andrew Morton)
o	Hopefully fix the i2o oops			(me)
	| Not the right fix but it'll do till I rewrite this
o	Fix non blocking tty blocking bug		(Peter Benie)
o	IRQ routing workaround for problem HP laptops	(Cory Bell)
o	Fix the rcpci driver				(Pete Popov)
o	Fix documentation of aedsp location		(Adrian Bunk)
o	Fix the worst of the APM ate my cpu problems	(Andreas Steinmetz)
o	Correct icmp documentation			(Pierre Lombard)
o	Multiple mxser crash on boot fix	(Stephan von Krawczynski)
o	ldm header fix					(Anton Altaparmakov)
o	Fix unchecked kmalloc in i2o_proc	(Ragnar Hojland Espinosa)
o	Fix unchecked kmalloc in airo_cs	(Ragnar Hojland Espinosa)
o	Fix unchecked kmalloc in btaudio	(Ragnar Hojland Espinosa)
o	Fix unchecked kmalloc in qnx4/inode.c	(Ragnar Hojland Espinosa)
o	Disable DRM4.1 GMX2000 driver (4.0 required)	(me)
o	Fix sb16 lower speed limit bug			(Jori Liesenborgs)
o	Fix compilation of orinoco driver		(Ben Herrenschmidt)
o	ISAPnP init fix					(Chris Rankin)
o	Export release_console_sem			(Andrew Morton)
o	Output nat crash fix				(Rusty Russell)
o	Fix PLIP					(Tim Waugh)
o	Natsemi driver hang fix				(Manfred Spraul)
o	Add mono/stereo reporting to gemtek pci radio	(Jonathan Hudson)
