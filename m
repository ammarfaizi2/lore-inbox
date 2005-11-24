Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVKXQ3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVKXQ3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVKXQ3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:29:35 -0500
Received: from waste.org ([64.81.244.121]:21715 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932397AbVKXQ3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:29:14 -0500
Date: Thu, 24 Nov 2005 08:26:12 -0800
From: Matt Mackall <mpm@selenic.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Hugh Dickins <hugh@veritas.com>, Russell King <rmk@arm.linux.org.uk>,
       akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: + shut-up-warnings-in-ipc-shmc.patch added to -mm tree
Message-ID: <20051124162612.GS31287@waste.org>
References: <200511230413.jAN4DboR013036@shell0.pdx.osdl.net> <Pine.LNX.4.61.0511241235450.3504@goblin.wat.veritas.com> <20051124160012.GQ31287@waste.org> <20051124160725.GA11863@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124160725.GA11863@granada.merseine.nu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 06:07:25PM +0200, Muli Ben-Yehuda wrote:
> On Thu, Nov 24, 2005 at 08:00:12AM -0800, Matt Mackall wrote:
> > If we're going to start converting such things, I'd almost rather do
> > something like:
> > 
> > kernel.h:
> > static inline void empty_void(void) {}
> > static inline void empty_int(void) { return 0; }
>                 ^^^^
> 
> surely if it's returning an int it should be declared as
> static inline int empty_int(void) { return 0; }
> ?

Surely.

-- 
Mathematics is the supreme nostalgia of our time.
