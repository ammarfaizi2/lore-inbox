Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267003AbUAXUPb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 15:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267005AbUAXUPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 15:15:31 -0500
Received: from smtp.everyone.net ([216.200.145.17]:50186 "EHLO
	rmta03.mta.everyone.net") by vger.kernel.org with ESMTP
	id S267003AbUAXUP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 15:15:26 -0500
Date: Sat, 24 Jan 2004 15:14:37 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: David Lang <david.lang@digitalinsight.com>,
       David Ford <david+hb@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed to public posts
Message-ID: <20040124201437.GA7133@arizona.localdomain>
References: <20040121194315.GE9327@redhat.com> <Pine.LNX.4.58.0401211155300.2123@home.osdl.org> <1074717499.18964.9.camel@localhost.localdomain> <20040121211550.GK9327@redhat.com> <20040121213027.GN23765@srv-lnx2600.matchmail.com> <pan.2004.01.21.23.40.00.181984@dungeon.inka.de> <1074731162.25704.10.camel@localhost.localdomain> <yq0hdyo15gt.fsf@wildopensource.com> <401000C1.9010901@blue-labs.org> <Pine.LNX.4.58.0401221034090.4548@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401221034090.4548@dlang.diginsite.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 10:35:54AM -0800, David Lang wrote:
> On Thu, 22 Jan 2004, David Ford wrote:
> > Considering that Bayesian filters are useless against the new spam that
> > is proliferating these days, that's laughable.  Spam now comes with a
> > good 5-10K of random dictionary words.

I'm curious what Bayesian filters you're using.  The filter I use
(bogofilter.sf.net) regularly catches and properly categorizes these
spams.

A good Bayesian spam filter isn't nearly as susceptible to random words as
some people think.  Words that are likely to be spam (along with words that
are frequently "ham") are given _exponentially_ more weight than other
words.  The only way a group of random words is likely to sway the score is
if it happens upon enough "ham" words to outweigh the message's "spam"
words, and there is just as much chance of randomly picking a "spam" word
as there is of randomly finding "ham".  In any case, you'd need random word
blocks _much_ bigger than 5-10k to make it statistically likely of catching
"ham" tokens.

> so we need to extend the Bayesian filters to deal with multi-word combos,
> how many legit mail has those dictionary words in them? properly traind
> their presence should help identify the spam.

If filters start looking for grammatically correct phrases or sentences,
the spammers will just start pasting in random sections of books or web
pages.  Multi-word and "markov chains" tests will only be helpful if the
filter also does proper weighting of the results.  And, since my filter
works fine today, I'm in no rush to upgrade to a more complex one.

-Kevin

-- 
 ---------------------------------------------------------------------
 | Kevin O'Connor                  "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net               'IMHO', 'FAQ', 'BTW', etc. !"    |
 ---------------------------------------------------------------------
