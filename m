Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293681AbSCPCsd>; Fri, 15 Mar 2002 21:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293679AbSCPCsY>; Fri, 15 Mar 2002 21:48:24 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10738
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293681AbSCPCsL>; Fri, 15 Mar 2002 21:48:11 -0500
Date: Fri, 15 Mar 2002 18:49:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre2-ac3
Message-ID: <20020316024925.GB23938@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16iyh2-0002OY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16iyh2-0002OY-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- 2.4.19-pre2-ac3.log	Fri Mar 15 18:45:35 2002
+++ 2.4.19-pre2-ac4.log	Fri Mar 15 18:35:42 2002
@@ -8,7 +59,7 @@
 o	3c509 full duplex and documentation		(David Ruggiero)
 o	3c509 power management				(Zwane Mwaikambo)
 +	Remove more surplus llseek methods		(Robert Love)
-o	ATM locking fix					(Frode Isaksen)
+X	ATM locking fix					(Frode Isaksen)
 o	Merge extra sound help texts			(Steven Cole)
 	| plus one typo fix
 o	Add help for IXJ pcmcia configuration		(Steven Cole, me)
@@ -20,7 +71,7 @@
 +	Reiserfs updates				(Oleg Drokin)
 o	Auto enable HT on HT capable systems		(Arjan van de Ven)
 o	Fix init/do_mounts O(1) scheduler merge glitch	(Greg Louis)
-o	Fix drm build problem on CPU=386		(Mark Cooke)
+o	Fix drm build problem on CPU=3D386		(Mark Cooke)
 o	Fix incorrect sleep in ZR36067 driver		(me)
 o	Add missing cpu_relax to iph5526 driver		(me)
 
@@ -54,7 +105,7 @@
 o	Fix accounting error in the shm code		(me)
 o	Turn on mode2/mode3 overcommit protection	(me)
 +	w83877f watchdog fix compile for SMP		(Mark Cooke)
-+	Fix ide=nodma for serverworks			(Ken Brownfield)
++	Fix ide=3Dnodma for serverworks			(Ken Brownfield)
 *	USB2 controller support				(Greg Kroah-Hartmann)
 *	Add more devices to the visor driver (m515,clie)(Greg Kroah-Hartmann)
 *	IBM USB camera driver updates			(Greg Kroah-Hartmann)
@@ -149,7 +200,7 @@
 *	Massively clean up the AGP enable and bugfix it	(Bjorn Helgaas)
 o	Fix oops if you try to use the RW wq locks	(Bob Miller)
 o	Remove FPU usage in neomagic fb			(Denis Kropp)
-o	Merge IBM JFS			(Steve Best, Dave Kleikamp, 
+o	Merge IBM JFS			(Steve Best, Dave Kleikamp,=20
 					 Barry Arndt, Christoph Hellwig, ..)
 *	Updated sis frame buffer driver			(Thomas Winischhofer)
 
@@ -158,7 +209,7 @@
 *	Correct procfs locking fixup			(Al Viro)
 o	Speed up ext2/ext3 synchronous mounts		(Andrew Morton)
 +	Update IDE DMA blacklist			(Jonathan Kamens)
-o	Update to XFree86 DRM 4.2 (compatible to 4.1)	(Rik Faith, 
+o	Update to XFree86 DRM 4.2 (compatible to 4.1)	(Rik Faith,=20
 	and adds I830 DRM				 Jeff Hartmann,
 							 Keith Whitwell,
 							 Abraham vd Merwe
@@ -221,7 +272,7 @@
 o	Fix a wrong error return in the megaraid driver	(Arjan van de Ven)
 *	FreeVXFS update					(Christoph Hellwig)
 *	Qnxfs update					(Anders Larsen)
-o	Fix non compile with PCI=n			(Adrian Bunk)
+o	Fix non compile with PCI=3Dn			(Adrian Bunk)
 o	Fix DRM 4.0 non compile in i810			(me)
 o	Drop out now dead CLONE thread/parent fixup	(Dave McCracken)
 *	Make NetROM incoming frame check stricter	(Tomi Manninen)
@@ -287,7 +338,7 @@
 o	Add bridge resources to the resource tree	(Ivan Kokshaysky)
 *	Fix iphase ATM oops on close in on case	   (Till Immanuel Patzschke)
 *	Enable OOSTORE on winchip processors		(Dave Jones, me)
-	| Worth about 10-20% performance 
+	| Worth about 10-20% performance=20
 *	Code Page 1250 support				(Petr Titera)
 *	Fix sdla and hpfs doc typos			(Sven Vermeulen)
 o	Document /proc/stat				(Sven Heinicke)
