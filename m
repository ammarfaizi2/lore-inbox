Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289200AbSANLd1>; Mon, 14 Jan 2002 06:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289199AbSANLdU>; Mon, 14 Jan 2002 06:33:20 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:54549 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289200AbSANLdH>; Mon, 14 Jan 2002 06:33:07 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200201141133.g0EBX7r22754@devserv.devel.redhat.com>
Subject: Linux 2.4.18pre3-ac2
To: linux-kernel@vger.kernel.org
Date: Mon, 14 Jan 2002 06:33:07 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[+ indicates stuff that went to Marcelo, o stuff that has not]

Linux 2.4.18pre3-ac2

o	Re-merge the IDE patches			(Andre Hedrick and co)
o	Fix check/request region in ali_ircc and lowcomx(Steven Walter)
	com90xx, sealevel, sb1000
+	Remove unused message from 6pack driver		(Adrian Bunk)
+	Fix unused variable warning in i60scsi		(Adrian Bunk)
+	Fix off by one floppy oops			(Keith Owens)
o	Fix i2o_config use of undefined C		(Andreas Dilger)
+	Fix fdomain scsi oopses				(Per Larsson)
+	Fix sf16fmi hang on boot			(me)
o	Add bridge resources to the resource tree	(Ivan Kokshaysky)
+	Fix iphase ATM oops on close in on case	   (Till Immanuel Patzschke)
+	Enable OOSTORE on winchip processors		(Dave Jones, me)
	| Worth about 10-20% performance 
+	Code Page 1250 support				(Petr Titera)
+	Fix sdla and hpfs doc typos			(Sven Vermeulen)
o	Document /proc/stat				(Sven Heinicke)
+	Update cs4281 drivers				(Tom Woller)
	| Fixes xmms stutter, remove wrapper code
	| handle tosh boxes, allow record device change
	| trigger wakeups on ioctl triggered changes
o	Fix locking of file struct stuff found by ibm	(Dipankar Sarma)
	audit
o	Use spin_lock_init in serial.c			(Dave Miller)
o	Fix AF_UNIX shutdown bug			(Dave Miller)

Linux 2.4.18pre3-ac1

o	32bit uid quota
o	rmap-11b VM					(Rik van Riel,
							 William Irwin etc)
o	Make scsi printer visible			(Stefan Wieseckel)
+	Report Hercules Fortissimo card			(Minya Sorakinu)
+	Fix O_NDELAY close mishandling on the following	(me)
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
+	Fix non blocking tty blocking bug		(Peter Benie)
o	IRQ routing workaround for problem HP laptops	(Cory Bell)
+	Fix the rcpci driver				(Pete Popov)
+	Fix documentation of aedsp location		(Adrian Bunk)
o	Fix the worst of the APM ate my cpu problems	(Andreas Steinmetz)
o	Correct icmp documentation			(Pierre Lombard)
+	Multiple mxser crash on boot fix	(Stephan von Krawczynski)
o	ldm header fix					(Anton Altaparmakov)
+	Fix unchecked kmalloc in i2c_proc	(Ragnar Hojland Espinosa)
+	Fix unchecked kmalloc in airo_cs	(Ragnar Hojland Espinosa)
+	Fix unchecked kmalloc in btaudio	(Ragnar Hojland Espinosa)
+	Fix unchecked kmalloc in qnx4/inode.c	(Ragnar Hojland Espinosa)
+	Disable DRM4.1 GMX2000 driver (4.0 required)	(me)
+	Fix sb16 lower speed limit bug			(Jori Liesenborgs)
o	Fix compilation of orinoco driver		(Ben Herrenschmidt)
o	ISAPnP init fix					(Chris Rankin)
o	Export release_console_sem			(Andrew Morton)
o	Output nat crash fix				(Rusty Russell)
o	Fix PLIP					(Niels Jensen)
o	Natsemi driver hang fix				(Manfred Spraul)
+	Add mono/stereo reporting to gemtek pci radio	(Jonathan Hudson)
