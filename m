Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTI3EWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 00:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbTI3EWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 00:22:25 -0400
Received: from hockin.org ([66.35.79.110]:13836 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263102AbTI3EWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 00:22:24 -0400
Date: Mon, 29 Sep 2003 21:11:55 -0700
From: Tim Hockin <thockin@hockin.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, braam@clusterfs.com, neilb@cse.unsw.edu.au,
       David Meybohm <dmeybohm@bellsouth.net>
Subject: Re: [PATCH] Many groups patch.
Message-ID: <20030929211155.A28089@hockin.org>
References: <Pine.LNX.4.44.0309291024040.28114-100000@home.osdl.org> <20030930033134.AC71E2C0A4@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030930033134.AC71E2C0A4@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Sep 30, 2003 at 09:30:07AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 09:30:07AM +1000, Rusty Russell wrote:
> > Why?
> 
> (Rusty points at Tim).
> 
> He has 10,000 groups.  Now me, I'm happy with the minimal fix.

I'm going to merge your thoughts and mine tomorrow and send it out.  Linus
suggested the array of pages approah is more sane, so I'm going to try for
it.  I'm going to comb through the diffs between your patch and mine.

> And worse, there are the intermediate kmallocs which would need to be
> fixed (thanks to Stephen Rothwell for pointing this out).  Fixing this
> would make it even uglier.

Specifically?  I think my patch gets all of those.  At least all the ones I
found.

> Here's an updated one (with David Meybohm's fix, too -- Thanks!),
> Rusty.

Can you elaborate on what this extra fix is?
