Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263411AbVBCTgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbVBCTgx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 14:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbVBCTgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 14:36:53 -0500
Received: from sd291.sivit.org ([194.146.225.122]:23446 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262422AbVBCTcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:32:21 -0500
Date: Thu, 3 Feb 2005 20:32:20 +0100
From: Stelian Pop <stelian@popies.net>
To: lm@bitmover.com, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050203193220.GB29712@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>, lm@bitmover.com,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203033459.GA29409@bitmover.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 07:34:59PM -0800, Larry McVoy wrote:

> (Thanks for the forward, Peter, I would have missed this).

Sorry, I should have cc'ed you directly but I thought you would
never miss a subject containing $(random scm tool) :)

> As Peter said, we do exports from Linus' tree every 24 hours.  I can
> think of two things that we could do which might be useful to the non BK
> users: export more frequently (pretty questionable in my mind but it's
> no big deal to bump it up to twice or whatever) 

As Peter said, once every 6 hours is fine. Or even more often, what
the heck, as I said in a previous post I don't think an incremental
export is that much costly. It could be done at the same time as
the -bkX patches...

> and/or export other trees
> (far more interesting in my mind).

Why not if there is some interest. As far as I am concerned, I 
have the impression that most kernel BK trees in bkbits.net are
just temporary trees 'Linus please pull from here' type. I don't
know if it's useful for somebody else to track those down.
> 
> We're always looking for more ways to help you (or more properly said:
> more ways to be perceived as helping) so let us know what you would like.
> In Bk or out of it.  Is BK/Web good enough?  Need something?  Let us
> know.

Speaking from the out-BK point of view, what would really be nice
is better granularity in the CVS export (a 1-1 changeset to CVS commit
mapping). I know this involves playing with CVS branches and could
be a bit tricky but should be doable.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
