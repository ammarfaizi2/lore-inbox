Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTE0Myl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTE0Myl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:54:41 -0400
Received: from tomts19-srv.bellnexxia.net ([209.226.175.73]:49645 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263528AbTE0MyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:54:08 -0400
Date: Tue, 27 May 2003 09:05:55 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.70, drivers/media/video build errors
Message-ID: <Pine.LNX.4.44.0305270904430.7293-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  CC      drivers/media/video/zr36120.o
drivers/media/video/zr36120.c:42:19: tuner.h: No such file or directory
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or directory
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:101: field `i2c' has incomplete type
drivers/media/video/zr36120.c: In function `zoran_muxsel':
drivers/media/video/zr36120.c:392: warning: implicit declaration of function `i2c_control_device'
drivers/media/video/zr36120.c:392: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36120.c:392: (Each undeclared identifier is reported only once
drivers/media/video/zr36120.c:392: for each function it appears in.)
drivers/media/video/zr36120.c: In function `zoran_common_open':
drivers/media/video/zr36120.c:738: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36120.c: In function `zoran_ioctl':
drivers/media/video/zr36120.c:1164: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36120.c:1438: `I2C_DRIVERID_TUNER' undeclared (first use in this function)
drivers/media/video/zr36120.c:1438: `TUNER_SET_TVFREQ' undeclared (first use in this function)
drivers/media/video/zr36120.c: At top level:
drivers/media/video/zr36120.c:1495: unknown field `open' specified in initializer
drivers/media/video/zr36120.c:1495: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1496: unknown field `close' specified in initializer
drivers/media/video/zr36120.c:1496: warning: initialization from incompatible pointer type
drivers/media/video/zr36120.c:1497: unknown field `read' specified in initializer
drivers/media/video/zr36120.c:1498: unknown field `write' specified in initializer
drivers/media/video/zr36120.c:1498: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1499: unknown field `poll' specified in initializer
drivers/media/video/zr36120.c:1499: warning: missing braces around initializer
drivers/media/video/zr36120.c:1499: warning: (near initialization for `zr36120_template.lock')
drivers/media/video/zr36120.c:1499: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1500: unknown field `ioctl' specified in initializer
drivers/media/video/zr36120.c:1500: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1500: initializer element is not computable at load time
drivers/media/video/zr36120.c:1500: (near initialization for `zr36120_template.devfs_name[0]')
drivers/media/video/zr36120.c:1501: initializer element is not constant
drivers/media/video/zr36120.c:1501: (near initialization for `zr36120_template.devfs_name')
drivers/media/video/zr36120.c:1501: unknown field `mmap' specified in initializer
drivers/media/video/zr36120.c:1501: warning: excess elements in struct initializer
drivers/media/video/zr36120.c:1501: warning: (near initialization for `zr36120_template')
drivers/media/video/zr36120.c:1829: unknown field `open' specified in initializer
drivers/media/video/zr36120.c:1829: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1830: unknown field `close' specified in initializer
drivers/media/video/zr36120.c:1830: warning: initialization from incompatible pointer type
drivers/media/video/zr36120.c:1831: unknown field `read' specified in initializer
drivers/media/video/zr36120.c:1832: unknown field `write' specified in initializer
drivers/media/video/zr36120.c:1832: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1833: unknown field `poll' specified in initializer
drivers/media/video/zr36120.c:1833: warning: missing braces around initializer
drivers/media/video/zr36120.c:1833: warning: (near initialization for `vbi_template.lock')
drivers/media/video/zr36120.c:1833: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1834: unknown field `ioctl' specified in initializer
drivers/media/video/zr36120.c:1834: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36120.c:1834: initializer element is not computable at load time
drivers/media/video/zr36120.c:1834: (near initialization for `vbi_template.devfs_name[0]')
drivers/media/video/zr36120.c:1835: initializer element is not constant
drivers/media/video/zr36120.c:1835: (near initialization for `vbi_template.devfs_name')
drivers/media/video/zr36120.c: In function `find_zoran':
drivers/media/video/zr36120.c:1869: warning: implicit declaration of function `request_irq'
drivers/media/video/zr36120.c: In function `init_zoran':
drivers/media/video/zr36120.c:2009: warning: implicit declaration of function `i2c_register_bus'
drivers/media/video/zr36120.c: In function `release_zoran':
drivers/media/video/zr36120.c:2040: warning: implicit declaration of function `free_irq'
drivers/media/video/zr36120.c:2043: warning: implicit declaration of function `i2c_unregister_bus'
include/linux/poll.h: At top level:
drivers/media/video/zr36120.c:62: warning: `zr36120_pci_tbl' defined but not used
make[3]: *** [drivers/media/video/zr36120.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2




  CC      drivers/media/video/zr36067.o
drivers/media/video/zr36067.c:65:27: linux/i2c-old.h: No such file or directory
In file included from drivers/media/video/zr36067.c:73:
drivers/media/video/zoran.h:222: field `i2c' has incomplete type
drivers/media/video/zr36067.c: In function `i2c_setlines':
drivers/media/video/zr36067.c:544: dereferencing pointer to incomplete type
drivers/media/video/zr36067.c: In function `i2c_getdataline':
drivers/media/video/zr36067.c:551: dereferencing pointer to incomplete type
drivers/media/video/zr36067.c: In function `attach_inform':
drivers/media/video/zr36067.c:558: dereferencing pointer to incomplete type
drivers/media/video/zr36067.c:561: dereferencing pointer to incomplete type
drivers/media/video/zr36067.c:562: dereferencing pointer to incomplete type
drivers/media/video/zr36067.c:572: dereferencing pointer to incomplete type
drivers/media/video/zr36067.c:577: dereferencing pointer to incomplete type
drivers/media/video/zr36067.c: At top level:
drivers/media/video/zr36067.c:591: variable `zoran_i2c_bus_template' has initializer but incomplete type
drivers/media/video/zr36067.c:592: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:592: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36067.c:593: `I2C_BUSID_BT848' undeclared here (not in a function)
drivers/media/video/zr36067.c:593: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:593: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36067.c:594: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:594: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36067.c:596: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:596: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36067.c:598: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:598: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36067.c:599: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:599: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36067.c:601: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:601: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36067.c:602: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:602: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36067.c:603: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:603: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36067.c:604: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:604: warning: (near initialization for `zoran_i2c_bus_template')
drivers/media/video/zr36067.c: In function `zr36057_enable_jpg':
drivers/media/video/zr36067.c:2323: warning: implicit declaration of function `i2c_control_device'
drivers/media/video/zr36067.c:2323: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36067.c:2323: (Each undeclared identifier is reported only once
drivers/media/video/zr36067.c:2323: for each function it appears in.)
drivers/media/video/zr36067.c:2325: `I2C_DRIVERID_VIDEOENCODER' undeclared (first use in this function)
drivers/media/video/zr36067.c: In function `error_handler':
drivers/media/video/zr36067.c:2762: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36067.c: At top level:
drivers/media/video/zr36067.c:2783: parse error before "zoran_irq"
drivers/media/video/zr36067.c:2784: warning: return type defaults to `int'
drivers/media/video/zr36067.c: In function `zoran_irq':
drivers/media/video/zr36067.c:2808: `IRQ_HANDLED' undeclared (first use in this function)
drivers/media/video/zr36067.c:3013: warning: implicit declaration of function `IRQ_RETVAL'
drivers/media/video/zr36067.c: In function `zoran_open':
drivers/media/video/zr36067.c:3268: structure has no member named `busy'
drivers/media/video/zr36067.c: In function `zoran_close':
drivers/media/video/zr36067.c:3317: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36067.c:3320: `I2C_DRIVERID_VIDEOENCODER' undeclared (first use in this function)
drivers/media/video/zr36067.c: In function `do_zoran_ioctl':
drivers/media/video/zr36067.c:3527: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36067.c:3534: `I2C_DRIVERID_VIDEOENCODER' undeclared (first use in this function)
drivers/media/video/zr36067.c: At top level:
drivers/media/video/zr36067.c:4403: unknown field `open' specified in initializer
drivers/media/video/zr36067.c:4403: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36067.c:4404: unknown field `close' specified in initializer
drivers/media/video/zr36067.c:4404: warning: initialization from incompatible pointer type
drivers/media/video/zr36067.c:4405: unknown field `read' specified in initializer
drivers/media/video/zr36067.c:4406: unknown field `write' specified in initializer
drivers/media/video/zr36067.c:4406: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36067.c:4407: unknown field `ioctl' specified in initializer
drivers/media/video/zr36067.c:4407: warning: missing braces around initializer
drivers/media/video/zr36067.c:4407: warning: (near initialization for `zoran_template.lock')
drivers/media/video/zr36067.c:4407: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36067.c:4408: unknown field `mmap' specified in initializer
drivers/media/video/zr36067.c:4408: warning: initialization makes integer from pointer without a cast
drivers/media/video/zr36067.c:4408: initializer element is not computable at load time
drivers/media/video/zr36067.c:4408: (near initialization for `zoran_template.devfs_name[0]')
drivers/media/video/zr36067.c:4409: initializer element is not constant
drivers/media/video/zr36067.c:4409: (near initialization for `zoran_template.devfs_name')
drivers/media/video/zr36067.c:4409: unknown field `initialize' specified in initializer
drivers/media/video/zr36067.c:4409: warning: excess elements in struct initializer
drivers/media/video/zr36067.c:4409: warning: (near initialization for `zoran_template')
drivers/media/video/zr36067.c: In function `zr36057_init':
drivers/media/video/zr36067.c:4550: warning: implicit declaration of function `i2c_unregister_bus'
drivers/media/video/zr36067.c:4563: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
drivers/media/video/zr36067.c:4567: `I2C_DRIVERID_VIDEOENCODER' undeclared (first use in this function)
drivers/media/video/zr36067.c: In function `release_dc10':
drivers/media/video/zr36067.c:4630: warning: implicit declaration of function `free_irq'
drivers/media/video/zr36067.c: In function `find_zr36057':
drivers/media/video/zr36067.c:4701: warning: implicit declaration of function `request_irq'
drivers/media/video/zr36067.c:4742: sizeof applied to an incomplete type
drivers/media/video/zr36067.c:4742: sizeof applied to an incomplete type
drivers/media/video/zr36067.c:4742: sizeof applied to an incomplete type
drivers/media/video/zr36067.c:4746: warning: implicit declaration of function `i2c_register_bus'
include/linux/ctype.h: At top level:
drivers/media/video/zr36067.c:591: storage size of `zoran_i2c_bus_template' isn't known
drivers/media/video/zr36067.c:245: warning: `zr36067_pci_tbl' defined but not used
make[3]: *** [drivers/media/video/zr36067.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2



rday

  

--

Robert P. J. Day
Eno River Technologies
Unix, Linux and Open Source training
Waterloo, Ontario

www.enoriver.com


