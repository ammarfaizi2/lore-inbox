Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSESXlg>; Sun, 19 May 2002 19:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSESXlf>; Sun, 19 May 2002 19:41:35 -0400
Received: from netmail.netcologne.de ([194.8.194.109]:38411 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S315517AbSESXle>; Sun, 19 May 2002 19:41:34 -0400
Message-Id: <200205192341.AWG64047@netmail.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre8 #4 Don Mai 9 23:37:47 CEST 2002 i686 unknown
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] 2.4.19-pre8-jp13
Date: Mon, 20 May 2002 01:41:11 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel patch set 2.4.19pre8-jp13  

This is the thirteenth release of the -jp patch set. 

http://infolinux.de/jp13/

Status: 20 May 2002 00:30 CEST 

Changes from jp12 to jp13 

Many bugfixes. ext3 update, NFS patch from Trond Myklebust, XFS update 
from CVS, Alsa oops in /proc/asound fixed, sched-O1 with extensions 
by Robert Love replaces sched-O1-K3 patch of Ingo Molnar, supermount 
and ftpfs fixed due to 2.4.19pre4 changes in VFS dentry revalidation 
behavior, cdfs oops fixed in supermount patch set, ACPI updated, 
IDE TCQ updated. 

Known Issues 

The miroSound PCM20 radio audio driver depends on OSS sound include 
file and is no longer supported. IDE TCQ is reported to oops with IBM 
Deskstar. 

What is it? 

The -jp kernels are development kernels for testing purpose only. They 
will appear regularly two or three times a month. Their purpose is to 
provide a service for developers who can't keep up to date with the 
latest kernel and patch versions, but want to test new features and 
evaluate enhancements that are not to be expected for inclusion into 
the mainstream 2.4 kernel. 

Download 
 
http://infolinux.de/jp13/patchset-2.4.19-pre8-jp13.tar.bz2 


Patch set overview
01_kernel-sound-remove-0-pre8  35_jfs-1.0.14-0
01_kernel-sound-remove-1-pre7  36_jfs-1.0.14-15
01_kernel-sound-remove-2-pre6  37_jfs-1.0.15-16
01_kernel-sound-remove-3-pre5  38_jfs-1.0.16-17
01_kernel-sound-remove-4-pre4  39_jfs-adapt
01_kernel-sound-remove-5-pre3  40_ftpfs-0.6.2
01_kernel-sound-remove-6-pre2  41_ftpfs-fixups
01_kernel-sound-remove-7-core  42_cdfs-0.5b
02_alsa-sound-0.9.0rc1         43_cdfs-0.5bc
03_alsa-adapt-2                44_patch-int-2.4.18.2
04_TIOCGDEV                    45_loop-jari
05_boot-time-ioremap           46_grsecurity-1.9.5-pre3
06_via-northbridge-fixup       47_grsecurity-adapt-2
07_jiffies-for-i386            48_i2c-2.6.3
08_rmap-13                     49_lmsensors-2.6.3
09_rmap13a                     50_freeswan-1.97
10_sched-O1-rml-2.4.19-pre8-3  51_ide-cd-dma-4
11_up-apic-fix                 52_lowlatency-mini
12_ext3-cvs                    53_lowlatency-fixes-5
13_nfs-2.4.19                  54_mmx-init
14_preempt-2.4.19pre8          55_p4-xeon
15_lockbreak                   56_x86-fast-pte
16_ide-all-convert-10          57_acpi-20020503
17_md-locks                    58_acpi-lowerlatency-3
18_raid-split                  59_acpi-pciirq-18
19_md-part                     60_acpi-y2k-1
20_mdp-major                   61_remove-khttpd
21_autofs4                     62_tux2-final-A3
22_isrdonly                    63_sis-740-961
23_new-stat-2                  64_radix-tree-pagecache-2.4.19pre5ac3
24_mediactl                    65_radix-tree-pagecache-xfs-fix
25_llseek                      66_block-tag-2.4.19pre8
26_mount                       67_block-tag-2
27_device                      68_ide-tag-2.4.19pre8
28_supermount                  69_ide-tag-2
29_supermount-fix              70_intermezzo-fix
30_xfs-kdb-from-cvs-04May2002  71_ufs-fix
31_xfs-13May2002               72_tux-exports-fix
32_xfs-19May2002               98_tkparse-4096
33_xfs-kdb-adapt-2             99_VERSION
34_xfs-kdb-fixups


More info available at 

http://infolinux.de/jp13

Have fun!

Jörg Prante 
joerg@infolinux.de 


