Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264469AbRFZVKI>; Tue, 26 Jun 2001 17:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbRFZVJ7>; Tue, 26 Jun 2001 17:09:59 -0400
Received: from zeus.kernel.org ([209.10.41.242]:56293 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264469AbRFZVJs>;
	Tue, 26 Jun 2001 17:09:48 -0400
Date: Wed, 27 Jun 2001 00:06:21 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: rjohnson@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Duplicate IP ??
Message-ID: <20010627000621.F8897@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.3.95.1010626154101.14565A-100000@quark.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1010626154101.14565A-100000@quark.analogic.com>; from johnson@quark.analogic.com on Tue, Jun 26, 2001 at 03:51:33PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 03:51:33PM -0400, Richard B. Johnson wrote:
> I just got a bunch of messages from vger.kernel.org, sent to
> root@chaos.analogic.com, claiming a "local configuration error"
> and some kind of a loop.

	Weird...   I don't recall any bounces..

	Logs show *one* bounce from  chaos.analogic.com  just
	about an hour ago, and it went to linux-kernel-owner ..

	There are also 121 successfull deliveries in 12 hours
	collected in the log.

> There is no configuration that has changed on that machine for
> at least two years although our firewall got updated last week
> to fix the ECN bug.
> 
> I checked with ns.uu.net to see if the machine address was still
> resolvable, it is.
> 
> I can `telnet vger.kernel.org 25`. That connectivity works.
> So I don't get any mail from vger.kernel.org.  What goes?

	Where then those 121 messages went ?

	The ECN connectivity problem is visible only when
	connection originator (= vger) has the ECN bit on.

	If incoming SYN doesn't have ECN bit on, reply to
	SYN is sent without ECN.   That is why people can
	reach VGER, but VGER might not be able to reach
	people's MTAs.

> Dick Johnson

/Matti Aarnio
