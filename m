Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbTAAVWh>; Wed, 1 Jan 2003 16:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbTAAVWh>; Wed, 1 Jan 2003 16:22:37 -0500
Received: from franka.aracnet.com ([216.99.193.44]:63440 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264679AbTAAVWf>; Wed, 1 Jan 2003 16:22:35 -0500
Date: Wed, 01 Jan 2003 13:30:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@zip.com.au>, Dave Jones <davej@codemonkey.org.uk>,
       "Timothy D. Witham" <wookie@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Raw data from dedicated kernel bug database
Message-ID: <12310000.1041456646@titus>
In-Reply-To: <20030101194019.GZ5607@work.bitmover.com>
References: <20030101194019.GZ5607@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What are the chances that the raw data from the kernel bugdb could be
> made available?  I bet Bradford wants it and I know I want.  We are
> working on an integrated bugdb for BitKeeper and it would be cool if
> we could track the real db at osdl.
>
> The advantage of having the data available is that for the BK kernel
> users we could give them access to the bugdb while they are doing
> checkins so that the developers link the changes to the bugs as they
> do the fixes, which is a good time to do it.
>
> To calm any fears that we are trying to take over the bugdb, we're not.
> We just want to track it.  Any changes made in a BK bugdb are trivially
> exportable to an external format and if the need arises we'll work with
> IBM/OSDL to make that happen.  In fact, we can automate it.

This needs some more thought about how this would work, and exactly what
we'd achieve by doing it. I think this is only going to work if it's a
2-way link, fully automated - I'm not keen on creating a situation
with two disjoint sets of data. Having access to bug data at checkin
time sounds useful to me, but not if that data doesn't get fed back up
to the main database.

Fully automated links would have to be done very carefully to avoid
screwing things up - having a agent going wild logging stuff at high
rates doesn't sound fun to me. If you only needed to edit some seperate
BK field we added to the database for a reference, that would seem at
first thought to be a lot easier and safer.

I'm not sure how other people feel about exporting stuff into bitkeeper
type-licensed products ... if the non-BK people like Alan and Andrew, and
the other people who've done lots of the work in the DB like Dave and 
Randy,
and the OSDL are OK with it, then I'd be willing to help. If they object,
then probably not. Personally, I'm not opposed to using non-free software,
but I find the fact that BK licensing changed after it had been adopted
extremely unsettling ... the merge / diff-viewer tool looks cool though ;-)

M.

