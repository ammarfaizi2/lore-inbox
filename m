Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVGFW3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVGFW3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVGFW25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:28:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:47509 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262333AbVGFWS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:18:27 -0400
Date: Wed, 6 Jul 2005 15:18:18 -0700
From: Greg KH <greg@kroah.com>
To: Mike Snitzer <snitzer@gmail.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Robert Love <rml@novell.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20050706221818.GA6696@kroah.com>
References: <1093989513.4815.45.camel@betsy.boston.ximian.com> <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <170fa0d2050706150255ec7019@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170fa0d2050706150255ec7019@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 04:02:35PM -0600, Mike Snitzer wrote:
> So this is a blast from the past

Yes it is, why are you trying to argue about GPL issues on lkml?

> but I'd like to understand why kobject_uevent and kbject_uevent_atomic
> are EXPORT_SYMBOL_GPL rather than EXPORT_SYMBOL.

Because only GPL code should be causing kevents.

> During the evoloution from a separate kevents over netlink (rml, kay,
> arjan) then folding it in to kobject with hotplug (kay, greg kh, etc)
> it went from GPL to not, as listed below in one of kay's early
> patches, back to EXPORT_SYMBOL_GPL as it stands today.

I asked that it be put back.  Is there a problem with this?  Do you have
non-GPL kernel code that wants to use this interface?

thanks,

greg k-h
