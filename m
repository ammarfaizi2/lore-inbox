Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279927AbRKBCDI>; Thu, 1 Nov 2001 21:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279928AbRKBCC6>; Thu, 1 Nov 2001 21:02:58 -0500
Received: from zok.sgi.com ([204.94.215.101]:17372 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S279927AbRKBCCu>;
	Thu, 1 Nov 2001 21:02:50 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: FORT David <popo.enlighted@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.4.13 
In-Reply-To: Your message of "Fri, 02 Nov 2001 01:52:32 CDT."
             <3BE242B0.1010400@free.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Nov 2001 13:02:40 +1100
Message-ID: <3358.1004666560@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Nov 2001 01:52:32 -0500, 
FORT David <popo.enlighted@free.fr> wrote:
>Keith Owens wrote:
>>modinfo `modprobe -l` | sed -ne '/^filename/h; /^license.*none/{g;p;}'
>>lists all modules without a license, please report so it can be fixed.

/lib/modules/2.4.13/kernel/... modules without license, from David Fort.

drivers/block/loop.o - has MODULE_LICENSE("GPL") in -AC tree
drivers/media/video/cpia.o - in -AC tree
drivers/media/video/cpia_usb.o - in -AC tree
drivers/media/video/mod_quickcam.o - add on module, contact the maintainers
drivers/net/pppoe.o - in -AC tree
drivers/net/pppox.o - in -AC tree
drivers/video/matrox/matroxfb_crtc2.o - no license, needs patch
drivers/video/matrox/matroxfb_g450.o - no license, needs patch
drivers/video/matrox/matroxfb_maven.o - no license, needs patch
drivers/video/matrox/matroxfb_misc.o - no license, needs patch
fs/coda/coda.o - no license, needs patch
fs/msdos/msdos.o - no license, needs patch
fs/nfs/nfs.o - in -AC tree
fs/nls/nls_big5.o - no license, needs patch
fs/nls/nls_cp936.o - no license, needs patch
fs/nls/nls_cp950.o - no license, needs patch
fs/nls/nls_gb2312.o - no license, needs patch
fs/nls/nls_iso8859-1.o - no license, needs patch
fs/nls/nls_iso8859-15.o - no license, needs patch
fs/nls/nls_iso8859-2.o - no license, needs patch
fs/nls/nls_iso8859-4.o - no license, needs patch
fs/nls/nls_utf8.o - no license, needs patch
fs/vfat/vfat.o - no license, needs patch
net/khttpd/khttpd.o - no license, needs patch
net/netlink/netlink_dev.o - no license, needs patch

