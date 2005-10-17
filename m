Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVJQDUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVJQDUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 23:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVJQDUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 23:20:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53722 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932094AbVJQDUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 23:20:09 -0400
Date: Sun, 16 Oct 2005 20:19:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1
Message-Id: <20051016201920.53db2b89.akpm@osdl.org>
In-Reply-To: <6bffcb0e0510161713l7c3abbdq@mail.gmail.com>
References: <20051016154108.25735ee3.akpm@osdl.org>
	<6bffcb0e0510161713l7c3abbdq@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> Hi,
> 
> On 16/10/05, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
> >
> [snip]
> 
> I have noticed some warnings while "make modules_install"
> 
> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
> System.map  2.6.14-rc4-mm1; fi
> WARNING: Module
> /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/serial_core.ko
> ignored, due to loop
> WARNING: Module
> /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250_pnp.ko ignored,
> due to loop
> WARNING: Module
> /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250_pci.ko ignored,
> due to loop
> WARNING: Module
> /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250_acpi.ko
> ignored, due to loop
> WARNING: Loop detected:
> /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250.ko needs
> serial_core.ko which needs 8250.ko again!
> WARNING: Module
> /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250.ko ignored, due
> to loop

Beats me.  Please send .config.
