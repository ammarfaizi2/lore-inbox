Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267150AbSKMJg5>; Wed, 13 Nov 2002 04:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbSKMJg5>; Wed, 13 Nov 2002 04:36:57 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:4481 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267150AbSKMJgk>; Wed, 13 Nov 2002 04:36:40 -0500
Message-Id: <4.3.2.7.2.20021113091351.00b51c90@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 13 Nov 2002 10:43:33 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Linux 2.5.47-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To keep you all busy :-)


In file included from drivers/block/DAC960.c:49:
drivers/block/DAC960.h:2572:2: #error I am a non-portable driver, please 
convert me to use the Documentation/DMA-mapping.txt interfaces
In file included from drivers/block/DAC960.c:49:
drivers/block/DAC960.h: In function `DAC960_BA_WriteHardwareMailbox':
drivers/block/DAC960.h:2846: warning: implicit declaration of function 
`Virtual_to_Bus32'
drivers/block/DAC960.c: In function `DAC960_V2_GeneralInfo':
drivers/block/DAC960.c:656: warning: implicit declaration of function 
`Virtual_to_Bus64'
drivers/block/DAC960.c: In function `DAC960_V1_ProcessCompletedCommand':
drivers/block/DAC960.c:3102: warning: implicit declaration of function 
`Bus32_to_Virtual'
drivers/block/DAC960.c:3102: warning: passing arg 2 of `__constant_memcpy' 
makes pointer from integer without a cast
drivers/block/DAC960.c:3102: warning: passing arg 2 of `__memcpy' makes 
pointer from integer without a cast
drivers/block/DAC960.c:3107: warning: passing arg 2 of `__constant_memcpy' 
makes pointer from integer without a cast
drivers/block/DAC960.c:3107: warning: passing arg 2 of `__memcpy' makes 
pointer from integer without a cast
drivers/block/DAC960.c: In function `DAC960_P_InterruptHandler':
drivers/block/DAC960.c:5038: warning: passing arg 1 of 
`DAC960_P_To_PD_TranslateEnquiry' makes pointer from integer without a cast
drivers/block/DAC960.c:5044: warning: passing arg 1 of 
`DAC960_P_To_PD_TranslateDeviceState' makes pointer from integer without a cast
make[2]: *** [drivers/block/DAC960.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2


drivers/char/cyclades.c:887: parse error before '}' token
drivers/char/cyclades.c:3437:24: warning: multi-line string literals are 
deprecated
make[2]: *** [drivers/char/cyclades.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

drivers/char/istallion.c:801: parse error before '}' token
drivers/char/istallion.c: In function `stli_hostcmd':
drivers/char/istallion.c:3006: warning: implicit declaration of function 
`schedule_task'
make[2]: *** [drivers/char/istallion.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

In file included from drivers/char/riscom8.c:51:
drivers/char/riscom8.h:88: field `tqueue' has incomplete type
drivers/char/riscom8.h:89: field `tqueue_hangup' has incomplete type
drivers/char/riscom8.c:84: warning: type defaults to `int' in declaration 
of `DECLARE_TASK_QUEUE'
drivers/char/riscom8.c:84: warning: parameter names (without types) in 
function declaration
drivers/char/riscom8.c: In function `rc_mark_event':
drivers/char/riscom8.c:351: warning: implicit declaration of function 
`queue_task'
drivers/char/riscom8.c:351: `tq_riscom' undeclared (first use in this function)
drivers/char/riscom8.c:351: (Each undeclared identifier is reported only once
drivers/char/riscom8.c:351: for each function it appears in.)
drivers/char/riscom8.c:352: warning: implicit declaration of function `mark_bh'
drivers/char/riscom8.c:352: `RISCOM8_BH' undeclared (first use in this 
function)
drivers/char/riscom8.c: In function `rc_receive_exc':
drivers/char/riscom8.c:435: structure has no member named `tqueue'
drivers/char/riscom8.c:435: `tq_timer' undeclared (first use in this function)
drivers/char/riscom8.c: In function `rc_receive':
drivers/char/riscom8.c:466: structure has no member named `tqueue'
drivers/char/riscom8.c:466: `tq_timer' undeclared (first use in this function)
drivers/char/riscom8.c: In function `rc_check_modem':
drivers/char/riscom8.c:556: warning: implicit declaration of function 
`schedule_task'
drivers/char/riscom8.c: In function `do_riscom_bh':
drivers/char/riscom8.c:1725: warning: implicit declaration of function 
`run_task_queue'
drivers/char/riscom8.c:1725: `tq_riscom' undeclared (first use in this 
function)
drivers/char/riscom8.c: In function `rc_init_drivers':
drivers/char/riscom8.c:1754: warning: implicit declaration of function 
`init_bh'
drivers/char/riscom8.c:1754: `RISCOM8_BH' undeclared (first use in this 
function)
drivers/char/riscom8.c: In function `rc_release_drivers':
drivers/char/riscom8.c:1833: warning: implicit declaration of function 
`remove_bh'
drivers/char/riscom8.c:1833: `RISCOM8_BH' undeclared (first use in this 
function)
drivers/char/riscom8.c: At top level:
drivers/char/riscom8.c:84: warning: `DECLARE_TASK_QUEUE' declared `static' 
but never defined
make[2]: *** [drivers/char/riscom8.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

drivers/char/isicom.c:87: warning: type defaults to `int' in declaration of 
`DECLARE_TASK_QUEUE'
drivers/char/isicom.c:87: warning: parameter names (without types) in 
function declaration
drivers/char/isicom.c:87: warning: data definition has no type or storage class
drivers/char/isicom.c: In function `schedule_bh':
drivers/char/isicom.c:363: warning: implicit declaration of function 
`queue_task'
drivers/char/isicom.c:363: `tq_isicom' undeclared (first use in this function)
drivers/char/isicom.c:363: (Each undeclared identifier is reported only once
drivers/char/isicom.c:363: for each function it appears in.)
drivers/char/isicom.c:364: warning: implicit declaration of function `mark_bh'
drivers/char/isicom.c:364: `ISICOM_BH' undeclared (first use in this function)
drivers/char/isicom.c: In function `do_isicom_bh':
drivers/char/isicom.c:492: warning: implicit declaration of function 
`run_task_queue'
drivers/char/isicom.c:492: `tq_isicom' undeclared (first use in this function)
drivers/char/isicom.c: In function `isicom_interrupt':
drivers/char/isicom.c:593: warning: implicit declaration of function 
`schedule_task'
drivers/char/isicom.c:661: structure has no member named `tqueue'
drivers/char/isicom.c:661: `tq_timer' undeclared (first use in this function)
drivers/char/isicom.c:699: structure has no member named `tqueue'
drivers/char/isicom.c: In function `isicom_init':
drivers/char/isicom.c:1890: warning: implicit declaration of function `init_bh'
drivers/char/isicom.c:1890: `ISICOM_BH' undeclared (first use in this function)
drivers/char/isicom.c:1906: structure has no member named `routine'
drivers/char/isicom.c:1908: structure has no member named `routine'
drivers/char/isicom.c: In function `cleanup_module':
drivers/char/isicom.c:2040: warning: implicit declaration of function 
`remove_bh'
drivers/char/isicom.c:2040: `ISICOM_BH' undeclared (first use in this function)
make[2]: *** [drivers/char/isicom.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

drivers/char/esp.c:110: warning: type defaults to `int' in declaration of 
`DECLARE_TASK_QUEUE'
drivers/char/esp.c:110: warning: parameter names (without types) in 
function declaration
drivers/char/esp.c: In function `rs_sched_event':
drivers/char/esp.c:281: warning: implicit declaration of function `queue_task'
drivers/char/esp.c:281: `tq_esp' undeclared (first use in this function)
drivers/char/esp.c:281: (Each undeclared identifier is reported only once
drivers/char/esp.c:281: for each function it appears in.)
drivers/char/esp.c:282: warning: implicit declaration of function `mark_bh'
drivers/char/esp.c:282: `ESP_BH' undeclared (first use in this function)
drivers/char/esp.c: In function `receive_chars_pio':
drivers/char/esp.c:377: structure has no member named `tqueue'
drivers/char/esp.c:377: `tq_timer' undeclared (first use in this function)
drivers/char/esp.c: In function `receive_chars_dma_done':
drivers/char/esp.c:452: structure has no member named `tqueue'
drivers/char/esp.c:452: `tq_timer' undeclared (first use in this function)
drivers/char/esp.c: In function `check_modem_status':
drivers/char/esp.c:647: warning: implicit declaration of function 
`schedule_task'
drivers/char/esp.c: In function `do_serial_bh':
drivers/char/esp.c:775: warning: implicit declaration of function 
`run_task_queue'
drivers/char/esp.c:775: `tq_esp' undeclared (first use in this function)
drivers/char/esp.c: In function `espserial_init':
drivers/char/esp.c:2514: warning: implicit declaration of function `init_bh'
drivers/char/esp.c:2514: `ESP_BH' undeclared (first use in this function)
drivers/char/esp.c:2644: structure has no member named `routine'
drivers/char/esp.c:2646: structure has no member named `routine'
drivers/char/esp.c: In function `espserial_exit':
drivers/char/esp.c:2718: warning: implicit declaration of function `remove_bh'
drivers/char/esp.c:2718: `ESP_BH' undeclared (first use in this function)
drivers/char/esp.c: At top level:
drivers/char/esp.c:110: warning: `DECLARE_TASK_QUEUE' declared `static' but 
never defined
make[2]: *** [drivers/char/esp.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

drivers/isdn/i4l/isdn_net_lib.c: In function `isdn_net_lib_init':
drivers/isdn/i4l/isdn_net_lib.c:2330: `isdn_x25_ops' undeclared (first use 
in this function)
drivers/isdn/i4l/isdn_net_lib.c:2330: (Each undeclared identifier is 
reported only once
drivers/isdn/i4l/isdn_net_lib.c:2330: for each function it appears in.)
make[3]: *** [drivers/isdn/i4l/isdn_net_lib.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2

drivers/isdn/i4l/isdn_common.c: In function `map_drvname':
drivers/isdn/i4l/isdn_common.c:1978: structure has no member named `drvid'
drivers/isdn/i4l/isdn_common.c: In function `map_namedrv':
drivers/isdn/i4l/isdn_common.c:1985: structure has no member named `drvid'
drivers/isdn/i4l/isdn_common.c: In function `isdn_register_divert':
drivers/isdn/i4l/isdn_common.c:2007: `isdn_command' undeclared (first use 
in this function)
drivers/isdn/i4l/isdn_common.c:2007: (Each undeclared identifier is 
reported only once
drivers/isdn/i4l/isdn_common.c:2007: for each function it appears in.)
make[3]: *** [drivers/isdn/i4l/isdn_common.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2

In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or directory
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:101: field `i2c' has incomplete type
drivers/media/video/zr36120.c: In function `zoran_muxsel':
drivers/media/video/zr36120.c:392: warning: implicit declaration of 
function `i2c_control_device'
drivers/media/video/zr36120.c:392: `I2C_DRIVERID_VIDEODECODER' undeclared 
(first use in this function)
drivers/media/video/zr36120.c:392: (Each undeclared identifier is reported 
only once
drivers/media/video/zr36120.c:392: for each function it appears in.)
drivers/media/video/zr36120.c: In function `zoran_common_open':
drivers/media/video/zr36120.c:738: `I2C_DRIVERID_VIDEODECODER' undeclared 
(first use in this function)
drivers/media/video/zr36120.c: In function `zoran_ioctl':
drivers/media/video/zr36120.c:1166: `I2C_DRIVERID_VIDEODECODER' undeclared 
(first use in this function)
drivers/media/video/zr36120.c:1440: `I2C_DRIVERID_TUNER' undeclared (first 
use in this function)
drivers/media/video/zr36120.c: At top level:
drivers/media/video/zr36120.c:1497: unknown field `open' specified in 
initializer
drivers/media/video/zr36120.c:1497: warning: initialization makes integer 
from pointer without a cast
drivers/media/video/zr36120.c:1498: unknown field `close' specified in 
initializer
drivers/media/video/zr36120.c:1498: warning: initialization from 
incompatible pointer type
drivers/media/video/zr36120.c:1499: unknown field `read' specified in 
initializer
drivers/media/video/zr36120.c:1500: unknown field `write' specified in 
initializer
drivers/media/video/zr36120.c:1500: warning: initialization makes integer 
from pointer without a cast
drivers/media/video/zr36120.c:1501: unknown field `poll' specified in 
initializer
drivers/media/video/zr36120.c:1501: warning: missing braces around initializer
drivers/media/video/zr36120.c:1501: warning: (near initialization for 
`zr36120_template.lock')
drivers/media/video/zr36120.c:1501: warning: initialization makes integer 
from pointer without a cast
drivers/media/video/zr36120.c:1502: unknown field `ioctl' specified in 
initializer
drivers/media/video/zr36120.c:1502: warning: initialization from 
incompatible pointer type
drivers/media/video/zr36120.c:1503: unknown field `mmap' specified in 
initializer
drivers/media/video/zr36120.c:1503: warning: excess elements in struct 
initializer
drivers/media/video/zr36120.c:1503: warning: (near initialization for 
`zr36120_template')
drivers/media/video/zr36120.c:1833: unknown field `open' specified in 
initializer
drivers/media/video/zr36120.c:1833: warning: initialization makes integer 
from pointer without a cast
drivers/media/video/zr36120.c:1834: unknown field `close' specified in 
initializer
drivers/media/video/zr36120.c:1834: warning: initialization from 
incompatible pointer type
drivers/media/video/zr36120.c:1835: unknown field `read' specified in 
initializer
drivers/media/video/zr36120.c:1836: unknown field `write' specified in 
initializer
drivers/media/video/zr36120.c:1836: warning: initialization makes integer 
from pointer without a cast
drivers/media/video/zr36120.c:1837: unknown field `poll' specified in 
initializer
drivers/media/video/zr36120.c:1837: warning: missing braces around initializer
drivers/media/video/zr36120.c:1837: warning: (near initialization for 
`vbi_template.lock')
drivers/media/video/zr36120.c:1837: warning: initialization makes integer 
from pointer without a cast
drivers/media/video/zr36120.c:1838: unknown field `ioctl' specified in 
initializer
drivers/media/video/zr36120.c:1838: warning: initialization from 
incompatible pointer type
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

drivers/media/video/saa7111.c:37:27: linux/i2c-old.h: No such file or directory
drivers/media/video/saa7111.c: In function `saa7111_write':
drivers/media/video/saa7111.c:70: warning: implicit declaration of function 
`LOCK_I2C_BUS'
drivers/media/video/saa7111.c:71: warning: implicit declaration of function 
`i2c_start'
drivers/media/video/saa7111.c:72: warning: implicit declaration of function 
`i2c_sendbyte'
drivers/media/video/saa7111.c:76: warning: implicit declaration of function 
`i2c_stop'
drivers/media/video/saa7111.c:77: warning: implicit declaration of function 
`UNLOCK_I2C_BUS'
drivers/media/video/saa7111.c: In function `saa7111_read':
drivers/media/video/saa7111.c:118: warning: implicit declaration of 
function `i2c_readbyte'
drivers/media/video/saa7111.c: At top level:
drivers/media/video/saa7111.c:126: warning: `struct i2c_device' declared 
inside parameter list
drivers/media/video/saa7111.c:126: warning: its scope is only this 
definition or declaration, which is probably not what you want
drivers/media/video/saa7111.c: In function `saa7111_attach':
drivers/media/video/saa7111.c:164: dereferencing pointer to incomplete type
drivers/media/video/saa7111.c:172: dereferencing pointer to incomplete type
drivers/media/video/saa7111.c:173: dereferencing pointer to incomplete type
drivers/media/video/saa7111.c:174: dereferencing pointer to incomplete type
drivers/media/video/saa7111.c:186: dereferencing pointer to incomplete type
drivers/media/video/saa7111.c:189: dereferencing pointer to incomplete type
drivers/media/video/saa7111.c: At top level:
drivers/media/video/saa7111.c:195: warning: `struct i2c_device' declared 
inside parameter list
drivers/media/video/saa7111.c: In function `saa7111_detach':
drivers/media/video/saa7111.c:197: dereferencing pointer to incomplete type
drivers/media/video/saa7111.c: At top level:
drivers/media/video/saa7111.c:203: warning: `struct i2c_device' declared 
inside parameter list
drivers/media/video/saa7111.c: In function `saa7111_command':
drivers/media/video/saa7111.c:205: dereferencing pointer to incomplete type
drivers/media/video/saa7111.c:217: dereferencing pointer to incomplete type
drivers/media/video/saa7111.c: At top level:
drivers/media/video/saa7111.c:427: variable `i2c_driver_saa7111' has 
initializer but incomplete type
drivers/media/video/saa7111.c:428: warning: excess elements in struct 
initializer
drivers/media/video/saa7111.c:428: warning: (near initialization for 
`i2c_driver_saa7111')
drivers/media/video/saa7111.c:429: `I2C_DRIVERID_VIDEODECODER' undeclared 
here (not in a function)
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
drivers/media/video/saa7111.c: At top level:
drivers/media/video/saa7111.c:427: storage size of `i2c_driver_saa7111' 
isn't known
make[3]: *** [drivers/media/video/saa7111.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

drivers/message/i2o/i2o_lan.c:28:2: #error Please convert me to 
Documentation/DMA-mapping.txt
drivers/message/i2o/i2o_lan.c:120: parse error before "struct"
drivers/message/i2o/i2o_lan.c: In function `i2o_lan_receive_post_reply':
drivers/message/i2o/i2o_lan.c:385: `run_i2o_post_buckets_task' undeclared 
(first use in this function)
drivers/message/i2o/i2o_lan.c:385: (Each undeclared identifier is reported 
only once
drivers/message/i2o/i2o_lan.c:385: for each function it appears in.)
drivers/message/i2o/i2o_lan.c: In function `i2o_lan_register_device':
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1407: structure has no member named `sync'
make[3]: *** [drivers/message/i2o/i2o_lan.o] Error 1
make[2]: *** [drivers/message/i2o] Error 2
make[1]: *** [drivers/message] Error 2
make: *** [drivers] Error 2

drivers/net/fc/iph5526.c:226: warning: initialization from incompatible 
pointer type
drivers/net/fc/iph5526.c:3895: conflicting types for `iph5526_biosparam'
drivers/net/fc/iph5526_scsi.h:28: previous declaration of `iph5526_biosparam'
drivers/net/fc/iph5526.c: In function `add_to_sest':
drivers/net/fc/iph5526.c:4284: structure has no member named `address'
drivers/net/fc/iph5526.c:4384: structure has no member named `address'
drivers/net/fc/iph5526.c:4393: structure has no member named `address'
drivers/net/fc/iph5526.c:4399: structure has no member named `address'
make[3]: *** [drivers/net/fc/iph5526.o] Error 1
make[2]: *** [drivers/net/fc] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

drivers/net/wan/sdlamain.c:244: warning: type defaults to `int' in 
declaration of `DECLARE_TASK_QUEUE'
drivers/net/wan/sdlamain.c:244: warning: parameter names (without types) in 
function declaration
drivers/net/wan/sdlamain.c:244: warning: data definition has no type or 
storage class
drivers/net/wan/sdlamain.c:245: variable `wanpipe_tq_task' has initializer 
but incomplete type
drivers/net/wan/sdlamain.c:247: unknown field `routine' specified in 
initializer
drivers/net/wan/sdlamain.c:247: warning: excess elements in struct initializer
drivers/net/wan/sdlamain.c:247: warning: (near initialization for 
`wanpipe_tq_task')
drivers/net/wan/sdlamain.c:248: unknown field `data' specified in initializer
drivers/net/wan/sdlamain.c:249: `wanpipe_tq_custom' undeclared here (not in 
a function)
drivers/net/wan/sdlamain.c:249: warning: excess elements in struct initializer
drivers/net/wan/sdlamain.c:249: warning: (near initialization for 
`wanpipe_tq_task')
drivers/net/wan/sdlamain.c: In function `check_s508_conflicts':
drivers/net/wan/sdlamain.c:647: warning: passing arg 2 of 
`constant_test_bit' from incompatible pointer type
drivers/net/wan/sdlamain.c:647: warning: passing arg 2 of 
`variable_test_bit' from incompatible pointer type
drivers/net/wan/sdlamain.c: In function `check_s514_conflicts':
drivers/net/wan/sdlamain.c:741: warning: passing arg 2 of 
`constant_test_bit' from incompatible pointer type
drivers/net/wan/sdlamain.c:741: warning: passing arg 2 of 
`variable_test_bit' from incompatible pointer type
drivers/net/wan/sdlamain.c: In function `run_wanpipe_tq':
drivers/net/wan/sdlamain.c:1289: `task_queue' undeclared (first use in this 
function)
drivers/net/wan/sdlamain.c:1289: (Each undeclared identifier is reported 
only once
drivers/net/wan/sdlamain.c:1289: for each function it appears in.)
drivers/net/wan/sdlamain.c:1289: `tq_queue' undeclared (first use in this 
function)
drivers/net/wan/sdlamain.c:1289: parse error before ')' token
drivers/net/wan/sdlamain.c:1292: warning: implicit declaration of function 
`run_task_queue'
drivers/net/wan/sdlamain.c: In function `wanpipe_queue_tq':
drivers/net/wan/sdlamain.c:1302: warning: implicit declaration of function 
`queue_task'
drivers/net/wan/sdlamain.c:1302: `wanpipe_tq_custom' undeclared (first use 
in this function)
drivers/net/wan/sdlamain.c: In function `wanpipe_mark_bh':
drivers/net/wan/sdlamain.c:1309: `tq_immediate' undeclared (first use in 
this function)
drivers/net/wan/sdlamain.c:1310: warning: implicit declaration of function 
`mark_bh'
drivers/net/wan/sdlamain.c:1310: `IMMEDIATE_BH' undeclared (first use in 
this function)
drivers/net/wan/sdlamain.c: In function `wakeup_sk_bh':
drivers/net/wan/sdlamain.c:1319: warning: passing arg 2 of 
`constant_test_bit' from incompatible pointer type
drivers/net/wan/sdlamain.c:1319: warning: passing arg 2 of 
`variable_test_bit' from incompatible pointer type
include/net/route.h: At top level:
drivers/net/wan/sdlamain.c:245: storage size of `wanpipe_tq_task' isn't known
make[3]: *** [drivers/net/wan/sdlamain.o] Error 1
make[2]: *** [drivers/net/wan] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

drivers/net/rrunner.c:24:2: #error Please convert me to 
Documentation/DMA-mapping.txt

drivers/net/rcpci45.c:47:2: #error Please convert me to 
Documentation/DMA-mapping.txt

drivers/net/defxx.c:202:2: #error Please convert me to 
Documentation/DMA-mapping.txt
In file included from drivers/net/defxx.c:226:
drivers/net/defxx.h:1677:1: warning: "ALIGN" redefined
In file included from include/asm/processor.h:17,
                  from include/asm/thread_info.h:14,
                  from include/linux/thread_info.h:11,
                  from include/linux/spinlock.h:12,
                  from include/linux/module.h:11,
                  from drivers/net/defxx.c:206:
include/linux/cache.h:7:1: warning: this is the location of the previous 
definition
make[2]: *** [drivers/net/defxx.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

drivers/scsi/pci2000.c: In function `Pci2000_QueueCommand':
drivers/scsi/pci2000.c:508: structure has no member named `address'
drivers/scsi/pci2000.c:531: structure has no member named `address'
drivers/scsi/pci2000.c: At top level:
drivers/scsi/pci2000.c:855: warning: initialization from incompatible 
pointer type
drivers/scsi/pci2000.c:855: warning: initialization from incompatible 
pointer type
make[2]: *** [drivers/scsi/pci2000.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

drivers/scsi/pci2220i.c:37:2: #error Convert me to understand page+offset 
based scatterlists
drivers/scsi/pci2220i.c: In function `WalkScatGath':
drivers/scsi/pci2220i.c:467: structure has no member named `address'
drivers/scsi/pci2220i.c: In function `Pci2220i_QueueCommand':
drivers/scsi/pci2220i.c:2053: structure has no member named `address'
drivers/scsi/pci2220i.c: At top level:
drivers/scsi/pci2220i.c:2922: warning: initialization from incompatible 
pointer type
drivers/scsi/pci2220i.c:2922: warning: initialization from incompatible 
pointer type
make[2]: *** [drivers/scsi/pci2220i.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

drivers/scsi/dpt_i2o.c:31:2: #error Please convert me to 
Documentation/DMA-mapping.txt
drivers/scsi/dpt_i2o.c: In function `adpt_i2o_delete_hba':
drivers/scsi/dpt_i2o.c:1036: sizeof applied to an incomplete type
drivers/scsi/dpt_i2o.c: In function `adpt_i2o_post_wait':
drivers/scsi/dpt_i2o.c:1137: warning: operation on `adpt_post_wait_id' may 
be undefined
drivers/scsi/dpt_i2o.c: In function `adpt_scsi_to_i2o':
drivers/scsi/dpt_i2o.c:2134: `Cmnd' undeclared (first use in this function)
drivers/scsi/dpt_i2o.c:2134: (Each undeclared identifier is reported only once
drivers/scsi/dpt_i2o.c:2134: for each function it appears in.)
drivers/scsi/dpt_i2o.c:2142: warning: implicit declaration of function 
`sg_dma_length'
drivers/scsi/dpt_i2o.c:2144: warning: implicit declaration of function 
`sg_dmap_address'
drivers/scsi/dpt_i2o.c:2071: warning: unused variable `rcode'
drivers/scsi/dpt_i2o.c: In function `adpt_i2o_to_scsi':
drivers/scsi/dpt_i2o.c:2237: `Cmnd' undeclared (first use in this function)
drivers/scsi/dpt_i2o.c: In function `adpt_i2o_init_outbound_q':
drivers/scsi/dpt_i2o.c:2738: parse error before "pHba"
drivers/scsi/dpt_i2o.c:2746: `dma' undeclared (first use in this function)
drivers/scsi/dpt_i2o.c:2671: warning: unused variable `outbound_frame'
drivers/scsi/dpt_i2o.c: In function `adpt_i2o_status_get':
drivers/scsi/dpt_i2o.c:2775: warning: left-hand operand of comma expression 
has no effect
drivers/scsi/dpt_i2o.c:2775: parse error before ';' token
drivers/scsi/dpt_i2o.c:2769: warning: unused variable `timeout'
drivers/scsi/dpt_i2o.c:2770: warning: unused variable `m'
drivers/scsi/dpt_i2o.c:2771: warning: unused variable `msg'
drivers/scsi/dpt_i2o.c:2772: warning: unused variable `status_block'
drivers/scsi/dpt_i2o.c: At top level:
drivers/scsi/dpt_i2o.c:2781: parse error before numeric constant
drivers/scsi/dpt_i2o.c:2782: warning: type defaults to `int' in declaration 
of `status_block'
drivers/scsi/dpt_i2o.c:2782: `pHba' undeclared here (not in a function)
drivers/scsi/dpt_i2o.c:2782: warning: data definition has no type or 
storage class
drivers/scsi/dpt_i2o.c:2784: warning: type defaults to `int' in declaration 
of `timeout'
drivers/scsi/dpt_i2o.c:2784: initializer element is not constant
drivers/scsi/dpt_i2o.c:2784: warning: data definition has no type or 
storage class
drivers/scsi/dpt_i2o.c:2785: parse error before "do"
drivers/scsi/dpt_i2o.c:2787: warning: type defaults to `int' in declaration 
of `m'
drivers/scsi/dpt_i2o.c:2787: `pHba' undeclared here (not in a function)
drivers/scsi/dpt_i2o.c:2787: warning: data definition has no type or 
storage class
drivers/scsi/dpt_i2o.c:2788: parse error before "if"
drivers/scsi/dpt_i2o.c:2798: warning: type defaults to `int' in declaration 
of `msg'
drivers/scsi/dpt_i2o.c:2798: `pHba' undeclared here (not in a function)
drivers/scsi/dpt_i2o.c:2798: warning: data definition has no type or 
storage class
drivers/scsi/dpt_i2o.c:2800: parse error before "volatile"
drivers/scsi/dpt_i2o.c:2801: parse error before "volatile"
drivers/scsi/dpt_i2o.c:2802: parse error before "volatile"
drivers/scsi/dpt_i2o.c:2803: parse error before "volatile"
drivers/scsi/dpt_i2o.c:2804: parse error before "volatile"
drivers/scsi/dpt_i2o.c:2805: parse error before "volatile"
drivers/scsi/dpt_i2o.c:2806: parse error before "volatile"
drivers/scsi/dpt_i2o.c:2807: parse error before "volatile"
drivers/scsi/dpt_i2o.c:2808: parse error before "volatile"
drivers/scsi/dpt_i2o.c:2811: parse error before "volatile"
make[2]: *** [drivers/scsi/dpt_i2o.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

drivers/scsi/tmscsim.c: In function `DC390_waiting_timed_out':
drivers/scsi/tmscsim.c:1073: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c:1077: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c: In function `dc390_BuildSRB':
drivers/scsi/tmscsim.c:1145: structure has no member named `address'
In file included from drivers/scsi/tmscsim.c:1824:
drivers/scsi/scsiiom.c:9:2: #error Please convert me to 
Documentation/DMA-mapping.txt
In file included from drivers/scsi/tmscsim.c:1824:
drivers/scsi/scsiiom.c: In function `DC390_Interrupt':
drivers/scsi/scsiiom.c:267: `DC390_LOCK_IO' undeclared (first use in this 
function)
drivers/scsi/scsiiom.c:267: (Each undeclared identifier is reported only once
drivers/scsi/scsiiom.c:267: for each function it appears in.)
drivers/scsi/scsiiom.c:343: `DC390_UNLOCK_IO' undeclared (first use in this 
function)
drivers/scsi/scsiiom.c:229: warning: unused variable `iflags'
In file included from drivers/scsi/tmscsim.c:1824:
drivers/scsi/scsiiom.c: In function `dc390_DataOut_0':
drivers/scsi/scsiiom.c:384: structure has no member named `address'
In file included from drivers/scsi/tmscsim.c:1824:
drivers/scsi/scsiiom.c: In function `dc390_DataIn_0':
drivers/scsi/scsiiom.c:448: structure has no member named `address'
In file included from drivers/scsi/tmscsim.c:1824:
drivers/scsi/scsiiom.c: In function `dc390_restore_ptr':
drivers/scsi/scsiiom.c:747: structure has no member named `address'
drivers/scsi/scsiiom.c:761: structure has no member named `address'
drivers/scsi/scsiiom.c:764: structure has no member named `address'
In file included from drivers/scsi/tmscsim.c:1824:
drivers/scsi/scsiiom.c: In function `dc390_DataIO_Comm':
drivers/scsi/scsiiom.c:898: structure has no member named `address'
In file included from drivers/scsi/tmscsim.c:1824:
drivers/scsi/scsiiom.c: In function `dc390_SRBdone':
drivers/scsi/scsiiom.c:1373: structure has no member named `address'
drivers/scsi/scsiiom.c:1448: structure has no member named `address'
drivers/scsi/scsiiom.c:1523: structure has no member named `address'
In file included from drivers/scsi/tmscsim.c:1824:
drivers/scsi/scsiiom.c: In function `dc390_RequestSense':
drivers/scsi/scsiiom.c:1764: structure has no member named `address'
drivers/scsi/tmscsim.c: In function `dc390_inquiry':
drivers/scsi/tmscsim.c:2402: request for member `rq_status' in something 
not a structure or union
drivers/scsi/tmscsim.c: In function `dc390_sendstart':
drivers/scsi/tmscsim.c:2452: request for member `rq_status' in something 
not a structure or union
drivers/scsi/tmscsim.c: In function `dc390_set_info':
drivers/scsi/tmscsim.c:2559: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c:2608: `p' undeclared (first use in this function)
drivers/scsi/tmscsim.c:2634: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2636: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2654: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2657: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2660: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2672: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2685: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2723: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c:2730: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c:2740: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c:2748: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c:2754: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2762: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c:2768: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2777: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c:2784: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2792: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c:2799: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2808: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c:2816: request for member `pScsiHost' in something 
not a structure or union
drivers/scsi/tmscsim.c: At top level:
drivers/scsi/tmscsim.c:3058: warning: initialization from incompatible 
pointer type
drivers/scsi/tmscsim.c:3058: warning: initialization from incompatible 
pointer type
make[2]: *** [drivers/scsi/tmscsim.o] Error 1

drivers/scsi/AM53C974.c:1:2: #error Please convert me to 
Documentation/DMA-mapping.txt
drivers/scsi/AM53C974.c: In function `AM53C974_print':
drivers/scsi/AM53C974.c:513: warning: implicit declaration of function 
`save_flags'
drivers/scsi/AM53C974.c:514: warning: implicit declaration of function `cli'
drivers/scsi/AM53C974.c:532: warning: implicit declaration of function 
`restore_flags'
drivers/scsi/AM53C974.c:507: warning: `flags' might be used uninitialized 
in this function
drivers/scsi/AM53C974.c: In function `AM53C974_keywait':
drivers/scsi/AM53C974.c:554: warning: `flags' might be used uninitialized 
in this function
drivers/scsi/AM53C974.c: In function `AM53C974_init':
drivers/scsi/AM53C974.c:739: structure has no member named `next'
drivers/scsi/AM53C974.c: In function `initialize_SCp':
drivers/scsi/AM53C974.c:845: structure has no member named `address'
drivers/scsi/AM53C974.c: In function `AM53C974_main':
drivers/scsi/AM53C974.c:970: structure has no member named `next'
drivers/scsi/AM53C974.c: In function `AM53C974_intr':
drivers/scsi/AM53C974.c:1048: structure has no member named `next'
drivers/scsi/AM53C974.c: In function `AM53C974_information_transfer':
drivers/scsi/AM53C974.c:1559: structure has no member named `address'
drivers/scsi/AM53C974.c: At top level:
drivers/scsi/AM53C974.c:2456: warning: initialization from incompatible 
pointer type
drivers/scsi/AM53C974.c:2456: warning: initialization from incompatible 
pointer type
make[2]: *** [drivers/scsi/AM53C974.o] Error 1

drivers/scsi/gdth.c:298:2: #error Please convert me to 
Documentation/DMA-mapping.txt
In file included from drivers/scsi/gdth.c:703:
drivers/scsi/gdth_proc.c: In function `gdth_do_cmd':
drivers/scsi/gdth_proc.c:1269: request for member `rq_status' in something 
not a structure or union
drivers/scsi/gdth_proc.c:1271: request for member `waiting' in something 
not a structure or union
drivers/scsi/gdth_proc.c: In function `gdth_scsi_done':
drivers/scsi/gdth_proc.c:1291: request for member `rq_status' in something 
not a structure or union
drivers/scsi/gdth_proc.c:1294: request for member `waiting' in something 
not a structure or union
drivers/scsi/gdth_proc.c:1295: request for member `waiting' in something 
not a structure or union
In file included from drivers/scsi/gdth.c:703:
drivers/scsi/gdth_proc.c:1393:38: macro "GDTH_LOCK_SCSI_DONE" requires 2 
arguments, but only 1 given
drivers/scsi/gdth_proc.c: In function `gdth_wait_completion':
drivers/scsi/gdth_proc.c:1393: `GDTH_LOCK_SCSI_DONE' undeclared (first use 
in this function)
drivers/scsi/gdth_proc.c:1393: (Each undeclared identifier is reported only 
once
drivers/scsi/gdth_proc.c:1393: for each function it appears in.)
drivers/scsi/gdth_proc.c:1395: `dev' undeclared (first use in this function)
drivers/scsi/gdth.c: In function `gdth_copy_internal_data':
drivers/scsi/gdth.c:2632: structure has no member named `address'
drivers/scsi/gdth.c:2632: structure has no member named `address'
drivers/scsi/gdth.c: In function `gdth_fill_cache_cmd':
drivers/scsi/gdth.c:2807: structure has no member named `address'
drivers/scsi/gdth.c: In function `gdth_fill_raw_cmd':
drivers/scsi/gdth.c:2924: structure has no member named `address'
drivers/scsi/gdth.c:3345:46: macro "GDTH_UNLOCK_SCSI_DONE" passed 2 
arguments, but takes just 1
drivers/scsi/gdth.c: In function `gdth_interrupt':
drivers/scsi/gdth.c:3345: `GDTH_UNLOCK_SCSI_DONE' undeclared (first use in 
this function)
drivers/scsi/gdth.c: At top level:
drivers/scsi/gdth.c:4717: warning: initialization from incompatible pointer 
type
drivers/scsi/gdth.c:4717: warning: initialization from incompatible pointer 
type
make[2]: *** [drivers/scsi/gdth.o] Error 1

drivers/scsi/ini9100u.c:111:2: #error Please convert me to 
Documentation/DMA-mapping.txt
drivers/scsi/ini9100u.c:145: unknown field `next' specified in initializer
drivers/scsi/ini9100u.c:145: warning: initialization from incompatible 
pointer type
drivers/scsi/ini9100u.c:145: warning: initialization from incompatible 
pointer type
drivers/scsi/ini9100u.c: In function `i91uBuildSCB':
drivers/scsi/ini9100u.c:493: structure has no member named `address'
drivers/scsi/ini9100u.c:502: structure has no member named `address'
make[2]: *** [drivers/scsi/ini9100u.o] Error 1

drivers/video/pm2fb.c:258: field `gen' has incomplete type
drivers/video/pm2fb.c:403: variable `pm2fb_hwswitch' has initializer but 
incomplete type
drivers/video/pm2fb.c:404: warning: excess elements in struct initializer
drivers/video/pm2fb.c:404: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:404: warning: excess elements in struct initializer
drivers/video/pm2fb.c:404: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:404: warning: excess elements in struct initializer
drivers/video/pm2fb.c:404: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:405: warning: excess elements in struct initializer
drivers/video/pm2fb.c:405: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:405: warning: excess elements in struct initializer
drivers/video/pm2fb.c:405: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:405: warning: excess elements in struct initializer
drivers/video/pm2fb.c:405: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:406: warning: excess elements in struct initializer
drivers/video/pm2fb.c:406: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:406: warning: excess elements in struct initializer
drivers/video/pm2fb.c:406: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:407: warning: excess elements in struct initializer
drivers/video/pm2fb.c:407: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:408: warning: excess elements in struct initializer
drivers/video/pm2fb.c:408: warning: (near initialization for `pm2fb_hwswitch')
drivers/video/pm2fb.c:417: unknown field `fb_get_fix' specified in initializer
drivers/video/pm2fb.c:417: `fbgen_get_fix' undeclared here (not in a function)
drivers/video/pm2fb.c:417: initializer element is not constant
drivers/video/pm2fb.c:417: (near initialization for `pm2fb_ops.fb_open')
drivers/video/pm2fb.c:418: unknown field `fb_get_var' specified in initializer
drivers/video/pm2fb.c:418: `fbgen_get_var' undeclared here (not in a function)
drivers/video/pm2fb.c:418: initializer element is not constant
drivers/video/pm2fb.c:418: (near initialization for `pm2fb_ops.fb_release')
drivers/video/pm2fb.c:419: `fbgen_set_var' undeclared here (not in a function)
drivers/video/pm2fb.c:419: initializer element is not constant
drivers/video/pm2fb.c:419: (near initialization for `pm2fb_ops.fb_set_var')
drivers/video/pm2fb.c:420: `fbgen_get_cmap' undeclared here (not in a function)
drivers/video/pm2fb.c:420: initializer element is not constant
drivers/video/pm2fb.c:420: (near initialization for `pm2fb_ops.fb_get_cmap')
drivers/video/pm2fb.c:421: `fbgen_set_cmap' undeclared here (not in a function)
drivers/video/pm2fb.c:421: initializer element is not constant
drivers/video/pm2fb.c:421: (near initialization for `pm2fb_ops.fb_set_cmap')
drivers/video/pm2fb.c:422: `fbgen_pan_display' undeclared here (not in a 
function)
drivers/video/pm2fb.c:422: initializer element is not constant
drivers/video/pm2fb.c:422: (near initialization for `pm2fb_ops.fb_pan_display')
drivers/video/pm2fb.c:424: `fbgen_blank' undeclared here (not in a function)
drivers/video/pm2fb.c:424: initializer element is not constant
drivers/video/pm2fb.c:424: (near initialization for `pm2fb_ops.fb_blank')
drivers/video/pm2fb.c: In function `reset_units':
drivers/video/pm2fb.c:988: `PM2R_RASTERIZER_MODE' undeclared (first use in 
this function)
drivers/video/pm2fb.c:988: (Each undeclared identifier is reported only once
drivers/video/pm2fb.c:988: for each function it appears in.)
drivers/video/pm2fb.c:989: `PM2R_DELTA_MODE' undeclared (first use in this 
function)
drivers/video/pm2fb.c:989: `PM2F_DELTA_ORDER_RGB' undeclared (first use in 
this function)
drivers/video/pm2fb.c: In function `pm2fb_set_disp':
drivers/video/pm2fb.c:1975: structure has no member named `screen_base'
drivers/video/pm2fb.c: In function `pm2fb_cleanup':
drivers/video/pm2fb.c:2232: `info' undeclared (first use in this function)
drivers/video/pm2fb.c: In function `pm2fb_init':
drivers/video/pm2fb.c:2278: `fbgen_switch' undeclared (first use in this 
function)
drivers/video/pm2fb.c:2279: `fbgen_update_var' undeclared (first use in 
this function)
drivers/video/pm2fb.c:2281: warning: implicit declaration of function 
`fbgen_get_var'
drivers/video/pm2fb.c:2282: warning: implicit declaration of function 
`fbgen_do_set_var'
drivers/video/pm2fb.c:2283: warning: implicit declaration of function 
`fbgen_set_disp'
drivers/video/pm2fb.c:2284: warning: implicit declaration of function 
`fbgen_install_cmap'
drivers/video/pm2fb.c: At top level:
drivers/video/pm2fb.c:403: storage size of `pm2fb_hwswitch' isn't known
make[2]: *** [drivers/video/pm2fb.o] Error 1

drivers/video/pm3fb.c:137: field `gen' has incomplete type
drivers/video/pm3fb.c:684: variable `pm3fb_switch' has initializer but 
incomplete type
drivers/video/pm3fb.c:685: warning: excess elements in struct initializer
drivers/video/pm3fb.c:685: warning: (near initialization for `pm3fb_switch')
drivers/video/pm3fb.c:685: warning: excess elements in struct initializer
drivers/video/pm3fb.c:685: warning: (near initialization for `pm3fb_switch')
drivers/video/pm3fb.c:685: warning: excess elements in struct initializer
drivers/video/pm3fb.c:685: warning: (near initialization for `pm3fb_switch')
drivers/video/pm3fb.c:685: warning: excess elements in struct initializer
drivers/video/pm3fb.c:685: warning: (near initialization for `pm3fb_switch')
drivers/video/pm3fb.c:686: warning: excess elements in struct initializer
drivers/video/pm3fb.c:686: warning: (near initialization for `pm3fb_switch')
drivers/video/pm3fb.c:686: warning: excess elements in struct initializer
drivers/video/pm3fb.c:686: warning: (near initialization for `pm3fb_switch')
drivers/video/pm3fb.c:686: warning: excess elements in struct initializer
drivers/video/pm3fb.c:686: warning: (near initialization for `pm3fb_switch')
drivers/video/pm3fb.c:687: warning: excess elements in struct initializer
drivers/video/pm3fb.c:687: warning: (near initialization for `pm3fb_switch')
drivers/video/pm3fb.c:687: warning: excess elements in struct initializer
drivers/video/pm3fb.c:687: warning: (near initialization for `pm3fb_switch')
drivers/video/pm3fb.c:688: warning: excess elements in struct initializer
drivers/video/pm3fb.c:688: warning: (near initialization for `pm3fb_switch')
drivers/video/pm3fb.c:692: unknown field `fb_get_fix' specified in initializer
drivers/video/pm3fb.c:692: `fbgen_get_fix' undeclared here (not in a function)
drivers/video/pm3fb.c:692: initializer element is not constant
drivers/video/pm3fb.c:692: (near initialization for `pm3fb_ops.fb_open')
drivers/video/pm3fb.c:693: unknown field `fb_get_var' specified in initializer
drivers/video/pm3fb.c:693: `fbgen_get_var' undeclared here (not in a function)
drivers/video/pm3fb.c:693: initializer element is not constant
drivers/video/pm3fb.c:693: (near initialization for `pm3fb_ops.fb_release')
drivers/video/pm3fb.c:694: `fbgen_set_var' undeclared here (not in a function)
drivers/video/pm3fb.c:694: initializer element is not constant
drivers/video/pm3fb.c:694: (near initialization for `pm3fb_ops.fb_set_var')
drivers/video/pm3fb.c:695: `fbgen_get_cmap' undeclared here (not in a function)
drivers/video/pm3fb.c:695: initializer element is not constant
drivers/video/pm3fb.c:695: (near initialization for `pm3fb_ops.fb_get_cmap')
drivers/video/pm3fb.c:696: `fbgen_set_cmap' undeclared here (not in a function)
drivers/video/pm3fb.c:696: initializer element is not constant
drivers/video/pm3fb.c:696: (near initialization for `pm3fb_ops.fb_set_cmap')
drivers/video/pm3fb.c:698: `fbgen_pan_display' undeclared here (not in a 
function)
drivers/video/pm3fb.c:698: initializer element is not constant
drivers/video/pm3fb.c:698: (near initialization for `pm3fb_ops.fb_pan_display')
drivers/video/pm3fb.c:699: `fbgen_blank' undeclared here (not in a function)
drivers/video/pm3fb.c:699: initializer element is not constant
drivers/video/pm3fb.c:699: (near initialization for `pm3fb_ops.fb_blank')
drivers/video/pm3fb.c: In function `pm3fb_common_init':
drivers/video/pm3fb.c:1612: `fbgen_switch' undeclared (first use in this 
function)
drivers/video/pm3fb.c:1612: (Each undeclared identifier is reported only once
drivers/video/pm3fb.c:1612: for each function it appears in.)
drivers/video/pm3fb.c:1613: `fbgen_update_var' undeclared (first use in 
this function)
drivers/video/pm3fb.c:1621: warning: implicit declaration of function 
`fbgen_get_var'
drivers/video/pm3fb.c:1630: warning: implicit declaration of function 
`fbgen_do_set_var'
drivers/video/pm3fb.c:1633: warning: implicit declaration of function 
`fbgen_set_disp'
drivers/video/pm3fb.c: In function `pm3fb_set_disp':
drivers/video/pm3fb.c:3302: dereferencing pointer to incomplete type
drivers/video/pm3fb.c: In function `cleanup_module':
drivers/video/pm3fb.c:3819: warning: passing arg 2 of `__release_region' 
makes integer from pointer without a cast
drivers/video/pm3fb.c:3822: warning: passing arg 2 of `__release_region' 
makes integer from pointer without a cast
include/video/fbcon.h: At top level:
drivers/video/pm3fb.c:684: storage size of `pm3fb_switch' isn't known
make[2]: *** [drivers/video/pm3fb.o] Error 1

drivers/video/aty128fb.c:419: unknown field `fb_get_fix' specified in 
initializer
drivers/video/aty128fb.c:419: warning: initialization from incompatible 
pointer type
drivers/video/aty128fb.c:420: unknown field `fb_get_var' specified in 
initializer
drivers/video/aty128fb.c:420: warning: initialization from incompatible 
pointer type
drivers/video/aty128fb.c: In function `aty128fb_set_var':
drivers/video/aty128fb.c:1379: structure has no member named `visual'
drivers/video/aty128fb.c:1380: structure has no member named `type'
drivers/video/aty128fb.c:1381: structure has no member named `type_aux'
drivers/video/aty128fb.c:1382: structure has no member named `ypanstep'
drivers/video/aty128fb.c:1383: structure has no member named `ywrapstep'
drivers/video/aty128fb.c:1384: structure has no member named `line_length'
make[2]: *** [drivers/video/aty128fb.o] Error 1

drivers/video/radeonfb.c:605: unknown field `fb_get_fix' specified in 
initializer
drivers/video/radeonfb.c:605: warning: initialization from incompatible 
pointer type
drivers/video/radeonfb.c:606: unknown field `fb_get_var' specified in 
initializer
drivers/video/radeonfb.c:606: warning: initialization from incompatible 
pointer type
drivers/video/radeonfb.c: In function `radeon_set_dispsw':
drivers/video/radeonfb.c:1385: structure has no member named `type'
drivers/video/radeonfb.c:1386: structure has no member named `type_aux'
drivers/video/radeonfb.c:1387: structure has no member named `ypanstep'
drivers/video/radeonfb.c:1388: structure has no member named `ywrapstep'
drivers/video/radeonfb.c:1397: structure has no member named `visual'
drivers/video/radeonfb.c:1398: structure has no member named `line_length'
drivers/video/radeonfb.c:1405: structure has no member named `visual'
drivers/video/radeonfb.c:1406: structure has no member named `line_length'
drivers/video/radeonfb.c:1413: structure has no member named `visual'
drivers/video/radeonfb.c:1414: structure has no member named `line_length'
drivers/video/radeonfb.c:1421: structure has no member named `visual'
drivers/video/radeonfb.c:1422: structure has no member named `line_length'
drivers/video/radeonfb.c: In function `radeonfb_get_fix':
drivers/video/radeonfb.c:1514: structure has no member named `type'
drivers/video/radeonfb.c:1515: structure has no member named `type_aux'
drivers/video/radeonfb.c:1516: structure has no member named `visual'
drivers/video/radeonfb.c:1522: structure has no member named `line_length'
drivers/video/radeonfb.c: In function `radeonfb_set_var':
drivers/video/radeonfb.c:1578: structure has no member named `line_length'
drivers/video/radeonfb.c:1579: structure has no member named `visual'
drivers/video/radeonfb.c:1590: structure has no member named `line_length'
drivers/video/radeonfb.c:1591: structure has no member named `visual'
drivers/video/radeonfb.c:1606: structure has no member named `line_length'
drivers/video/radeonfb.c:1607: structure has no member named `visual'
drivers/video/radeonfb.c:1619: structure has no member named `line_length'
drivers/video/radeonfb.c:1620: structure has no member named `visual'
drivers/video/radeonfb.c: At top level:
drivers/video/radeonfb.c:2487: warning: `fbcon_radeon8' defined but not used
drivers/video/radeonfb.c:598: warning: `radeon_read_OF' declared `static' 
but never defined
drivers/video/radeonfb.c:1710: warning: `radeonfb_set_cmap' defined but not 
used
make[2]: *** [drivers/video/radeonfb.o] Error 1

