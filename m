Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbTIARmy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTIARlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:41:17 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:35821 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263181AbTIARkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:40:42 -0400
Date: Mon, 1 Sep 2003 10:40:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: Christoph Hellwig <hch@infradead.org>,
       Jakob Oestergaard <jakob@unthought.net>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Larry McVoy <lm@bitmover.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: bitkeeper comments
Message-ID: <20030901174032.GD16620@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jakob Oestergaard <jakob@unthought.net>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Larry McVoy <lm@bitmover.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	ak@suse.de
References: <20030901170218.A24713@infradead.org> <Pine.LNX.4.44.0309010956390.7908-100000@home.osdl.org> <20030901172334.GE14716@unthought.net> <20030901182827.A26176@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901182827.A26176@infradead.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 06:28:27PM +0100, Christoph Hellwig wrote:
> On Mon, Sep 01, 2003 at 07:23:34PM +0200, Jakob Oestergaard wrote:
> > There is an important difference.
> > 
> > If I send you a mail saying "X" and you change it to say "Y" and put "Y"
> > in the source tree, fine.  It was a mail between us, noone except you
> > and me will know.  If I think it's wrong, maybe I can make you submit
> > "X" to the source tree instead, with an explanation.
> > 
> > Everything that was ever publicly visible, stays publicly visible, even
> > with the the revised comments, thanks to the revision history.
> > 
> > But changing the source tree revision history retroactively, that's bad.
> > It defies the purpose of revision control itself.
> > 
> > The source tree is a public record. People will remember "this said 'Y'
> > I'm sure, but now it says 'X', why is that?" - and noone can answer.
> > History forgotten.
> 
> Yupp, that's what I meant.  I certainly don't want a thought police
> on my source trees.

Trivial w/ the current BK because the comments aren't versioned.  Just have
someone be elected as the archiver and have them have a cron job which pulls
bkbits.net every 20 minutes or so.  Then if the comments are ever changed
your archive will have the originals.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
