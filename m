Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288859AbSATRde>; Sun, 20 Jan 2002 12:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288784AbSATRdR>; Sun, 20 Jan 2002 12:33:17 -0500
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:55303 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S288859AbSATRdE>;
	Sun, 20 Jan 2002 12:33:04 -0500
Date: Sun, 20 Jan 2002 12:21:15 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.3-pre2: drivers/ieee1394/video1394.c error
Message-ID: <Pine.LNX.4.33.0201201219080.12390-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While 'make modules', I received the following error:
Regards,
Frank

video1394.c: In function `do_iso_mmap':
video1394.c:831: warning: passing arg 1 of `remap_page_range_Rsmp_94f2c3fc' makes pointer from integer without a cast
video1394.c:831: incompatible type for argument 4 of `remap_page_range_Rsmp_94f2c3fc'
video1394.c:831: too few arguments to function `remap_page_range_Rsmp_94f2c3fc'
video1394.c: In function `video1394_ioctl':
video1394.c:853: invalid operands to binary &
video1394.c:863: invalid operands to binary &
video1394.c: In function `video1394_mmap':
video1394.c:1331: invalid operands to binary &
video1394.c:1340: invalid operands to binary &
video1394.c: In function `video1394_open':
video1394.c:1360: invalid operands to binary &
video1394.c: In function `video1394_release':
video1394.c:1400: invalid operands to binary &
video1394.c:1409: invalid operands to binary &
make[2]: *** [video1394.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/ieee1394'
make[1]: *** [_modsubdir_ieee1394] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

