Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTJ2Urk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 15:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTJ2Urk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 15:47:40 -0500
Received: from dclient217-162-71-11.hispeed.ch ([217.162.71.11]:38831 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S261640AbTJ2Urh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 15:47:37 -0500
Message-ID: <3FA02762.2070304@steudten.com>
Date: Wed, 29 Oct 2003 21:47:30 +0100
From: Thomas Steudten <alpha@steudten.com>
Reply-To: alpha@steudten.com
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.0-test 9: ALPHA:  missing asm/mca.h
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem ist still there in -test9..

In file included from drivers/net/3c509.c:77:
include/linux/mca.h:15:21: asm/mca.h: No such file or directory
make[2]: *** [drivers/net/3c509.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2
merlin:(root):/usr/src/linux_dir/kernel2.6/linux-2.6.0-test9

-------- Original Message --------
Subject: [BUG] 2.6.0-test 7: ALPHA:  missing asm/mca.h
Date: Thu, 09 Oct 2003 12:50:39 +0200
To: LKML <linux-kernel@vger.kernel.org>

Hello

A fresh build with make O=../foo oldconfig for ALPHA CPU fails
with: (There´s no mca.h in the alpha-asm/ source tree.

LD      drivers/media/dvb/ttusb-budget/built-in.o
    LD      drivers/media/dvb/ttusb-dec/built-in.o
    LD      drivers/media/dvb/built-in.o
    LD      drivers/media/radio/built-in.o
    LD      drivers/media/video/built-in.o
    LD      drivers/media/built-in.o
    LD      drivers/misc/built-in.o
    CC      drivers/net/3c59x.o
    CC      drivers/net/Space.o
    CC      drivers/net/net_init.o
    CC      drivers/net/loopback.o
    CC      drivers/net/3c509.o
In file included from /usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/drivers/net/3c509.c:77:
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/include/linux/mca.h:15: asm/mca.h: No such file or directory
make[3]: *** [drivers/net/3c509.o] Error 1
make[2]: *** [drivers/net] Error 2
make[1]: *** [drivers] Error 2
make: *** [boot] Error 2

-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages
Want to know what S.u.S.E 1995 cdrom-set contains?


