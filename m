Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbTIARXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbTIARXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:23:39 -0400
Received: from unthought.net ([212.97.129.24]:28049 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263114AbTIARXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:23:36 -0400
Date: Mon, 1 Sep 2003 19:23:34 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Larry McVoy <lm@work.bitmover.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Larry McVoy <lm@bitmover.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: bitkeeper comments
Message-ID: <20030901172334.GE14716@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Larry McVoy <lm@work.bitmover.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Larry McVoy <lm@bitmover.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de
References: <20030901170218.A24713@infradead.org> <Pine.LNX.4.44.0309010956390.7908-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0309010956390.7908-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 09:59:58AM -0700, Linus Torvalds wrote:
> 
> On Mon, 1 Sep 2003, Christoph Hellwig wrote:
> > 
> > But we're not going to retroactively censor commit messages.
> 
> Actually, I do that all the time. In fact, it was I who asked Larry to add 
> the "bk comment" command in to make it easy to do so.
> 
> The thing is, it's hard to do after the message has already gone out into 
> the public - but I fix up peoples email commentary by hand both in the 
> email and often later after it has hit my BK tree too. I try to fix 
> obvious typos, and just generally make the things more readable.
> 
> And if the comment was wrong, then it should be fixed. Not because of any 
> "censorship", but because it's misleading if the comment says it fixes 
> something it doesn't fix - and that might make people overlook the _real_ 
> thing the change does.

There is an important difference.

If I send you a mail saying "X" and you change it to say "Y" and put "Y"
in the source tree, fine.  It was a mail between us, noone except you
and me will know.  If I think it's wrong, maybe I can make you submit
"X" to the source tree instead, with an explanation.

Everything that was ever publicly visible, stays publicly visible, even
with the the revised comments, thanks to the revision history.

But changing the source tree revision history retroactively, that's bad.
It defies the purpose of revision control itself.

The source tree is a public record. People will remember "this said 'Y'
I'm sure, but now it says 'X', why is that?" - and noone can answer.
History forgotten.

It's your call, but I can certainly see why some feel bad about this.

After all, we wouldn't want to edit the e-mail archives to remove all
trace of what happened, either, would we?   ;)

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
