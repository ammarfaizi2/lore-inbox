Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUA2Vq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 16:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUA2Vq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 16:46:26 -0500
Received: from waste.org ([209.173.204.2]:47041 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266463AbUA2VqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 16:46:25 -0500
Date: Thu, 29 Jan 2004 15:46:21 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
Message-ID: <20040129214621.GL21888@waste.org>
References: <20040129193727.GJ21888@waste.org> <20040129201556.GK16675@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129201556.GK16675@khan.acc.umu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 09:15:56PM +0100, David Weinehall wrote:
> On Thu, Jan 29, 2004 at 01:37:28PM -0600, Matt Mackall wrote:
> > I've been fiddling with cleaning up some old code here and suggest the
> > following to make Lindent match actual practice more closely. This does:
> > 
> > a) (no -psl)
> > 
> > void *foo(void) {
> > 
> >  instead of
> > 
> > void *
> > foo(void) {
> > 
> > b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
> 
> I can't really see the logic in this, though I know a lot of people do
> it.  I try to stay consistent, thus I do:
> 
> if ()
> for ()
> case ()
> while ()
> sizeof ()
> typeof ()

Well, sizeof and typeof are operators rather than flow structures so
they're a little different. But what I'm really trying to do here is
make Lindent match actual practice (as a first approximation of the
community's preferred practice) rather than argue the merits of any
particular usage.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
