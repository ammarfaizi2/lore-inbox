Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTIIOsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTIIOsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:48:11 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:6022 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S264124AbTIIOsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:48:08 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Mitchell Blank Jr <mitch@sfgoth.com>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] might_sleep() improvements
Date: Mon, 8 Sep 2003 23:10:21 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030902075145.GA12817@sfgoth.com> <1062510937.28552.7.camel@boobies.awol.org> <20030902183914.GA67783@gaz.sfgoth.com>
In-Reply-To: <20030902183914.GA67783@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309082310.22375.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 September 2003 14:39, Mitchell Blank Jr wrote:
> Robert Love wrote:
> > >  o Add a "might_sleep_if()" macro for when we might sleep only if some
> > >    condition is met.
> >
> > But I am neutral about this.
>
> That's understandable - I have some of the same reservations myself.  In
> the end I think it's a slight win though.
>
> > Maybe
> > renaming this "might_sleep_on()" at least brings it more in line with
> > BUG_ON(), and avoids looking like the gross constructs I fear.
>
> I named it that at first but I was afraid that someone might get confused
> and thing the semantics were "might_sleep_on(&waitqueue)" since 'sleeping
> on' means something already.  To me might_sleep_if(cond) looked a lot
> clearer at first glance.

might_sleep_when?

Rob


