Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTLDCat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 21:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTLDCat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 21:30:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:33963 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263008AbTLDCar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 21:30:47 -0500
Date: Wed, 3 Dec 2003 18:29:12 -0800
From: Greg KH <greg@kroah.com>
To: Fredrik Tolf <fredrik@dolda2000.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is hotplug a kernel helper?
Message-ID: <20031204022911.GA23761@kroah.com>
References: <16334.31260.278243.22272@pc7.dolda2000.com> <20031204011357.GA22506@kroah.com> <16334.38227.433336.514399@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16334.38227.433336.514399@pc7.dolda2000.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 03:00:51AM +0100, Fredrik Tolf wrote:
> Greg KH writes:
>  > On Thu, Dec 04, 2003 at 01:04:44AM +0100, Fredrik Tolf wrote:
>  > > If you don't mind me asking, I would like to know why the kernel calls
>  > > a usermode helper for hotplug events? Wouldn't a chrdev be a better
>  > > solution (especially considering that programs like magicdev could
>  > > listen in to it as well)? 
>  > 
>  > Please see the archives for why this is, it's been argued many times.
> 
> I am sincerely sorry for being a bother, but I have spent several
> hours searching far and wide for information on it, both in the
> archives and generally on the web, without any luck in finding
> anything. If it's not too much to ask, would you be as kind as to
> provide a pointer?

Here was the latest thread where this was brought up:
	http://marc.theaimsgroup.com/?t=105544548100008

I would suggest reading this post from Linus for a quick summary:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=105552804303171

> Btw., Is there any preferred method of announcing hotplug events to
> user interfaces?

Yes there is a standard.  Have you read the docs at
http://linux-hotplug.sf.net/ ?  Also my 2001 OLS paper details the
format the messages should be in, but it's a bit out of date as to the
new values that the 2.6 kernel sends.

What do you want to use the hotplug interface for that it currently does
not do?

Hope this helps,

greg k-h
