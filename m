Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVBQT5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVBQT5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVBQT47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:56:59 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:21135 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262293AbVBQT4q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:56:46 -0500
X-OB-Received: from unknown (208.36.123.31)
  by wfilter.us4.outblaze.com; 17 Feb 2005 19:56:45 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
From: "Deepti Patel" <pateldeepti@lycos.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 17 Feb 2005 14:56:45 -0500
Subject: getting error whu\ile loading in netfilter hook
X-Originating-Ip: 128.235.249.80
X-Originating-Server: ws7-2.us4.outblaze.com
Message-Id: <20050217195645.6E41FE5BC7@ws7-2.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am using fedora 2.6.5 and trying to load a module in netfilter's hook. But it is giving me error and could not find out what needs to be done.

Error:

[root@marieke Deepti]# make -f Makefile_lkm
make -C /lib/modules/2.6.5-1.358/build SUBDIR=/root/Deepti modules
make[1]: Entering directory `/lib/modules/2.6.5-1.358/build'
  CHK     include/asm-i386/asm_offsets.h
make[2]: *** No rule to make target `arch/i386/kernel/msr.c', needed by `arch/i3 86/kernel/msr.o'.  Stop.
make[1]: *** [arch/i386/kernel] Error 2
make[1]: Leaving directory `/lib/modules/2.6.5-1.358/build'

Makefile:

KDIR    := /lib/modules/2.6.5-1.358/build
PWD     := $(shell pwd)
obj-m   := Hook_LKM.o
default:
        $(MAKE) -C $(KDIR) SUBDIR=$(PWD) modules


Appritiate your suggestions.
Thanks in advance



-- 
_______________________________________________
Find what you are looking for with the Lycos Yellow Pages
http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10

