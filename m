Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVBBB2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVBBB2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 20:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVBBB2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 20:28:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:28843 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261987AbVBBB2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 20:28:01 -0500
Date: Tue, 1 Feb 2005 17:27:24 -0800
From: Greg KH <greg@kroah.com>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: "Mark A. Greer" <mgreer@mvista.com>, phil@netroedge.com,
       sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-ID: <20050202012723.GA16465@kroah.com>
References: <200502020315.14281.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502020315.14281.adobriyan@mail.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 03:15:14AM +0200, Alexey Dobriyan wrote:
 
> P. S.: struct mv64xxx_i2c_data revisited...
> 
> > +	uint			state;
> > +	ulong			reg_base_p;
> 
> Silly request, but... Maybe this should be changed to plain old "unsigned int"
> and "unsigned long". Please. I just don't understand why people use "uint",
> "u_int", "uInt", "UINT", "uINT", "uint_t" which are always typedef'ed to
> "unsigned int".

Not a silly request at all.  Please use the u32, u64 and so on values
instead.  That way we know what you mean, and it's portable.

thanks,

greg k-h
