Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267647AbUHPNfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267647AbUHPNfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUHPNfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:35:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49364 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267630AbUHPNd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:33:29 -0400
Date: Mon, 16 Aug 2004 08:54:15 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Devel <devel@integra-sc.it>, linux-kernel@vger.kernel.org
Subject: Re: patch_kraxel-2.4.26 in kernel 2.4.27
Message-ID: <20040816115415.GA14656@logos.cnet>
References: <20040805161923.4e2e2147.devel@integra-sc.it> <20040805224109.GB18155@logos.cnet> <20040816110501.GR2701@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816110501.GR2701@bytesex>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 01:05:01PM +0200, Gerd Knorr wrote:
> On Thu, Aug 05, 2004 at 07:41:09PM -0300, Marcelo Tosatti wrote:
> > On Thu, Aug 05, 2004 at 04:19:23PM +0200, Devel wrote:
> > > The path patch_kraxel-2.4.26 from http://dl.bytesex.org/patches/ will be included into kernel 2.4.27?
> > > Thanks by now!
> > 
> > Nope, it wont. A quick look shows it touches a hell lot of stuff.
> 
> It basically brings v4l(2) of the 2.4.26 kernel to 2.6 level, including
> the v4l2 API + new drivers (which depend on v4l2).
> 
> > We should probably try to merge the sane bits? Gerd?
> 
> I'm not going to submit v4l2 for 2.4, people better should go with 2.6
> of they need it.  The only bits I can think of merging are the updates
> for bttv-cards.c, i.e. support for some new tv cards.  New cards are
> rare these days through as new cards usually don't use bt878-based
> designs any more.  Also it is low priority on my todo list and I'm just
> back from two weeks holiday with alot of pending stuff, so don't expect
> me looking at this soon (maybe not at all).

Fine!
