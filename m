Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUHPLU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUHPLU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267546AbUHPLU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:20:28 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:63911 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S267542AbUHPLUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:20:18 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 16 Aug 2004 13:05:01 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Devel <devel@integra-sc.it>, linux-kernel@vger.kernel.org
Subject: Re: patch_kraxel-2.4.26 in kernel 2.4.27
Message-ID: <20040816110501.GR2701@bytesex>
References: <20040805161923.4e2e2147.devel@integra-sc.it> <20040805224109.GB18155@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805224109.GB18155@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 07:41:09PM -0300, Marcelo Tosatti wrote:
> On Thu, Aug 05, 2004 at 04:19:23PM +0200, Devel wrote:
> > The path patch_kraxel-2.4.26 from http://dl.bytesex.org/patches/ will be included into kernel 2.4.27?
> > Thanks by now!
> 
> Nope, it wont. A quick look shows it touches a hell lot of stuff.

It basically brings v4l(2) of the 2.4.26 kernel to 2.6 level, including
the v4l2 API + new drivers (which depend on v4l2).

> We should probably try to merge the sane bits? Gerd?

I'm not going to submit v4l2 for 2.4, people better should go with 2.6
of they need it.  The only bits I can think of merging are the updates
for bttv-cards.c, i.e. support for some new tv cards.  New cards are
rare these days through as new cards usually don't use bt878-based
designs any more.  Also it is low priority on my todo list and I'm just
back from two weeks holiday with alot of pending stuff, so don't expect
me looking at this soon (maybe not at all).

  Gerd

-- 
return -ENOSIG;
