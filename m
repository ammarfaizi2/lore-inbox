Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVDFB1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVDFB1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 21:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVDFB1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 21:27:23 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:47145 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262067AbVDFBZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 21:25:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=VR1GkSeCjmhPym2ZArxMi6viwowI4lNY9S0gLNP/aSKmy/Yr7OUXMJIVzAtFjo/M4ZrGXVrxWdaHn3HxP39utEJrDW/QTfDPxTmNi4yXNHSmO+ki4oDRs/2itG+tjwXwvLdBzNKkzCNsec/lVLSqD7CiOliqt/qp1HE8goI4DxQ=
Message-ID: <a44ae5cd0504051825101e2d5f@mail.gmail.com>
Date: Tue, 5 Apr 2005 21:25:08 -0400
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc2-mm1 -- arch/i386/lib/mmx.c:374: error: conflicting types for `mmx_clear_page' include/asm/mmx.h:11: error: previous declaration of `mmx_clear_page' make[1]: *** [arch/i386/lib/mmx.o] Error 1
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/lib/mmx.c:374: error: conflicting types for `mmx_clear_page'
include/asm/mmx.h:11: error: previous declaration of `mmx_clear_page'
make[1]: *** [arch/i386/lib/mmx.o] Error 1

CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=m
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m


Linux Monkey100 2.6.12-rc1-mm4 #8 PREEMPT Thu Mar 31 13:41:55 EST 2005
i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.28
pcmcia-cs              3.2.5
PPP                    2.4.3
nfs-utils              1.0.7
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   056
Modules Loaded         lp ipx p8022 psnap llc af_packet ndiswrapper
sata_nv ehci_hcd dm_mod autofs4 sd_mod sata_sil libata scsi_mod 3c59x
forcedeth floppy parport_pc parport eth1394 evdev psmouse ohci1394
ieee1394 ohci_hcd uhci_hcd usbcore pcmcia firmware_class yenta_socket
rsrc_nonstatic pcmcia_core video thermal processor hotkey fan button
battery ac ide_cd cdrom
