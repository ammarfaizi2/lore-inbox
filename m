Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSKKXvb>; Mon, 11 Nov 2002 18:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSKKXvb>; Mon, 11 Nov 2002 18:51:31 -0500
Received: from pointblue.com.pl ([62.121.131.135]:25863 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S262871AbSKKXv2>;
	Mon, 11 Nov 2002 18:51:28 -0500
Subject: Re: second error, bttv 2.5.47
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel-list <linux-kernel@vger.kernel.org>
In-Reply-To: <slrnasva6g.c13.kraxel@bytesex.org>
References: <1036990995.24251.7.camel@flat41> 
	<slrnasva6g.c13.kraxel@bytesex.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 11 Nov 2002 23:44:28 +0000
Message-Id: <1037058270.15197.2.camel@flat41>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 12:55, Gerd Knorr wrote:
> >  drivers/media/video/bttv-cards.c: In function `miro_pinnacle_gpio':
> >  drivers/media/video/bttv-cards.c:1742: `AUDC_CONFIG_PINNACLE' undeclared
> >  (first use in this function)
> 
> Patches for this and other v4l issues are available from
> 	http://bytesex.org/patches/2.5/

i applied patch-2.5.47-kraxel.gz, i guess it is cumulative patch
(contains all others).

i got this:

In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:29: linux/i2c-old.h: No such file or
directory
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:101: field `i2c' has incomplete type
drivers/media/video/zr36120.c: In function `zoran_muxsel':
drivers/media/video/zr36120.c:392: warning: implicit declaration of
function `i2c_control_device'
drivers/media/video/zr36120.c:392: `I2C_DRIVERID_VIDEODECODER'
undeclared (first use in this function)
drivers/media/video/zr36120.c:392: (Each undeclared identifier is
reported only once
drivers/media/video/zr36120.c:392: for each function it appears in.)
drivers/media/video/zr36120.c: In function `zoran_common_open':
drivers/media/video/zr36120.c:738: `I2C_DRIVERID_VIDEODECODER'
undeclared (first use in this function)
drivers/media/video/zr36120.c: In function `zoran_ioctl':
drivers/media/video/zr36120.c:1166: `I2C_DRIVERID_VIDEODECODER'
undeclared (first use in this function)
drivers/media/video/zr36120.c:1440: `I2C_DRIVERID_TUNER' undeclared
(first use in this function)
drivers/media/video/zr36120.c: At top level:
drivers/media/video/zr36120.c:1497: unknown field `open' specified in
initializer
drivers/media/video/zr36120.c:1497: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1498: unknown field `close' specified in
initializer
drivers/media/video/zr36120.c:1498: warning: initialization from
incompatible pointer type
drivers/media/video/zr36120.c:1499: unknown field `read' specified in
initializer
drivers/media/video/zr36120.c:1500: unknown field `write' specified in
initializer
drivers/media/video/zr36120.c:1500: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1501: unknown field `poll' specified in
initializer
drivers/media/video/zr36120.c:1501: warning: missing braces around
initializer
drivers/media/video/zr36120.c:1501: warning: (near initialization for
`zr36120_template.lock')
drivers/media/video/zr36120.c:1501: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1502: unknown field `ioctl' specified in
initializer
drivers/media/video/zr36120.c:1502: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1503: unknown field `mmap' specified in
initializer
drivers/media/video/zr36120.c:1503: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1504: unknown field `minor' specified in
initializer
drivers/media/video/zr36120.c:1504: warning: initialization makes
pointer from integer without a cast
drivers/media/video/zr36120.c:1833: unknown field `open' specified in
initializer
drivers/media/video/zr36120.c:1833: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1834: unknown field `close' specified in
initializer
drivers/media/video/zr36120.c:1834: warning: initialization from
incompatible pointer type
drivers/media/video/zr36120.c:1835: unknown field `read' specified in
initializer
drivers/media/video/zr36120.c:1836: unknown field `write' specified in
initializer
drivers/media/video/zr36120.c:1836: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1837: unknown field `poll' specified in
initializer
drivers/media/video/zr36120.c:1837: warning: missing braces around
initializer
drivers/media/video/zr36120.c:1837: warning: (near initialization for
`vbi_template.lock')
drivers/media/video/zr36120.c:1837: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1838: unknown field `ioctl' specified in
initializer
drivers/media/video/zr36120.c:1838: warning: initialization makes
integer from pointer without a cast
drivers/media/video/zr36120.c:1839: unknown field `minor' specified in
initializer
drivers/media/video/zr36120.c: In function `init_zoran':
drivers/media/video/zr36120.c:2013: warning: implicit declaration of
function `i2c_register_bus'
drivers/media/video/zr36120.c: In function `release_zoran':
drivers/media/video/zr36120.c:2047: warning: implicit declaration of
function `i2c_unregister_bus'
make[3]: *** [drivers/media/video/zr36120.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2


i disabled zr36120 in configuration and got this one:


drivers/media/video/saa7111.c:37: linux/i2c-old.h: No such file or
directory
drivers/media/video/saa7111.c: In function `saa7111_write':
drivers/media/video/saa7111.c:70: warning: implicit declaration of
function `LOCK_I2C_BUS'
drivers/media/video/saa7111.c:71: warning: implicit declaration of
function `i2c_start'
drivers/media/video/saa7111.c:72: warning: implicit declaration of
function `i2c_sendbyte'
drivers/media/video/saa7111.c:76: warning: implicit declaration of
function `i2c_stop'
drivers/media/video/saa7111.c:77: warning: implicit declaration of
function `UNLOCK_I2C_BUS'
drivers/media/video/saa7111.c: In function `saa7111_read':
drivers/media/video/saa7111.c:118: warning: implicit declaration of
function `i2c_readbyte'
drivers/media/video/saa7111.c: At top level:
drivers/media/video/saa7111.c:126: warning: `struct i2c_device' declared
inside parameter list
drivers/media/video/saa7111.c:126: warning: its scope is only this
definition or declaration, which is probably not what you want.
drivers/media/video/saa7111.c: In function `saa7111_attach':
drivers/media/video/saa7111.c:164: dereferencing pointer to incomplete
type
drivers/media/video/saa7111.c:172: dereferencing pointer to incomplete
type
drivers/media/video/saa7111.c:173: dereferencing pointer to incomplete
type
drivers/media/video/saa7111.c:174: dereferencing pointer to incomplete
type
drivers/media/video/saa7111.c:186: dereferencing pointer to incomplete
type
drivers/media/video/saa7111.c:189: dereferencing pointer to incomplete
type
drivers/media/video/saa7111.c:129: warning: `decoder' might be used
uninitialized in this function
drivers/media/video/saa7111.c: At top level:
drivers/media/video/saa7111.c:195: warning: `struct i2c_device' declared
inside parameter list
drivers/media/video/saa7111.c: In function `saa7111_detach':
drivers/media/video/saa7111.c:197: dereferencing pointer to incomplete
type
drivers/media/video/saa7111.c: At top level:
drivers/media/video/saa7111.c:203: warning: `struct i2c_device' declared
inside parameter list
drivers/media/video/saa7111.c: In function `saa7111_command':
drivers/media/video/saa7111.c:205: dereferencing pointer to incomplete
type
drivers/media/video/saa7111.c:217: dereferencing pointer to incomplete
type
drivers/media/video/saa7111.c: At top level:
drivers/media/video/saa7111.c:427: variable `i2c_driver_saa7111' has
initializer but incomplete type
drivers/media/video/saa7111.c:428: warning: excess elements in struct
initializer
drivers/media/video/saa7111.c:428: warning: (near initialization for
`i2c_driver_saa7111')
drivers/media/video/saa7111.c:429: `I2C_DRIVERID_VIDEODECODER'
undeclared here (not in a function)
drivers/media/video/saa7111.c:429: warning: excess elements in struct
initializer
drivers/media/video/saa7111.c:429: warning: (near initialization for
`i2c_driver_saa7111')
drivers/media/video/saa7111.c:430: warning: excess elements in struct
initializer
drivers/media/video/saa7111.c:430: warning: (near initialization for
`i2c_driver_saa7111')
drivers/media/video/saa7111.c:430: warning: excess elements in struct
initializer
drivers/media/video/saa7111.c:430: warning: (near initialization for
`i2c_driver_saa7111')
drivers/media/video/saa7111.c:432: warning: excess elements in struct
initializer
drivers/media/video/saa7111.c:432: warning: (near initialization for
`i2c_driver_saa7111')
drivers/media/video/saa7111.c:433: warning: excess elements in struct
initializer
drivers/media/video/saa7111.c:433: warning: (near initialization for
`i2c_driver_saa7111')
drivers/media/video/saa7111.c:435: warning: excess elements in struct
initializer
drivers/media/video/saa7111.c:435: warning: (near initialization for
`i2c_driver_saa7111')
drivers/media/video/saa7111.c: In function `saa7111_init':
drivers/media/video/saa7111.c:439: warning: implicit declaration of
function `i2c_register_driver'
drivers/media/video/saa7111.c: In function `saa7111_exit':
drivers/media/video/saa7111.c:444: warning: implicit declaration of
function `i2c_unregister_driver'
make[3]: *** [drivers/media/video/saa7111.o] Error 1
make[2]: *** [drivers/media/video] Error 2

i am missing some form of readme on this page with patch :/


-- 
Greg Iaskievitch

