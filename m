Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVKDWzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVKDWzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVKDWzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:55:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11722 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751088AbVKDWzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:55:21 -0500
Date: Fri, 4 Nov 2005 14:55:19 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/1] PCI: automatically set device_driver.owner
Message-ID: <20051104145519.3e4be1e7@dxpl.pdx.osdl.net>
In-Reply-To: <436BDCCE.2070906@free.fr>
References: <20051027211253.457180000@antares.localdomain>
	<20051027161744.623e1ada@dxpl.pdx.osdl.net>
	<436BDCCE.2070906@free.fr>
X-Mailer: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Nov 2005 23:12:30 +0100
Laurent Riffard <laurent.riffard@free.fr> wrote:

> 
> Le 28.10.2005 01:17, Stephen Hemminger a écrit :
> > On Thu, 27 Oct 2005 23:12:54 +0200
> > Laurent riffard <laurent.riffard@free.fr> wrote:
> > 
> > 
> >>A nice feature of sysfs is that it can create the symlink from the
> >>driver to the module that is contained in it.
> >>
> >>It requires that the device_driver.owner is set, what is not the
> >>case for many PCI drivers.
> >>
> >>This patch allows pci_register_driver to set automatically the
> >>device_driver.owner for any PCI driver.
> >>
> >>Credits to Al Viro who suggested the method.
> >>
> >>Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
> >>--
> > 
> > 
> > Okay, but a little too much macro trickery for my taste.
> 
> It was not clear to me what happened to this patch. Is it rejected?
> Or is it accepted as is? Or is a better version waited?
> 
> So here is a new version using inline functions instead of macros.

Thats better.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
