Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVGOTug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVGOTug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbVGOTue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:50:34 -0400
Received: from oban.u-picardie.fr ([193.49.184.8]:19294 "EHLO
	mailx.u-picardie.fr") by vger.kernel.org with ESMTP id S262004AbVGOTuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:50:32 -0400
Message-ID: <1121457027.42d8138341748@webmail.u-picardie.fr>
Date: Fri, 15 Jul 2005 21:50:27 +0200
From: FyD <fyd@u-picardie.fr>
To: linux-kernel@vger.kernel.org
Subject: Module snd-intel8x0.ko broken in 2.6.12
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 137.131.252.204
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I just compiled & install the kernels 2.6.12.2 & 2.6.12 & booted my laptop.

Here is the error message I get whatever the kernel 2.6.12 I use:
FATAL: Error inserting snd-intel8x0
(/lib/modules/2.6.12.2/kernel/sound/pci/snd-intel8x0.ko)
unknown symbol in module or unknown parameter (see dmesg)

Answer of dmesg:
vbug.c: Event. Dev: usb-0000:00:1d.1-2/input0, Type: 2, Code: 1, Value: 4
evbug.c: Event. Dev: usb-0000:00:1d.1-2/input0, Type: 0, Code: 0, Value: 0
evbug.c: Event. Dev: usb-0000:00:1d.1-2/input0, Type: 2, Code: 0, Value: -2
evbug.c: Event. Dev: usb-0000:00:1d.1-2/input0, Type: 2, Code: 1, Value: 4
[cut]
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 34, Value: 0
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 4, Code: 4, Value: 28
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 28, Value: 1
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0

Then, a window is automatically opened when I get in my login:
"No volume control elements and/or devices found."

Does it mean this module is broken in 2.6.12 ?
Indeed, I did not have this problem with 2.6.11.
What should I do to solve this _with 2.6.12_ since I do need 2.6.12 for
something else...?

Thanks, Regards, Francois

PS Please answer to my email address since I did not register...

