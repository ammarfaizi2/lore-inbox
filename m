Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265459AbSKFAcs>; Tue, 5 Nov 2002 19:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265464AbSKFAcr>; Tue, 5 Nov 2002 19:32:47 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:12263 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S265459AbSKFAco>; Tue, 5 Nov 2002 19:32:44 -0500
Subject: Unresolved symbols in char/raw.o (blkdev_ioctl) and
	fs/binfmt_aout.o (ptrace_notify)
From: Miles Lane <miles.lane@attbi.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 16:39:16 -0800
Message-Id: <1036543157.1162.17.camel@bellybutton>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.46; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.46/kernel/drivers/char/raw.o
depmod:         blkdev_ioctl
depmod: *** Unresolved symbols in
/lib/modules/2.5.46/kernel/fs/binfmt_aout.o
depmod:         ptrace_notify

CONFIG_AGP=y
CONFIG_AGP_AMD=y
CONFIG_AGP_AMD_8151=y
CONFIG_MWAVE=m
CONFIG_RAW_DRIVER=m

CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

Linux bellybutton 2.4.18-17.8.0 #1 Tue Oct 8 11:48:09 EDT 2002 i686
athlon i386
GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.93.so*
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         loop sr_mod emu10k1 ac97_codec sound soundcore
autofs 3c59x ipt_REJECT iptable_filter ip_tables ide-scsi scsi_mod
ide-cd cdrom ohci1394 ieee1394 ext3 jbd nls_iso8859-1 nls_cp437 vfat fat
mousedev keybdev hid input usb-ohci usbcore

