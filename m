Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUBBTUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUBBTUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:20:48 -0500
Received: from mail.kroah.org ([65.200.24.183]:19161 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265772AbUBBTUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:20:47 -0500
Date: Mon, 2 Feb 2004 11:20:44 -0800
From: Greg KH <greg@kroah.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bttv oops
Message-ID: <20040202192044.GA31435@kroah.com>
References: <401E69AD.4080606@earthlink.net> <87u129eb5p.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u129eb5p.fsf@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 04:47:14PM +0100, Gerd Knorr wrote:
> Stephen Clark <stephen.clark@earthlink.net> writes:
> 
> > Gentle people,
> > 
> > I am having the following problem. Also if I compile bttv into the
> > kernel I get a panic in the driver at boot.
> > 
> > Any ideas?
> 
> disable CONFIG_I2C_*_DEBUG, the debug printk() dereference pointers
> unchecked.

Oops, what printks do this?  I'll be glad to fix that up.

thanks,

greg k-h
