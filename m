Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVKJAYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVKJAYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVKJAYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:24:12 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:50304 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751106AbVKJAYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:24:10 -0500
Subject: Re: merge status
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
       jgarzik@pobox.com, tony.luck@intel.com, bcollins@debian.org,
       scjody@modernduck.com, dwmw2@infradead.org, rolandd@cisco.com,
       davej@codemonkey.org.uk, axboe@suse.de, shaggy@austin.ibm.com,
       sfrench@us.ibm.com
In-Reply-To: <20051109150141.0bcbf9e3.akpm@osdl.org>
References: <20051109133558.513facef.akpm@osdl.org>
	 <1131573041.8541.4.camel@mulgrave>
	 <Pine.LNX.4.64.0511091358560.4627@g5.osdl.org>
	 <1131575124.8541.9.camel@mulgrave>  <20051109150141.0bcbf9e3.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 19:24:00 -0500
Message-Id: <1131582241.8541.20.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 15:01 -0800, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > it's my contributors who drop me in it
> > by leaving their patch sets until you declare a kernel, dumping the
> > integration testing on me in whatever time window is left.
> 
> Yes, I think I'm noticing an uptick in patches as soon as a kernel is
> released.
> 
> It's a bit irritating, and is unexpected (here, at least).  I guess people
> like to hold onto their work for as long as possible so when they release
> it, it's in the best possible shape.

Well ... I can guess how it goes:

Manager:   "2.6.x is out, are our patches in it"
Developer: .oO(crap I forgot about this, better get my skates on)
           "No, but they will be in the next kernel"
            .oO(As long as I get them in the current merge window)

> I guess all we can do is to encourage people to merge up when it's working,
> not when it's time to merge it into mainline.

OK ... I'd really like that, but I think in order to do that I think we
have to have a tree that represents only everything that's going
upstream.  That would be a -mm but without the patches that aren't going
to be included in the next release.  I suppose we could do this today
simply by making it the sum of all the git trees and nothing else.  The
closer this tree is to what mainline will be next release, the easier it
will be to encourage people to test it.

> One could just say "if I don't have it by the time 2.6.n is released, it
> goes into 2.6.n+2", but that's probably getting outside the realm of
> practicality.

We could always try it.  Practically the way to do this is to reduce the
merge window down to a single day, but to do that you obviously have to
give us prior notice of a 2.6.<x> release, which might be the
impractical bit ...

James


