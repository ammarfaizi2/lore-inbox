Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTDGPSg (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTDGPSf (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:18:35 -0400
Received: from AStrasbourg-204-1-1-91.abo.wanadoo.fr ([80.15.166.91]:32734
	"EHLO kalman") by vger.kernel.org with ESMTP id S263445AbTDGPSd (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 11:18:33 -0400
Date: Mon, 7 Apr 2003 17:30:06 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.5.66 not compiling
Message-ID: <20030407153006.GC1088@adlp.org>
Reply-To: bboett@adlp.org
Mail-Followup-To: bboett@bboett.dyndns.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: bboett@bboett.dyndns.org (Bruno Boettcher)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i am running actually a 2.4.19 kernel, started the .config with my actual
one and run an make oldconfig over it....
but since i don't get 2.4.20 running satisfyingly on my Athlon, wanted
to give a 2.5 a chance....

the config was from stock debian kernel, and the modified one can be
found at http://bboett.dyndns.org/~bboett/linux-2.5.66.config

when trying to make a make bzImage i get :

make -f scripts/Makefile.build obj=fs/cramfs
  gcc -Wp,-MD,fs/cramfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=inode -DKBUILD_MODNAME=cramfs -c -o fs/cramfs/.tmp_inode.o fs/cramfs/inode.c
fs/cramfs/inode.c: In function `get_cramfs_inode':
fs/cramfs/inode.c:54: incompatible types in assignment
make[2]: *** [fs/cramfs/inode.o] Fehler 1


not the faintest idea on what did get wrong... so if someone has an
idea... i will take it :D 

please include me through CC when replying

-- 
ciao bboett
==============================================================
bboett@adlp.org
http://inforezo.u-strasbg.fr/~bboett
===============================================================
