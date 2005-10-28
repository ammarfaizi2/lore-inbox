Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751941AbVJ1WlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbVJ1WlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbVJ1WlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:41:08 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:34808 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751941AbVJ1WlG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:41:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LgmyciJ8/hFYIy7NjQ7N3jMpvOqTzxa4YoI+usx5EQxKkjOqGihV87SKRVSaQYwNzNzbal9KVFA8632j+bnh06mnO8XOqlxR/cxD9fn6QT1HygeJJdVusb/iTzikqnqUwpOkaXI3TvEXXMhma0xk158zMFc5IXrzU9X3//OiXIw=
Message-ID: <35fb2e590510281541m7ff923ecte3003be812e73f75@mail.gmail.com>
Date: Fri, 28 Oct 2005 23:41:05 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510282322.16627.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510271026.10913.ak@suse.de> <20051028205132.GB11397@elf.ucw.cz>
	 <20051028205916.GL4464@flint.arm.linux.org.uk>
	 <200510282322.16627.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Andi Kleen <ak@suse.de> wrote:
> On Friday 28 October 2005 22:59, Russell King wrote:
> > On Fri, Oct 28, 2005 at 10:51:32PM +0200, Pavel Machek wrote:
> > > Well, keyboard detected and reported an error. Kernel reacted with
> > > printk(). You are removing that printk(). I can understand that,
> > > printk is really annoying, but I really believe _some_ error handling
> > > should be added there if you remove the printk.
> >
> > What do you suggest?
>
> Obviously it needs an DBUS over netlink interface with an user space daemon to open
> a window on the desktop. Then the user needs to click ok to make sure they
> understood they did something wrong (either by buying broken hardware or by simply
> typing).

But just in case the mouse is also broken, this should broadcast out
on the local network and popup windows on every other Linux box we can
find within 50 miles.

> You get bonus points when that window first opens another window with a "Did you
> know ..." message with a little dancing pink penguin that gives you helpful tips
> regarding typing on keyboards and offers you links to buy new keyboards on the web.

> Wouldn't that be great?

Where does sysfs fit into this plan? :P

Jon.
