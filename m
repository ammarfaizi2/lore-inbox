Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUERTzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUERTzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 15:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUERTzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 15:55:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:59016 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263309AbUERTzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 15:55:16 -0400
Date: Tue, 18 May 2004 12:53:09 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: usb sleep patch
Message-ID: <20040518195309.GA15058@kroah.com>
References: <40AA3A0E.5040500@pobox.com> <20040518171625.GB12348@kroah.com> <200405182146.54806.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405182146.54806.oliver@neukum.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2004 at 09:46:54PM +0200, Oliver Neukum wrote:
> 
> > + * msleep - sleep safely even with waitqueue interruptions
> > + * msecs: Time in milliseconds to sleep for
> > + */
> > +static inline void msleep(unsigned int msecs)
> 
> Why do you make it inline? After a milisecond the cache is cold,
> so we should shrink the code.

I wasn't thinking, see my final proposed patch.

thanks,

greg k-h
