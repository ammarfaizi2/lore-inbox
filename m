Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263757AbTKALmA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 06:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263758AbTKALmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 06:42:00 -0500
Received: from cmt-webdesign-gbr.de ([217.160.130.145]:43234 "EHLO
	p15103836.pureserver.info") by vger.kernel.org with ESMTP
	id S263757AbTKALl6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 06:41:58 -0500
From: Christoph Lehnberger <debian@internetists.de>
Reply-To: debian@internetists.de
Organization: internetists.de
To: linux-kernel@vger.kernel.org
Subject: [2.4.23-pre9] Compilation Error
Date: Sat, 1 Nov 2003 12:42:01 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200311011242.01886.debian@internetists.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,


i try to compile a new kernel for my notebook with a new (the old one works, 
but i can´t find it) config file, but i get an error at the compilation:

cc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=inode  -c -o inode.o inode.c
inode.c:968: error: redefinition of `iget4'
/usr/src/linux-2.4.22/include/linux/fs.h:1415: error: `iget4' previously 
defined here
make[3]: *** [inode.o] Fehler 1
make[3]: Leaving directory `/usr/src/linux-2.4.22/fs'
make[2]: *** [first_rule] Fehler 2
make[2]: Leaving directory `/usr/src/linux-2.4.22/fs'
make[1]: *** [_dir_fs] Fehler 2
make[1]: Leaving directory `/usr/src/linux-2.4.22'
make: *** [stamp-build] Fehler 2

The kernel-version is 2.4.23-pre9, the name of the directory is 2.4.22

Greetings from Germany

Christoph

