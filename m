Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSBFUpQ>; Wed, 6 Feb 2002 15:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290802AbSBFUpJ>; Wed, 6 Feb 2002 15:45:09 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:8834 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S290796AbSBFUpC>; Wed, 6 Feb 2002 15:45:02 -0500
Date: Wed, 06 Feb 2002 15:44:43 -0500 (EST)
Message-Id: <20020206.154443.02210556.wscott@bitmover.com>
To: trini@kernel.crashing.org
Cc: hch@ns.caldera.de, lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
From: Wayne Scott <wscott@bitmover.com>
In-Reply-To: <20020206194515.GJ1447@opus.bloom.county>
In-Reply-To: <20020206000343.I14622@work.bitmover.com>
	<200202061935.g16JZLh18377@ns.caldera.de>
	<20020206194515.GJ1447@opus.bloom.county>
X-Mailer: Mew version 2.1.52 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rini <trini@kernel.crashing.org>
> On Wed, Feb 06, 2002 at 08:35:21PM +0100, Christoph Hellwig wrote:
> > Btw, is there a generic way to move repos cloned from Ted's (now
> > orphaned?) 2.4 tree to Linus' official one?
> 
> Working under the assuming that Linus started his own tree first and
> didn't grab Ted's, no.

Right.  And yes Linus tree was started from scratch.  He started with
2.4.0 and imported all prepatches.  The 2.5 tree was created as a
clone of the 2.4 tree at the appropriate place.

So Chris is right csets in Ted's tree won't directly apply to Linus'
tree.  Sorry.

I think 'bk export -tpatch' and 'bk import -tpatch' is called for.
You might find the new 'bk comments' command (new in 2.1.4) useful to
fixup the comments after 'bk import'.

If you have a large ammount of state to transfer, let me know and
maybe we can rig up something better.

-Wayne

