Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTEGCPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTEGCPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:15:37 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:22923 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP id S262633AbTEGCPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 22:15:34 -0400
Message-ID: <3EB86F31.3090301@attbi.com>
Date: Tue, 06 May 2003 19:28:01 -0700
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.4a) Gecko/20030403
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.69 -- drivers/macintosh/adbhid.c:137: too many arguments to function
 `adbhid_input_keycode'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
module-init-tools      0.9.11a
e2fsprogs              1.32
pcmcia-cs              3.2.3
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7

#
# Macintosh device drivers
#
CONFIG_ADB_CUDA=y
CONFIG_ADB_PMU=y
CONFIG_PMAC_PBOOK=y
CONFIG_PMAC_APM_EMU=y
CONFIG_PMAC_BACKLIGHT=y
# CONFIG_MAC_FLOPPY is not set
# CONFIG_MAC_SERIAL is not set
CONFIG_ADB=y
CONFIG_ADB_MACIO=y
CONFIG_INPUT_ADBHID=y
CONFIG_MAC_EMUMOUSEBTN=y
# CONFIG_ANSLCD is not set

   gcc -Wp,-MD,drivers/macintosh/.adbhid.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
-mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix include 
    -DKBUILD_BASENAME=adbhid -DKBUILD_MODNAME=adbhid -c -o 
drivers/macintosh/adbhid.o drivers/macintosh/adbhid.c
drivers/macintosh/adbhid.c: In function `adbhid_keyboard_input':
drivers/macintosh/adbhid.c:137: too many arguments to function 
`adbhid_input_keycode'
drivers/macintosh/adbhid.c:139: too many arguments to function 
`adbhid_input_keycode'
drivers/macintosh/adbhid.c: At top level:
drivers/macintosh/adbhid.c:143: parse error before "pt_regs"
drivers/macintosh/adbhid.c: In function `adbhid_input_keycode':
drivers/macintosh/adbhid.c:144: number of arguments doesn't match prototype
drivers/macintosh/adbhid.c:87: prototype declaration
drivers/macintosh/adbhid.c:147: `keycode' undeclared (first use in this 
function)
drivers/macintosh/adbhid.c:147: (Each undeclared identifier is reported 
only once
drivers/macintosh/adbhid.c:147: for each function it appears in.)
drivers/macintosh/adbhid.c:152: `id' undeclared (first use in this function)
drivers/macintosh/adbhid.c:152: `regs' undeclared (first use in this 
function)
make[2]: *** [drivers/macintosh/adbhid.o] Error 1

