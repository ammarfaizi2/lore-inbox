Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUHXUdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUHXUdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268276AbUHXUdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:33:04 -0400
Received: from waste.org ([209.173.204.2]:34707 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267378AbUHXUc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:32:56 -0400
Date: Tue, 24 Aug 2004 15:32:46 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
Message-ID: <20040824203246.GF31237@waste.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> <20040824184245.GE5414@waste.org> <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 12:23:42PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 24 Aug 2004, Matt Mackall wrote:
> > 
> > Phew, I was worried about that. Can I get a ruling on how you intend
> > to handle a x.y.z.1 to x.y.z.2 transition? I've got a tool that I'm
> > looking to unbreak. My preference would be for all x.y.z.n patches to
> > be relative to x.y.z.
> 
> Hmm.. I have no strong preferences. There _is_ obviously a well-defined 
> ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have 
> any ordering wrt the bugfixes), so either interdiffs or whole new full 
> diffs are totally "logical". We just have to chose one way or the other, 
> and I don't actually much care.

Agreed.
 
> Any reason for your preference? 

Less code on my end, mostly. Which is equivalent to less fiddling for
people patching manually. Going from x.y.z.4 to x.y.(z+1) requires
looping through a bunch more intermediate versions which is tedious
for tracking -tip.

-- 
Mathematics is the supreme nostalgia of our time.
