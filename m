Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291787AbSDAAzH>; Sun, 31 Mar 2002 19:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292130AbSDAAy5>; Sun, 31 Mar 2002 19:54:57 -0500
Received: from netmail.netcologne.de ([194.8.194.109]:58723 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S291787AbSDAAyt>; Sun, 31 Mar 2002 19:54:49 -0500
Message-Id: <200204010054.AVB24452@netmail.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre5-jp9 #1 Son =?iso8859-15?q?M=E4r=2031=2023=3A32=3A35=20CEST=202002=20i686?= unknown
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Patch set 2.4.19-pre5-jp9
Date: Mon, 1 Apr 2002 03:53:38 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel patch set jp9 of the Linux kernel 2.4.19pre5

http://infolinux.de/jp9

Jörg Prante, joerg@infolinux.de

Status: 01 Apr 2002 01:00

Changes from jp8 to jp9

Note: XFS can now be mounted as root filesystem. Thanks to Jared H. Hudson 
for the fix of the file system build procedure. Please compile XFS as 
built-in file system, not as a module. Otherwise there will be undefined 
symbols. Realtime clock support for ALSA Sequencer has been fixed.

Known Issues

Cdfs throws a segfault when accessing a CD.

Security note: The one-liner in 72_linux-2.4.18.secfix is not enough to fix 
the security problem in 2.4 kernels. It is only a forward port of the fix 
that can be found in older kernels. Currently as of 11 March 2002, a better 
solution is unknown. If you want to keep high security, you are requested to 
stay tuned for a new version of jp which will appear after a proven fix has 
been found

What is it?

The -jp kernels are development kernels for testing purpose only. They will 
appear regularly two or three times a month. Their purpose is to provide a 
service for developers who can't keep up to date with the latest kernel and 
patch versions, but want to test new features and evaluate enhancements that 
are not to be expected for inclusion into the mainstream 2.4 kernel.

You want to test the kernel patch set? Download the standard kernel 2.4.18, 
and apply the jp set.

You are missing a patch? Patches will be added by request.

You run into problems? Send me a mail and I will try to fix the problem. I 
want to get the jp kernels as much as stable I can.

You feel happy with a jp kernel? Just let me know if my work is good for you.

On my system I only use jp kernels. So, some minor features are specific to 
Dell Inspiron laptops.

Download

The patch set is provided as a single archive where you will find all patches 
as separate .bz2 packed files. Please take care if you split the set and try 
to use parts of it.

http://infolinux.de/jp9/patch-jp9.tar.bz2

Overview

00_patch-2.4.19-pre0-pre1.bz2
00_patch-2.4.19-pre1-pre2.bz2
00_patch-2.4.19-pre2-pre3.bz2
00_patch-2.4.19-pre3-pre4.bz2
00_patch-2.4.19-pre4-pre5.bz2
01_kernel-sound-remove-0-2.4.19pre5.bz2
01_kernel-sound-remove-1-2.4.19pre4.bz2
01_kernel-sound-remove-2-2.4.19pre3.bz2
01_kernel-sound-remove-3-2.4.19pre2.bz2
01_kernel-sound-remove-4-core.bz2
01_rtc.bz2
02_alsa-0.9.0beta10-0.bz2
02_alsa-0.9.0beta10-beta12-include.bz2
02_alsa-0.9.0beta10-beta12-sound.bz2
02_alsa-0.9.0beta12-no-modem-probe.bz2
02_alsa-0.9.0beta12-part1.bz2
03_boot-time-ioremap.bz2
03_dmi-apic-fixups.bz2
11_rmap-12h.bz2
12_sched-O1-K3.bz2
13_preempt-kernel-rml-2.4.19-pre2-ac2-3.bz2
14_lockbreak-rml.bz2
15_lockbreak-1.bz2
22_autofs4.bz2
22_isrdonly.bz2
22_new-stat.bz2
23_mediactl.bz2
24_llseek.bz2
25_mount.bz2
26_device.bz2
27_supermount-0.bz2
27_supermount-1.bz2
28_raidsplit.bz2
29_mdp-major.bz2
29_mdpart.bz2
30_xfs-kdb-30Mar2002.bz2
31_xfs-kdb-1.bz2
31_xfs-kdb-2.bz2
31_xfs-kdb-3.bz2
32_jfs-1.0.14-common.bz2
33_jfs-1.0.14-1.0.15.bz2
33_jfs-1.0.15-to-1.0.16.bz2
34_jfs-1.bz2
35_ftpfs-0.6.2.bz2
36_cdfs-0.5b.bz2
40_TIOCGDEV.bz2
41_twofish-2.4.3.bz2
50_crypto-patch-int-2.4.18.1-1.bz2
50_crypto-patch-int-2.4.18.1.bz2
51_loop-jari-2.4.16.0.bz2
60_freeswan-1.95-x509-0.9.8.bz2
70_grsecurity-1.9.4-1.bz2
71_grsecurity-1.9.4-2.bz2
72_linux-2.4.18.secfix.bz2
80_i2c-2.6.2.bz2
81_lmsensors-2.6.2.bz2
84_sdmany-v3.bz2
98_tkparse-4096.bz2

Enjoy!

Jörg

