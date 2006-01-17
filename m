Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWAQNPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWAQNPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWAQNPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:15:17 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:11732 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932325AbWAQNPQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:15:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LNzXg2i37Es9AFyGEAcOfepZ+NMKODQ634DS/Whv3qj/mA8dk+798gn+iHNBJbGbu9ulvlWOFPrkrJHh5jw0uyIKXvrWMNYl5VYOc2qSBIVQxVurjI/hbEmgu69jDz+pEH+KKOffFpePUPl6VJKHBTKoD/exhB3Z90eieVyB/8M=
Message-ID: <4c50d3ee0601170515m5a5fb502w@mail.gmail.com>
Date: Tue, 17 Jan 2006 14:15:13 +0100
From: =?ISO-8859-1?Q?Th=E9ophile_Helleboid_-_Chtitux?= 
	<chtitux@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bug in the new 2.6.16-rc1, without .conf file
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I've just download the linux-kernel 2.6.16-rc1.
I have downloaded it from
ftp://ftp.free.fr/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2 and I
have used ketchup to patch it.
I run make menuconfig and get :
chtituxx linux-2.6.15 # make menuconfig
scripts/kconfig/mconf arch/i386/Kconfig
#
# using defaults found in arch/i386/defconfig
#
arch/i386/defconfig:121:warning: trying to assign nonexistent symbol
HAVE_DEC_LOCK
arch/i386/defconfig:171:warning: trying to assign nonexistent symbol
PCI_USE_VECTOR
arch/i386/defconfig:173:warning: trying to assign nonexistent symbol PCI_NAMES
arch/i386/defconfig:216:warning: trying to assign nonexistent symbol
PARPORT_PC_CML1
arch/i386/defconfig:220:warning: trying to assign nonexistent symbol
PARPORT_OTHER
arch/i386/defconfig:247:warning: trying to assign nonexistent symbol
BLK_DEV_CARMEL
arch/i386/defconfig:268:warning: trying to assign nonexistent symbol
IDE_TASKFILE_IO
arch/i386/defconfig:287:warning: trying to assign nonexistent symbol
BLK_DEV_ADMA
arch/i386/defconfig:360:warning: trying to assign nonexistent symbol
SCSI_MEGARAID
arch/i386/defconfig:371:warning: trying to assign nonexistent symbol
SCSI_CPQFCTS
arch/i386/defconfig:392:warning: trying to assign nonexistent symbol
SCSI_QLOGIC_ISP
arch/i386/defconfig:395:warning: trying to assign nonexistent symbol
SCSI_QLA2XXX
arch/i386/defconfig:401:warning: trying to assign nonexistent symbol
SCSI_QLA6322
arch/i386/defconfig:455:warning: trying to assign nonexistent symbol
IEEE1394_CMP
arch/i386/defconfig:472:warning: trying to assign nonexistent symbol NETLINK_DEV
arch/i386/defconfig:506:warning: trying to assign nonexistent symbol
IP_NF_MATCH_LIMIT
arch/i386/defconfig:508:warning: trying to assign nonexistent symbol
IP_NF_MATCH_MAC
arch/i386/defconfig:509:warning: trying to assign nonexistent symbol
IP_NF_MATCH_PKTTYPE
arch/i386/defconfig:510:warning: trying to assign nonexistent symbol
IP_NF_MATCH_MARK
arch/i386/defconfig:517:warning: trying to assign nonexistent symbol
IP_NF_MATCH_LENGTH
arch/i386/defconfig:519:warning: trying to assign nonexistent symbol
IP_NF_MATCH_TCPMSS
arch/i386/defconfig:520:warning: trying to assign nonexistent symbol
IP_NF_MATCH_HELPER
arch/i386/defconfig:521:warning: trying to assign nonexistent symbol
IP_NF_MATCH_STATE
arch/i386/defconfig:522:warning: trying to assign nonexistent symbol
IP_NF_MATCH_CONNTRACK
arch/i386/defconfig:537:warning: trying to assign nonexistent symbol
IP_NF_TARGET_MARK
arch/i386/defconfig:538:warning: trying to assign nonexistent symbol
IP_NF_TARGET_CLASSIFY
arch/i386/defconfig:545:warning: trying to assign nonexistent symbol
IP_NF_TARGET_NOTRACK
arch/i386/defconfig:564:warning: trying to assign nonexistent symbol
NET_FASTROUTE
arch/i386/defconfig:565:warning: trying to assign nonexistent symbol
NET_HW_FLOWCONTROL
arch/i386/defconfig:715:warning: trying to assign nonexistent symbol
SOUND_GAMEPORT
arch/i386/defconfig:771:warning: trying to assign nonexistent symbol QIC02_TAPE
arch/i386/defconfig:807:warning: trying to assign nonexistent symbol DRM_GAMMA
arch/i386/defconfig:983:warning: trying to assign nonexistent symbol
USB_BLUETOOTH_TTY
arch/i386/defconfig:993:warning: trying to assign nonexistent symbol
USB_STORAGE_HP8200e
arch/i386/defconfig:1019:warning: trying to assign nonexistent symbol
USB_HPUSBSCSI
arch/i386/defconfig:1054:warning: trying to assign nonexistent symbol USB_TIGL
arch/i386/defconfig:1112:warning: trying to assign nonexistent symbol DEVFS_FS
arch/i386/defconfig:1113:warning: trying to assign nonexistent symbol
DEVPTS_FS_XATTR
arch/i386/defconfig:1241:warning: trying to assign nonexistent symbol
X86_STD_RESOURCES
arch/i386/defconfig:1242:warning: trying to assign nonexistent symbol PC
*

Your kernel configuration changes were NOT saved.

Makefile:477: .config: Aucun fichier ou répertoire de ce type
chtituxx linux-2.6.15 #

The interface of the config is here, but when I closed or I browse in
the config menu, I can see it.
After a "touch .config", there is no error.
make gconfig makes the same error ...
--
Chtitux -
Théophile Helleboid
