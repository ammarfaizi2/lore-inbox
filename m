Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUIKEIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUIKEIi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 00:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268073AbUIKEIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 00:08:38 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6560 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268072AbUIKEIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 00:08:23 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040910235409.GA32424@kroah.com>
References: <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094142321.2284.12.camel@betsy.boston.ximian.com>
	 <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost>
	 <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org>
	 <20040910235409.GA32424@kroah.com>
Content-Type: text/plain
Date: Sat, 11 Sep 2004 00:09:35 -0400
Message-Id: <1094875775.10625.5.camel@lucy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 16:54 -0700, Greg KH wrote:
> Ok, thanks to a respin of the patch by Kay, and some further tweaks by
> me to make the patch a bit smaller (and make the functions
> EXPORT_SYMBOL_GPL, Robert and Kay, speak up if you don't like that
> change), I've commited the following patch to my trees, and it should
> show up in the next -mm release

Greg, looks good to me.  Thank you much for picking this up.

I am currently out of town (foo camp) so I cannot really test it, but I
did a quick patch review and it looks right on.

> (Andrew, you can drop your other patch in your stack that contained a
> version of this.)

Nod.

> +/**
> + * send_uevent - notify userspace by sending event trough netlink socket

s/trough/through/ ;-)

...

Kay, any thoughts?

We should probably add at least _some_ user.  The filesystem mount
events are good, since we want to add those to HAL.

Again, thanks.

	Robert Love


