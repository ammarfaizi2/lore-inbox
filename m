Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbSJVBhG>; Mon, 21 Oct 2002 21:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSJVBhG>; Mon, 21 Oct 2002 21:37:06 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:19184 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S261911AbSJVBhE>; Mon, 21 Oct 2002 21:37:04 -0400
Date: Mon, 21 Oct 2002 21:35:32 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.44 : remove STATIC static ?
Message-ID: <Pine.LNX.4.44.0210212131210.900-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following files contain:

#define STATIC static

arch/arm/boot/compressed/misc.c
arch/cris/boot/compressed/misc.c
arch/i386/boot/compressed/misc.c
arch/sh/boot/compressed/misc.c
arch/x86_64/boot/compressed/misc.c
drivers/net/irda/donauboe.c
drivers/scsi/53c700.c
drivers/scsi/NCR_D700.c
drivers/scsi/advansys.c
fs/xfs/linux/xfs_linux.h
init/do_mounts.c

Is this macro really needed (for some reason that escapes me), or can we 
remove this macro? It seems to serve as to 'hide' a common keyword. 

Regards,
Frank  

