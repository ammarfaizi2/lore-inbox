Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136230AbREJMpm>; Thu, 10 May 2001 08:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136227AbREJMpc>; Thu, 10 May 2001 08:45:32 -0400
Received: from [212.105.219.1] ([212.105.219.1]:13652 "EHLO ddd.de")
	by vger.kernel.org with ESMTP id <S136202AbREJMpV>;
	Thu, 10 May 2001 08:45:21 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Nico Blanke <blanke@ddd.de>
To: linux-kernel@vger.kernel.org
Subject: Compiler-Error
Date: Thu, 10 May 2001 16:44:48 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01051016444800.11128@php-tux>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there !

I'm not able to compile linux 2.4.4, because i get the following 
compiler-error :


buz.c: In function `v4l_fbuffer_alloc':
buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:188: (Each undeclared identifier is reported only once
buz.c:188: for each function it appears in.)
buz.c: In function `jpg_fbuffer_alloc':
buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:256: warning: `alloc_contig' might be used uninitialized in this 
function
buz.c: In function `jpg_fbuffer_free':
buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:316: warning: `alloc_contig' might be used uninitialized in this 
function
buz.c: In function `zoran_ioctl':
buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in this function)
make[3]: *** [buz.o] Error 1
make[3]: Leaving directory `/home/blanke/linux/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory `/home/blanke/linux/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory `/home/blanke/linux/drivers'
make: *** [_mod_drivers] Error 2





-- 
	Best regards,

		Nico Blanke

--
DDD Design				Fon : 	++49 40 27 88 37-0
Gesellschaft für Multimedia mbH		Fax :	++49 40 27 88 37-300
Jarrestrasse 46				eMail:	blanke@ddd.de
22303 Hamburg				http://www.ddd.de
--
