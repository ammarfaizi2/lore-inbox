Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWFKGMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWFKGMe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 02:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWFKGMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 02:12:33 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:24328 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932106AbWFKGMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 02:12:33 -0400
Date: Sun, 11 Jun 2006 08:12:10 +0200
From: Willy Tarreau <w@1wt.eu>
To: jdow <jdow@earthlink.net>
Cc: Neil Brown <neilb@suse.de>, David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
Message-ID: <20060611061210.GA13255@w.ods.org>
References: <17547.42403.669502.694618@cse.unsw.edu.au> <193f01c68d17$92570ae0$0225a8c0@Wednesday>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193f01c68d17$92570ae0$0225a8c0@Wednesday>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 10, 2006 at 10:26:19PM -0700, jdow wrote:
 
> No sir. FAIL and SOFT_FAIL prove nothing. PASS proves remarkably
> little. SPF is not a good criterion for much of anything.
> 
> >I think kernel.org is a great site to be an early adopter because:
> > - the mail it transports isn't critical
> > - it interacts with a very large number of mail sites
> > - it's customers are reasonably technology-savvy. 
> 
> It would be a good site to adopt it outgoing. But adopting it as an
> incoming message filter is silly.

So by your definition, this method is useful only on outgoing emails
but never on incoming ones. I fail to see how it might be useful
outgoing if nobody checks incoming emails...

> >(No, SPF doesn't stop spam, but it can increase accountability so that
> >white/black lists can begin to be more usable).
> 
> It does not even do that conclusively. Many of us wish it did. But if
> a spammer can post his own spf records he can claim what he wants
> about email sources. DNS cache poisoning attacks assure that this can
> take place even for sites you might control.

I think that *nobody* can tell whether the result will have positive
or negative effect. This list is populated by technical people who
will be able to participate to the test. A first approach would be
to add a header to the incoming emails telling how they have been
classified, so that people know if their config could lead them to
being blocked in the future. If, after a long test period, we notice
that it causes lots of false positives and that spams still don't
get detected, it may be time to give up on this method. Conversely,
if it turns out that only spam gets detected and that we have no
false positives, why not go one step further then ?

> {^_^}   Joanne Dow said that. Seriously, I recommend a pass through the
>        old SpamAssassin users mailing list for past discussions. An
>        SPF_HELO_SOFTFAIL is the only thing given a sizeable score.

Regards,
Willy

