Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVJRWpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVJRWpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 18:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVJRWpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 18:45:13 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:64007 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932188AbVJRWpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 18:45:12 -0400
Date: Wed, 19 Oct 2005 00:41:18 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.31] Reintroduction i386 CONFIG_DUMMY_KEYB option
Message-ID: <20051018224118.GA12326@alpha.home.local>
References: <Pine.LNX.4.44.0510141006280.3868-200000@website2.europe.pwc.ca> <20051018080226.GB13299@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018080226.GB13299@logos.cnet>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 06:02:26AM -0200, Marcelo Tosatti wrote:
> On Fri, Oct 14, 2005 at 10:19:44AM +0100, Nick Warne wrote:
> > 
> > >>  #ifdef CONFIG_VT
> > >> +#ifndef CONFIG_DUMMY_KEYB
> > 
> > > Please could you change this to #if defined(CONFIG_VT) && 
> > > !defined(CONFIG_DUMMY_KEYB) ?
> > 
> > > Marcelo, I'd like this one to be merged, as it is useful to many of us, 
> > > and is already fixed in 2.6 (where you're not forced to have a 
> > > keyboard).  It's not intrusive and at most a build fix. Would you please 
> > > accept Nick's patch after the little clean-up above ?
> > 
> > 
> > OK, the adjusted patch attached.  I did look at the ifdefs in that file 
> > for a few minutes; but I see now I should have done it like this in the 
> > first place.
> 
> Looks fine - Willy can you keep it in your tree and add it later on to the 
> 2.4.33-pre tree?

OK, fine.

Willy

