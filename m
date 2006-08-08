Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWHHOr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWHHOr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWHHOr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:47:56 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:60567 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S932457AbWHHOrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:47:55 -0400
Date: Tue, 8 Aug 2006 17:47:54 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Jes Sorensen <jes@sgi.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Time to forbid non-subscribers from posting to the list?
Message-ID: <20060808144754.GB3021@mea-ext.zmailer.org>
References: <f19298770608080407n5788faa8x779ad84fe53726cb@mail.gmail.com> <p73y7tzo4hl.fsf@verdi.suse.de> <f19298770608080447l3e31465fqb6fbc8cfed71cb80@mail.gmail.com> <yq03bc7v3uy.fsf@jaguar.mkp.net> <f19298770608080503l349899cftc421239d1985bb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19298770608080503l349899cftc421239d1985bb3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 04:03:07PM +0400, Alexey Zaytsev wrote:
> On 08 Aug 2006 07:55:33 -0400, Jes Sorensen <jes@sgi.com> wrote:
> >>>>>> "Alexey" == Alexey Zaytsev <alexey.zaytsev@gmail.com> writes:
> >Alexey> On 08 Aug 2006 13:23:50 +0200, Andi Kleen <ak@suse.de> wrote:
> >>> You would make bug reports impossible from normal people who don't
> >>> want to subscribe fully. It would totally wreck the development
> >>> model.
> >Alexey> If they don't want to subscribe, they can just report to the
> >Alexey> list as usual, theyr mail will be only slightly delayed
> >Alexey> because of moderation.  We could even use some sort of white
> >Alexey> lists, if a user's mail was once approved, all his further
> >Alexey> mail will be accepthed without moderation.
> >
> >At 400-500 mails per day, who is going to handle the moderation? Sure
> >only a portion would be held back, but there's plenty other work to do
> >and we want fast turnaround for user bug reports, so if a user is
> >asked a question he/she can respond quickly with more details.
> 
> I'm sure not all the 500 mails are from non-subscribers, and, as I
> told, we could split the traffic between a large number of moderators.

We already have a rather well working filter that very rarely rejects
any valid emails.   That is around 300 to 900 per day (yes, we do collect
them all into daily message folders.)

Postings by non-members are rare - and even for those regular posters
that don't want to receive but do want to send we could have a simple
"subscribe to linux-posters -list" rule.  Nevertheless that does not
validate message poster person to be list member, just that the email
address in the "From:" header is known.   (I have been receiving for
years some email virus that claims to be coming from Alan Cox...)

So, having a well working web-based "approve these" filter (something
totally different from what Mailman does - that does not work with
tens of thousands of messages in the moderation queue) that gets only
a very small subset of things could work -- but whom would you trust
to be the moderator ?  If anybody could become one (for ease to get
people to do it), could they still do similar stupidities as these
recent "lets subscribe  linux-kernel  -list on many email lists"
attacks have tried to be ?

Having two-tiered moderation could work -- taboo-filters reject
pure junk, and that does not arrive to voluntary moderators at
all. Then rest can be processed by volunteers, and all that they
get (via dedicated linux-list-moderators  -list or some such) is
an email every 3 hours of "NN messages in moderation queue" along
with queue management tool URL.  No authentication, just queue
processing, and the tool shows only beginnings of ten oldest
messages in the queue with some smart javascript to optionally hide
99% of message headers (and to reveal them when somebody wants to
peek inside to know what is happening..)

That way the burden shouldn't be too bad (burden that will kill such
moderation effort) while likely valid messages still do get thru.

If they need help (horrible flood of junk passed thru pre-filters)
they can issue a help request to system postmasters to tune the
pre-filters and to use some heavy-duty tools to shove away most
junk from the queue.

Any volunteers to write couple perl tools ?


> >Just install a proper spam filter like everyone else.
> >Jes

/Matti Aarnio
