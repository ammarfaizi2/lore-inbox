Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288781AbSATW5P>; Sun, 20 Jan 2002 17:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288804AbSATW5G>; Sun, 20 Jan 2002 17:57:06 -0500
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:27661 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S288781AbSATW4v>;
	Sun, 20 Jan 2002 17:56:51 -0500
Date: Sun, 20 Jan 2002 17:45:04 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.3-pre2 : drivers/media/video/i2c-parport.c
Message-ID: <Pine.LNX.4.33.0201201741580.1332-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   While 'make modules', I received the following error:
Regards,
Frank

i2c-parport.c:23:27: linux/i2c-old.h: No such file or directory
i2c-parport.c:33: field `i2c' has incomplete type
i2c-parport.c: In function `i2c_setlines':
i2c-parport.c:45: dereferencing pointer to incomplete type
i2c-parport.c: In function `i2c_getdataline':
i2c-parport.c:52: dereferencing pointer to incomplete type
i2c-parport.c: At top level:
i2c-parport.c:56: variable `parport_i2c_bus_template' has initializer but incomplete type
i2c-parport.c:58: warning: excess elements in struct initializer
i2c-parport.c:58: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:59: `I2C_BUSID_PARPORT' undeclared here (not in a function)
i2c-parport.c:59: warning: excess elements in struct initializer
i2c-parport.c:59: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:60: warning: excess elements in struct initializer
i2c-parport.c:60: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:62: warning: excess elements in struct initializer
i2c-parport.c:62: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:64: warning: excess elements in struct initializer
i2c-parport.c:64: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:65: warning: excess elements in struct initializer
i2c-parport.c:65: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:67: warning: excess elements in struct initializer
i2c-parport.c:67: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:68: warning: excess elements in struct initializer
i2c-parport.c:68: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:69: warning: excess elements in struct initializer
i2c-parport.c:69: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:70: warning: excess elements in struct initializer
i2c-parport.c:70: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c: In function `i2c_parport_attach':
i2c-parport.c:88: warning: implicit declaration of function `i2c_register_bus'
i2c-parport.c: In function `i2c_parport_detach':
i2c-parport.c:106: warning: implicit declaration of function `i2c_unregister_bus'
make[3]: *** [i2c-parport.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

