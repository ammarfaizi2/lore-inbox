Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUA1VpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266206AbUA1VpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:45:18 -0500
Received: from mail.kroah.org ([65.200.24.183]:38294 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266204AbUA1Vn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:43:56 -0500
Date: Wed, 28 Jan 2004 13:43:56 -0800
From: Greg KH <greg@kroah.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PC300 update
Message-ID: <20040128214356.GA8999@kroah.com>
References: <Pine.LNX.4.58L.0401281741120.2088@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401281741120.2088@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 05:42:11PM -0200, Marcelo Tosatti wrote:
> 
> - Mark pci_device_id list with __devinitdata

Noooo!!!   I think we've finally audited all uses of this.  Do not do
this please, it is wrong for 2.6.

> - Add #ifdef DEBUG around debug printk()

What's wrong with dev_dbg()?  It gives you a much better idea of which
device is spitting out the messages.

thanks,

greg k-h
