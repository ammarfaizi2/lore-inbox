Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbUBJSEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUBJSC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:02:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:7303 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266166AbUBJR6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:58:05 -0500
Date: Tue, 10 Feb 2004 09:57:39 -0800
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Newest fbdev patch to go mainline.
Message-ID: <20040210175739.GF28111@kroah.com>
References: <Pine.LNX.4.44.0402101747450.6600-100000@phoenix.infradead.org> <Pine.LNX.4.44.0402101750150.6600-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402101750150.6600-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 05:51:26PM +0000, James Simmons wrote:
> 
> One more thing. What should I use for devices like vesafb? Should I use 
> the platform_bus_type like sa1100fb.c?

That sounds reasonable, if there is no other place the vesafb device
lives off of in the driver model.

thanks,

greg k-h
