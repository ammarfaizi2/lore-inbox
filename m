Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbSJKKXA>; Fri, 11 Oct 2002 06:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262383AbSJKKXA>; Fri, 11 Oct 2002 06:23:00 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:21120 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262370AbSJKKW7> convert rfc822-to-8bit; Fri, 11 Oct 2002 06:22:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.41-mm3
Date: Fri, 11 Oct 2002 20:26:24 +1000
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210112026.24155.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile failure:

  gcc -Wp,-MD,fs/smbfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic 
-fomit-frame-pointer -nostdinc -iwithprefix include  -DSMBFS_PARANOIA  
-DKBUILD_BASENAME=inode   -c -o fs/smbfs/inode.o fs/smbfs/inode.c
fs/smbfs/inode.c: In function `smb_show_options':
fs/smbfs/inode.c:436: `CONFIG_NLS_DEFAULT' undeclared (first use in this 
function)
fs/smbfs/inode.c:436: (Each undeclared identifier is reported only once
fs/smbfs/inode.c:436: for each function it appears in.)
fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:536: `CONFIG_NLS_DEFAULT' undeclared (first use in this 
function)

