Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbTL3Aup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 19:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTL3Auo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 19:50:44 -0500
Received: from smtp1.libero.it ([193.70.192.51]:2808 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S264313AbTL3AuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 19:50:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16368.52302.736757.403219@gargle.gargle.HOWL>
Date: Tue, 30 Dec 2003 01:52:30 +0100
To: Duncan Sands <baldrick@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speedtouch for 2.6.0
In-Reply-To: <200312291804.40544.baldrick@free.fr>
References: <16366.61517.501828.389749@gargle.gargle.HOWL>
	<200312291714.10152.baldrick@free.fr>
	<16368.23199.717051.15982@gargle.gargle.HOWL>
	<200312291804.40544.baldrick@free.fr>
X-Mailer: VM 7.03 under Emacs 21.2.1
From: "Guldo K" <guldo@tiscali.it>
Reply-to: "Guldo K" <guldo@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands writes:
 > Yeah, I was a bit brief :)  Look in the top-level Makefile (in
 > speedbundle) to see how to compile.  The easiest thing to
 > do though is probably to use the attached top-level Makefile,
 > which is the same as the current one except that it doesn't
 > compile the kernel module.  I didn't test it but it should work.
 > 
 > Ciao,
 > 
 > Duncan.

I couldn't compile.
I get the output below.
What's wrong with me?

*Guldo*

cd linux-atm/src/lib && make
make[1]: Entering directory `/tmp/speedbundle-1.0/linux-atm/src/lib'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/tmp/speedbundle-1.0/linux-atm/src/lib'
cd ppp/pppd && make
make[1]: Entering directory `/tmp/speedbundle-1.0/ppp/pppd'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/tmp/speedbundle-1.0/ppp/pppd'
cd ppp/pppd/plugins && make C_INCLUDE_PATH=../../../linux-atm/src/include LIBRARY_PATH=../../../linux-atm/src/lib/.libs
make[1]: Entering directory `/tmp/speedbundle-1.0/ppp/pppd/plugins'
for d in rp-pppoe; do make -w -C $d all; done
make[2]: Entering directory `/tmp/speedbundle-1.0/ppp/pppd/plugins/rp-pppoe'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/tmp/speedbundle-1.0/ppp/pppd/plugins/rp-pppoe'
make[1]: Leaving directory `/tmp/speedbundle-1.0/ppp/pppd/plugins'
cd firmware && make
make[1]: Entering directory `/tmp/speedbundle-1.0/firmware'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/tmp/speedbundle-1.0/firmware'
cd firmware_loader && make
make[1]: Entering directory `/tmp/speedbundle-1.0/firmware_loader'
cd src && make 
make[2]: Entering directory `/tmp/speedbundle-1.0/firmware_loader/src'
gcc -Wall -I. -I/usr/include -I/usr/include -O2 -DVERSION=\"1.2-beta2\" -D_REENTRANT -D_THREAD_SAFE -o pusb.o -c pusb-linux.c
In file included from /usr/include/linux/usb.h:4,
                 from pusb-linux.c:42:
/usr/include/linux/mod_devicetable.h:18: error: syntax error before "__u32"
/usr/include/linux/mod_devicetable.h:20: error: syntax error before "class"
/usr/include/linux/mod_devicetable.h:21: error: syntax error before "driver_data"
/usr/include/linux/mod_devicetable.h:31: error: syntax error before "__u32"
/usr/include/linux/mod_devicetable.h:33: error: syntax error before "model_id"
/usr/include/linux/mod_devicetable.h:34: error: syntax error before "specifier_id"
/usr/include/linux/mod_devicetable.h:35: error: syntax error before "version"
/usr/include/linux/mod_devicetable.h:36: error: syntax error before "driver_data"
/usr/include/linux/mod_devicetable.h:99: error: syntax error before "__u16"
/usr/include/linux/mod_devicetable.h:103: error: syntax error before "idProduct"
/usr/include/linux/mod_devicetable.h:104: error: syntax error before "bcdDevice_lo"
/usr/include/linux/mod_devicetable.h:105: error: syntax error before "bcdDevice_hi"
/usr/include/linux/mod_devicetable.h:108: error: syntax error before "bDeviceClass"
/usr/include/linux/mod_devicetable.h:109: error: syntax error before "bDeviceSubClass"
/usr/include/linux/mod_devicetable.h:110: error: syntax error before "bDeviceProtocol"
/usr/include/linux/mod_devicetable.h:113: error: syntax error before "bInterfaceClass"
/usr/include/linux/mod_devicetable.h:114: error: syntax error before "bInterfaceSubClass"
/usr/include/linux/mod_devicetable.h:115: error: syntax error before "bInterfaceProtocol"
/usr/include/linux/mod_devicetable.h:118: error: syntax error before "driver_info"
/usr/include/linux/mod_devicetable.h:135: error: syntax error before "__u16"
/usr/include/linux/mod_devicetable.h:138: error: syntax error before "dev_type"
/usr/include/linux/mod_devicetable.h:139: error: syntax error before "cu_model"
/usr/include/linux/mod_devicetable.h:140: error: syntax error before "dev_model"
/usr/include/linux/mod_devicetable.h:142: error: syntax error before "driver_info"
pusb-linux.c:66: error: redefinition of `struct usb_device_descriptor'
pusb-linux.c: In function `pusb_control_msg':
pusb-linux.c:164: error: structure has no member named `requesttype'
pusb-linux.c:165: error: structure has no member named `request'
pusb-linux.c:166: error: structure has no member named `value'
pusb-linux.c:167: error: structure has no member named `index'
pusb-linux.c:168: error: structure has no member named `length'
make[2]: *** [pusb.o] Error 1
make[2]: Leaving directory `/tmp/speedbundle-1.0/firmware_loader/src'
make[1]: *** [modem] Error 2
make[1]: Leaving directory `/tmp/speedbundle-1.0/firmware_loader'
make: *** [build-stamp] Error 2

