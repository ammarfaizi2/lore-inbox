Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTFXSQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTFXSQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:16:52 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40465 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264292AbTFXSOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:14:41 -0400
Date: Tue, 24 Jun 2003 14:22:13 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
In-Reply-To: <20030620102455.GC26678@wotan.suse.de>
Message-ID: <Pine.LNX.3.96.1030624141844.6519E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003, Andi Kleen wrote:

> On Fri, Jun 20, 2003 at 12:14:52PM +0200, Fruhwirth Clemens wrote:

> > There is no cryptoloop installation which is affected by this. Read my mail
> > properly. Every cryptoloop setup out there uses loop-AES or kerneli's
> > patch-int. And both fixed this issue a _long_ time ago. (Have a look at
> 
> That's completely wrong. I know of several independent implementation
> and installations.

Could you point to these implementations?

> 
> > Again: _no_ userbase is affected by this change. Every userbase which
> > could have ever been affected has done the fix for itself.
> 
> That's also incorrect.

I think the point is that if moving to another device will really break
data, then this is a good time to fix the problem. Breaking things is
allowed, look at modules.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

