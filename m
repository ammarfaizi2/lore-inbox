Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTGBTtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 15:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTGBTtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 15:49:17 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:19829 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264461AbTGBTtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 15:49:16 -0400
Date: Wed, 2 Jul 2003 12:58:22 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-Id: <20030702125822.329463f5.akpm@digeo.com>
In-Reply-To: <UTC200307021942.h62Jg1L20419.aeb@smtp.cwi.nl>
References: <UTC200307021942.h62Jg1L20419.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2003 20:03:41.0133 (UTC) FILETIME=[088017D0:01C340D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> (Usually I plan a track and submit individual steps.
> When they get applied I continue.
> If not, there is not need to waste time on the rest.)

As someone who is on the receiving end of this process I must say that it
is not comfortable.

It really helps to be able to see the whole thing laid out all at the same
time.  So we can see that it works, so that we can see that the end result
is the right one, etc.

Whereas receiving a long drawn out trickle of patches is quite confusing. 
One doesn't know where it is leading, nor where it will end, nor when to
get down and actually start testing it, etc.  Nor whether this ongoing
churn is stomping on someone else's development effort.

And there is the risk that you get halfway through and then suddenly "no
way, we don't want to do that".  Then what?  Argue?  Revert?


So for everyone except the guy who's writing the code it is best to have
all the work in place and reviewable at the same time.

For the author, yes, there is a risk that more code than necessary will be
tossed away.  We can minimise that by discussing things beforehand, getting
understanding and agreement from the relevant people on the intended
direction.  I think we have done that for cryptoloop.  We still have not
really done it for 64-bit dev_t.


