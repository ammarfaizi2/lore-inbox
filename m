Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWETQIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWETQIl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 12:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWETQIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 12:08:41 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:55686 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751339AbWETQIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 12:08:41 -0400
Message-ID: <446F3F6A.9060004@cmu.edu>
Date: Sat, 20 May 2006 12:10:18 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cannot load *any* modules with 2.4 kernel
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I boot two kernels, a 2.6.9 kernel and just recently built a 2.4.32 kernel

In the 2.4.32 kernel I have =y for:
CONFIG_MODULES
CONFIG_MODVERSIONS
CONFIG_KMOD

I then build my kernel, with some modules, install the modules, and boot
my 2.4.32 kernel successfully

when i do lsmod, it is completely empty, no modules are loaded.  This
only happens for my 2.4.32 kernel though, modules load fine in 2.6.9

If i try to manually insert with insmod or modprobe, i get unresolved
external symbols for things that I am sure should be resolved... for
example, i get unresolved external symbol for printk

I'll give some other common unresolved smybols and maybe someone can
point me in the right direction of what else i need to specify to you
guys so that you can help me out further.

prinkt
add_timer
dev_mc_add
CardServices
kfree
cpu_raise_softirq
free_irq
kmalloc

Thanks!
George
