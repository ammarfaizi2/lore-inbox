Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312971AbSC0Cq3>; Tue, 26 Mar 2002 21:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSC0CqU>; Tue, 26 Mar 2002 21:46:20 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:47855
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312971AbSC0CqI>; Tue, 26 Mar 2002 21:46:08 -0500
Date: Tue, 26 Mar 2002 18:47:48 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre4-ac1
Message-ID: <20020327024748.GH3536@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16pvYV-0003cD-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's the latest installment of the changelog diff:

--- 2.4.19-pre3-ac6.log	Tue Mar 26 18:42:52 2002
+++ 2.4.19-pre4-ac1.log	Tue Mar 26 18:43:02 2002
@@ -45 +50 @@
-o	Fix wafer5823 watchdog merge error I made	(Justin Cormack)
++	Fix wafer5823 watchdog merge error I made	(Justin Cormack)
@@ -58 +63 @@
-o	Clean up wdt_pci				(Zwane Mwaikambo)
++	Clean up wdt_pci				(Zwane Mwaikambo)
@@ -67 +72 @@
-o	AT1700 filter fix				(Sawa)
++	AT1700 filter fix				(Sawa)
@@ -70,5 +75,5 @@
-o	Update USB config files				(Greg Kroah-Hartmann)
-o	TCP minisocks fixes				(Dave Miller)
-o	dnotify fixes					(Stephen Rothwell)
-o	Remove pointles sysrq-L				(Russell King)
-o	Reparent khubd to init				(Andrew Morton)
+*	Update USB config files				(Greg Kroah-Hartmann)
+*	TCP minisocks fixes				(Dave Miller)
+*	dnotify fixes					(Stephen Rothwell)
+*	Remove pointles sysrq-L				(Russell King)
++	Reparent khubd to init				(Andrew Morton)
@@ -76,2 +81,2 @@
-o	Use named initializers in hwc_con		(Pete Zaitcev)
-o	SHM ipc fix					(Paul Larson)
++	Use named initializers in hwc_con		(Pete Zaitcev)
+*	SHM ipc fix					(Paul Larson)
@@ -80 +85 @@
-o	Water WDT watchdog driver			(Justin Cormack)
++	Water WDT watchdog driver			(Justin Cormack)
@@ -82 +87 @@
-o	ITE8330G PIRQ map support			(Tobias Diedrich)
++	ITE8330G PIRQ map support			(Tobias Diedrich)
@@ -88 +93 @@
-o	ALi M1701 watchdog driver			(Stve Hill)
++	ALi M1701 watchdog driver			(Stve Hill)
@@ -92 +97 @@
-o	Add mk712 touchscreen driver			(Daniel Quinlan)
++	Add mk712 touchscreen driver			(Daniel Quinlan)
@@ -105 +110 @@
-o	Add vmalloc_to_page to 2.4 from 2.5		(Gerd Knorr)
+*	Add vmalloc_to_page to 2.4 from 2.5		(Gerd Knorr)
@@ -107 +112 @@
-+	Fix boot_cpu_data corruption bug		(Mikael Pettersson)
+*	Fix boot_cpu_data corruption bug		(Mikael Pettersson)
@@ -109,7 +114,7 @@
-+	Emagic EMI usb driver				(Tapio Laxström)
-+	Edgeport fixes for multiple device case	 	(Greg Kroah-Hartmann)	
-+	Ethtool support for catc usb			(Brad Hards)
-+	Update to pegasus driver in base tree		(Petko Manolov)
-+	Update USB maintainers				(Greg Kroah-Hartmann)
-+	IPAQ usb driver fixup				(Ganesh Varadarajan)
-+	Allow usbfs name for 2.5 compatibility		(Greg Kroah-Hartmann)
+*	Emagic EMI usb driver				(Tapio Laxström)
+*	Edgeport fixes for multiple device case	 	(Greg Kroah-Hartmann)	
+*	Ethtool support for catc usb			(Brad Hards)
+*	Update to pegasus driver in base tree		(Petko Manolov)
+*	Update USB maintainers				(Greg Kroah-Hartmann)
+*	IPAQ usb driver fixup				(Ganesh Varadarajan)
+*	Allow usbfs name for 2.5 compatibility		(Greg Kroah-Hartmann)
@@ -117 +122 @@
-+	Fix an NFS file creation problem		(Trond Myklebust)
+*	Fix an NFS file creation problem		(Trond Myklebust)
@@ -121 +126 @@
-o	Fix printk message levels in pci code		(Denis Vlasenko)
++	Fix printk message levels in pci code		(Denis Vlasenko)
@@ -128 +133 @@
-o	Initial Ricoh ZVbus support			(Marcus Metzler)
++	Initial Ricoh ZVbus support			(Marcus Metzler)
@@ -135,2 +140,2 @@
-o	Update reisefsprogs version			(Paul Komkoff)
-o	RME Hammerfall driver update			(Günter Geiger)
++	Update reisefsprogs version			(Paul Komkoff)
++	RME Hammerfall driver update			(Günter Geiger)
@@ -143,4 +148,4 @@
-o	Add WD xd signature to 2.4 (from 2.2)		(Jim Freeman)
-o	Update sc1200 watchdog				(Zwane Mwaikambo)
-o	Switch wdt501 watchdog driver to bitops		(me)
-o	Much updated LSI logic MPT fusion drivers	(Pam Delaney)
++	Add WD xd signature to 2.4 (from 2.2)		(Jim Freeman)
++	Update sc1200 watchdog				(Zwane Mwaikambo)
++	Switch wdt501 watchdog driver to bitops		(me)
++	Much updated LSI logic MPT fusion drivers	(Pam Delaney)
@@ -152 +157 @@
-o	Fix w83877 SMP deadlock, clean up locking	(me)
++	Fix w83877 SMP deadlock, clean up locking	(me)
@@ -159 +164 @@
-o	IDE code wasn't using ide_free_irq		(William Jhun)
+*	IDE code wasn't using ide_free_irq		(William Jhun)
@@ -171,2 +176,2 @@
-o	Further SiS IDE updates				(Lionel Bouton)
-o	Fix ufs mount failure bug			(Andries Brouwer)
+*	Further SiS IDE updates				(Lionel Bouton)
+*	Fix ufs mount failure bug			(Andries Brouwer)
@@ -200,2 +205,2 @@
-o	Fix incorrect sleep in ZR36067 driver		(me)
-o	Add missing cpu_relax to iph5526 driver		(me)
++	Fix incorrect sleep in ZR36067 driver		(me)
++	Add missing cpu_relax to iph5526 driver		(me)
@@ -204,2 +209,2 @@
-o	Merge aic7xxx update				(Justin Gibbs)
-o	Fix handling of scsi 'medium error: recovered'	(Justin Gibbs)
+*	Merge aic7xxx update				(Justin Gibbs)
+*	Fix handling of scsi 'medium error: recovered'	(Justin Gibbs)
@@ -252 +257 @@
-o	SC1200 watchdog driver				(Zwane Mwaikambo)
++	SC1200 watchdog driver				(Zwane Mwaikambo)
@@ -293,2 +298,2 @@
-o	Add an SC520 watchdog, and enable wd8387ff 	(Scott Jennings)
-o	Cleaned up and fixed some SC520 watchdog bugs	(me)
++	Add an SC520 watchdog, and enable wd8387ff 	(Scott Jennings)
++	Cleaned up and fixed some SC520 watchdog bugs	(me)
@@ -309 +314 @@
-o	SIS IDE driver update (handle with care)	(Lionel Bouton)
+*	SIS IDE driver update (handle with care)	(Lionel Bouton)
@@ -405 +410 @@
-o	Pegasus update					(Petko Manolov)
+*	Pegasus update					(Petko Manolov)
@@ -439 +444 @@
-o	IDE config text updates for the IDE patches	(Anton Altaparmakov)
++	IDE config text updates for the IDE patches	(Anton Altaparmakov)
