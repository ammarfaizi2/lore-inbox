Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVKGU30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVKGU30 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbVKGU30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:29:26 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54706 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964900AbVKGU3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:29:25 -0500
Date: Mon, 7 Nov 2005 13:29:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] slob: introduce mm/util.c for shared functions
Message-ID: <20051107202924.GJ3839@smtp.west.cox.net>
References: <2.505517440@selenic.com> <20051103211357.072c5646.akpm@osdl.org> <20051104062455.GD4367@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104062455.GD4367@waste.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 10:24:55PM -0800, Matt Mackall wrote:
> On Thu, Nov 03, 2005 at 09:13:57PM -0800, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:
> > >
> > >  Add mm/util.c for functions common between SLAB and SLOB.
> > 
> > We should probably add a ppc32-developers-are-weenies warning to string.c
> 
> Well, yes. But I decided not to do that now because I ended up wanting
> to create mm/util.c anyway for kzalloc. I suspect we'll see other
> helper functions like kzalloc and kstrdup down the road.
> 
> Also, I haven't investigated the PPC entanglements too closely, but
> converting it to use my cleaned up lib/inflate.c might reduce its
> dependence on lib/string.c

That's on my list of things to go and poke.  But I don't recall us
depending on lib/string.c nowadays (but an occasional reimpl to match
declaration), just lib/zlib_inflate/

-- 
Tom Rini
http://gate.crashing.org/~trini/
