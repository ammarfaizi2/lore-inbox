Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267527AbRGSK6l>; Thu, 19 Jul 2001 06:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267532AbRGSK6b>; Thu, 19 Jul 2001 06:58:31 -0400
Received: from gec.gecpalau.com ([206.49.60.67]:55045 "EHLO gec.gecpalau.com")
	by vger.kernel.org with ESMTP id <S267527AbRGSK6W>;
	Thu, 19 Jul 2001 06:58:22 -0400
From: root <ernfran@gecpalau.com>
To: linux-kernel@vger.kernel.org
Subject: Errors on compiling kernel with iomega buz support
Date: Thu, 19 Jul 2001 19:59:28 +0900
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01071919592800.16303@rieacs1.gecpalau.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi all,

Any ideas when this thing will be fixed in the kernel?

Thanks,

Ernie 

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
buz.c: In function `zr36057_init':
buz.c:3215: too few arguments to function `video_register_device_R32dcfedb'
make[3]: *** [buz.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.6/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.6/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.6/drivers'
make: *** [_mod_drivers] Error 2
