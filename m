Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbTAEEMc>; Sat, 4 Jan 2003 23:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbTAEEMc>; Sat, 4 Jan 2003 23:12:32 -0500
Received: from mgr2.xmission.com ([198.60.22.202]:47082 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP
	id <S262580AbTAEEMc>; Sat, 4 Jan 2003 23:12:32 -0500
Message-ID: <3E17B253.8000700@xmission.com>
Date: Sat, 04 Jan 2003 21:19:31 -0700
From: Frank Jacobberger <f1j1@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ehci-hcd.o still a problem kernels > 2.4.20?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm noticing the following in kernels > 2.4.20:

I'm getting an odd error when kernel boots that the ehci-hcd.o.gz can't 
load..

or if doing an insmod ehci-hcd I get:

insmod ehci-hcd
Using /lib/modules/2.4.20-2.5/kernel/drivers/usb/hcd/ehci-hcd.o.gz
/lib/modules/2.4.20-2.5/kernel/drivers/usb/hcd/ehci-hcd.o.gz: 
init_module: No such device

Dmesg and everything else points to it loading:

hcd.c: ehci-hcd @ 00:1d.7, Intel Corp. 82801DB USB EHCI Controller

and:

Doing an lspci bears this out:

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)

No idea why the kernel is balking at boot and not logging this to kernel 
messages!

Any more ideas on a good fix for this?

Anyone interested can chime in on RH bugzilla #79210

Thanks,

Frank

