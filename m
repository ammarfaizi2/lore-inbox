Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269799AbUJVHdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269799AbUJVHdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269839AbUJVHc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 03:32:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61838 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269799AbUJSQtL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:49:11 -0400
Date: Tue, 19 Oct 2004 17:49:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Cherry <cherry@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9... (compile stats)
Message-ID: <20041019164910.GJ23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019161834.GA23821@one-eyed-alien.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 09:18:34AM -0700, Matthew Dharm wrote:
> These are x86-based stats, yes?  I'm sure other arches will likely tease
> out more...
> 
> A lot of these seem to be related to readl/writel (readb/writeb, etc).
> Those should be straightforward one-line changes, I think... perhaps a job
> for more automated scripting?
> 
> At the very least, it would be nice to post-process the data to show which
> modules are the offenders (and by how much).

Note that quite a few of them are already fixed, and no, not all fixes
had been trivial (read: there had been real bugs found by these warnings).

I'm going to do 2.6.9-bird1 once netdev situation settles down (a bunch of
patches from -bird are getting merged into bk-net).
