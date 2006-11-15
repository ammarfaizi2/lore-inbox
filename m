Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966787AbWKOLKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966787AbWKOLKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 06:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966796AbWKOLKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 06:10:53 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:2742 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S966795AbWKOLKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 06:10:51 -0500
Date: Wed, 15 Nov 2006 13:10:49 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Marc Perkel <mperkel@yahoo.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Majordomo is an obsolete piece of junk and Kernel should not be running it!
Message-ID: <20061115111049.GK10054@mea-ext.zmailer.org>
References: <20061114.200507.21927677.davem@davemloft.net> <20061115042335.11460.qmail@web52506.mail.yahoo.com> <20061115054124.GA29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115054124.GA29920@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 05:41:24AM +0000, Al Viro wrote:
> On Tue, Nov 14, 2006 at 08:23:35PM -0800, Marc Perkel wrote:
>  
> > This is the only list I get booted from so that makes
> > me think the problem is with the list and not with me.
> > It seems that you are also using 12 year old software
> > as well.  Why not get something modern like Mailman
> > like most other lists use and then you don't have to
> > be watching the bounces? 

More like 20 years old..

With mailman handling the bounces..  Leaked in spams will
cause subscribers to be dropped right and left, and far
sooner than after 5 days of persistent non-delivery...

> > The problem is that you are running Majordomo which in
> > it's day was great, but is day has passed. 

I really have not seen anything better than Majordomo 1.9x.
There are lots of eye-candy and web-candy thingies out there,
but principal task of adding/removing subscribers on list
dataset and delivering messages to those are still the things
that define list management.

With this Majordomo we can define lists that permit incoming
posting only from subscribers, we can even define poster address
datasets that are not subscribers!  However for most of our lists
we have chosen to run "posting is open, subject to silent filtering".

Most new beasts want to make email delivery themselves (act as
an MTA) instead of delegating it to an MTA in form which really
is high performance.  I did that integration some 10 years ago,
and we haven't had a need to look back.

One incoming-to-list message goes thru Majordomo processing, and
is given out as ONE message to MTA for delivery to 4000+ recipients.
We would need to lot bigger server (-farm) to handle things in
ways that those "send unique message to everybody" piece of junk
list-softwares do it.

  /Matti Aarnio  --  one of <postmaster at vger.kernel.org>
