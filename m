Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbSLNHk1>; Sat, 14 Dec 2002 02:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbSLNHk1>; Sat, 14 Dec 2002 02:40:27 -0500
Received: from mgr3.xmission.com ([198.60.22.203]:56139 "EHLO
	mgr3.xmission.com") by vger.kernel.org with ESMTP
	id <S267467AbSLNHk0>; Sat, 14 Dec 2002 02:40:26 -0500
Message-ID: <3DFAE241.7060603@xmission.com>
Date: Sat, 14 Dec 2002 00:48:17 -0700
From: Frank Jacobberger <f1j1@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ehci-hcd.o apparent load failure in 2.4.20-xx.. but
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who maintains this driver?

I'm getting an odd error when kernel boots that the ehci-hcd.o.gz can't 
load..

or if doing an insmod ehci-hcd I get:

insmod ehci-hcd
Using /lib/modules/2.4.20-0.pp.7/kernel/drivers/usb/hcd/ehci-hcd.o.gz
/lib/modules/2.4.20-0.pp.7/kernel/drivers/usb/hcd/ehci-hcd.o.gz: 
init_module: No such device

Dmesg and everything else points to it loading:

hcd.c: ehci-hcd @ 00:1d.7, Intel Corp. 82801DB USB EHCI Controller

and:

Doing an lspci bears this out:

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)

No idea why the kernel is balking at boot and not logging this to kernel messages!

Any ideas?

Thanks,

Frank




