Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUCHBVm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 20:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbUCHBVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 20:21:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6864 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262370AbUCHBVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 20:21:40 -0500
Message-ID: <404BCA97.2070502@pobox.com>
Date: Sun, 07 Mar 2004 20:21:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Trabinski <lukasz@trabinski.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.4-rc2
References: <200403080043.i280hlYj005348@lt.wsisiz.edu.pl>
In-Reply-To: <200403080043.i280hlYj005348@lt.wsisiz.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Trabinski wrote:
> In article <Pine.LNX.4.58.0403032229450.5202@ppc970.osdl.org> you wrote:
> 
>>Here's mainly ARM, XFS, PCI hotplug and firewire updates. And some parport
>>cleanups and fixes from Al.
>>
> 
> 
> [root@space-themes linux-2.6.3]# make
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   LD      drivers/input/mouse/psmouse.o
>   LD      drivers/input/mouse/built-in.o
>   LD      drivers/input/built-in.o
>   LD      drivers/input/serio/built-in.o
>   CC      drivers/net/8139too.o
> drivers/net/8139too.c: In function `rtl8139_open':
> drivers/net/8139too.c:1326: error: `CONFIG_8139_RXBUF_IDX' undeclared (first use in this function)
> drivers/net/8139too.c:1326: error: (Each undeclared identifier is reported only once
> drivers/net/8139too.c:1326: error: for each function it appears in.)
> drivers/net/8139too.c: In function `rtl8139_rx':
> drivers/net/8139too.c:1943: error: `CONFIG_8139_RXBUF_IDX' undeclared (first use in this function)
> drivers/net/8139too.c: In function `rtl8139_close':
> drivers/net/8139too.c:2248: error: `CONFIG_8139_RXBUF_IDX' undeclared (first use in this function)
> make[2]: *** [drivers/net/8139too.o] Error 1
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2


Looks like you need to do a 'make oldconfig' ?

	Jeff



