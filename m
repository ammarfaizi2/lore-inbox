Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUAZHKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 02:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUAZHKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 02:10:40 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:37596 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262030AbUAZHKf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 02:10:35 -0500
From: Marco Rebsamen <mrebsamen@swissonline.ch>
To: Christian <evil@g-house.de>
Subject: Re: Troubles Compiling 2.6.1 on SuSE 9
Date: Mon, 26 Jan 2004 08:14:43 +0100
User-Agent: KMail/1.5.4
References: <200401242137.34881.mrebsamen@swissonline.ch> <200401251427.02975.mrebsamen@swissonline.ch> <401444C6.3090602@g-house.de>
In-Reply-To: <401444C6.3090602@g-house.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401260814.43457.mrebsamen@swissonline.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 25. Januar 2004 23:35 schrieben Sie:
> Marco Rebsamen wrote:
> | bineo:/usr/src/linux-2.6.1 # LANG=C LC_ALL=C objcopy -O binary -R .note
> | -R .comment -S vmlinux arch/i386/boot/compressed/vmlinux.bin
> | Ungültiger Maschinenbefehl
>
> try with "export LANG=C && objcopy ...." to get english messages.
>
> also: what binutils (objcopy -V), gcc, make, etc.. do you use? have you
> bugged SuSE yet?
>
> Christian.

bineo:/home/mr # rpm -q binutils
binutils-2.14.90.0.5-43

bieno:/home/mr # objcopy -V
GNU objcopy 2.14.90.0.5 20030722 (SuSE Linux)
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.

bineo:/home/mr # gcc -v
Reading specs from /usr/lib/gcc-lib/i586-suse-linux/3.3.1/specs
Konfiguriert mit: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info --mandir=/usr/share/
man --libdir=/usr/lib --enable-languages=c,c++,f77,objc,java,ada 
--disable-checking --enable-libgcj --with-gxx-include-dir=/usr/include/g++ 
--with-slibdir=/lib --with-system-zlib --enable-shared --enable-__cxa_atexit 
i586-suse-linux
Thread model: posix
gcc-Version 3.3.1 (SuSE Linux)
wave-master:/home/mr # make -v
GNU Make 3.80
Copyright (C) 2002  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A

but the rpoblem with objcopy are solved. It was damaged. I reinstalled the 
binutils package and it worked. Now i got problems with the modules.
PARTICULAR PURPOSE.

