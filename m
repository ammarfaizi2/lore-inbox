Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbVJ0XRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbVJ0XRs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 19:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbVJ0XRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 19:17:48 -0400
Received: from hera.kernel.org ([140.211.167.34]:24727 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932685AbVJ0XRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 19:17:48 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [patch 1/1] PCI: automatically set device_driver.owner
Date: Thu, 27 Oct 2005 16:17:44 -0700
Organization: OSDL
Message-ID: <20051027161744.623e1ada@dxpl.pdx.osdl.net>
References: <20051027211253.457180000@antares.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1130455064 22589 10.8.0.74 (27 Oct 2005 23:17:44 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 27 Oct 2005 23:17:44 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005 23:12:54 +0200
Laurent riffard <laurent.riffard@free.fr> wrote:

> A nice feature of sysfs is that it can create the symlink from the
> driver to the module that is contained in it.
> 
> It requires that the device_driver.owner is set, what is not the
> case for many PCI drivers.
> 
> This patch allows pci_register_driver to set automatically the
> device_driver.owner for any PCI driver.
> 
> Credits to Al Viro who suggested the method.
> 
> Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
> --

Okay, but a little too much macro trickery for my taste.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
