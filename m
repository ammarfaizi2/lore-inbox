Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVKWSVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVKWSVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVKWSVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:21:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:15281 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932137AbVKWSVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:21:09 -0500
Date: Wed, 23 Nov 2005 10:18:27 -0800
From: Greg KH <gregkh@suse.de>
To: "Yeisley, Dan P." <dan.yeisley@unisys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.14.2  Support for 1K I/O space granularity on the Intel P64H2
Message-ID: <20051123181827.GA27403@suse.de>
References: <94C8C9E8B25F564F95185BDA64AB05F6028E115E@USTR-EXCH5.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94C8C9E8B25F564F95185BDA64AB05F6028E115E@USTR-EXCH5.na.uis.unisys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 01:02:52PM -0500, Yeisley, Dan P. wrote:
> The Intel P64H2 PCI bridge has the ability to allocate I/O space with
> 1KB granularity.  I've written a patch against 2.6.14.2 to take
> advantage of this option.  I've tested it on the latest Unisys
> ES7000-600.  

Shouldn't this be made into a pci quirk somehow?

> linux-2.6.14.2-en1k/drivers/pci/probe.c
> --- linux-2.6.14.2/drivers/pci/probe.c	2005-11-11 00:33:12.000000000
> -0500

Your patch is linewrapped and can't be applied :(

thanks,

greg k-h
