Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWAPP0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWAPP0e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWAPP0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:26:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45211 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750860AbWAPP0e (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:26:34 -0500
Date: Mon, 16 Jan 2006 09:25:58 -0600
From: Jack Steiner <steiner@sgi.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch] mm: cleanup bootmem
Message-ID: <20060116152558.GA25290@sgi.com>
References: <43C8F198.3010609@yahoo.com.au> <Pine.LNX.4.64.0601140949460.13339@g5.osdl.org> <43C93CCA.9080503@yahoo.com.au> <43C93DA0.3040506@yahoo.com.au> <Pine.LNX.4.64.0601141011300.13339@g5.osdl.org> <yq0slrotuyz.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0slrotuyz.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 03:53:08AM -0500, Jes Sorensen wrote:
> >>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> Linus> On Sun, 15 Jan 2006, Nick Piggin wrote:
> >> That's still completely functional after my patch. In fact, as I
> >> said in a followup it is likely to work better than with David's
> >> change to free batched pages as order-0, because I reverted back to
> >> freeing them as higher order pages.
> 
> Linus> Ok. Then I doubt anybody will complain. I'm still wondering if
> Linus> some of the other ugliness was due to some simulator
> Linus> strangeness issues, but maybe even ia64 doesn't care that much
> Linus> any more..
> 
> We still use simulators for a bunch of stuff, but I don't know if this
> is affecting it or not. Jack Steiner may know more.

AFAICT, the patch doesnt affect the simulator that is used at SGI. I
built a current tree, applied the patch & booted ok. No problems.

> 
> Cheers,
> Jes

--
Thanks

Jack


