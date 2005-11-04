Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVKDQ40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVKDQ40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVKDQ4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:56:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:61323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750718AbVKDQzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:55:54 -0500
Date: Fri, 4 Nov 2005 08:37:55 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, damir.perisa@solnet.ch, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: 2.6.14-rc5-mm1 - ide-cs broken!
Message-ID: <20051104163755.GB13420@kroah.com>
References: <20051103220305.77620d8f.akpm@osdl.org> <20051104071932.GA6362@kroah.com> <1131117293.26925.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131117293.26925.46.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 03:14:53PM +0000, Alan Cox wrote:
> On Iau, 2005-11-03 at 23:19 -0800, Greg KH wrote:
> > Hint, gentoo, debian, and suse don't have this problem, so you might
> > want to look at their rules files for how to work around this.  Look for
> > this line:
> > 
> > # skip accessing removable ide devices, cause the ide drivers are horrible broken
> 
> 
> I was under the impression people had eventually decided the media
> change patch someone was proposed was ok after investigating one or two
> cases I knew of that turned out to be borked hardware ?

I was not aware of that, I'd be glad to see that patch go into the tree
to help others who have run into this over the years.

Hm, have a pointer to the latest proposed patch for this anywhere?

thanks,

greg k-h
