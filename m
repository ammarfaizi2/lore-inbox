Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbTCQOIE>; Mon, 17 Mar 2003 09:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261662AbTCQOIE>; Mon, 17 Mar 2003 09:08:04 -0500
Received: from wireless-12-106-137-195.fortmail.com ([12.106.137.195]:64423
	"EHLO desk.wscott1.homeip.net") by vger.kernel.org with ESMTP
	id <S261559AbTCQOID>; Mon, 17 Mar 2003 09:08:03 -0500
Date: Mon, 17 Mar 2003 09:18:38 -0500 (EST)
Message-Id: <20030317.091838.74743468.wscott@bitmover.com>
To: pavel@suse.cz
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org, ockman@penguincomputing.com,
       dev@bitmover.com
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
From: Wayne Scott <wscott@bitmover.com>
In-Reply-To: <20030316134558.GH8057@zaurus.ucw.cz>
References: <20030312034330.GA9324@work.bitmover.com>
	<20030316134558.GH8057@zaurus.ucw.cz>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@suse.cz>
> As far as I can see, linux-2.5 repository has over 17000 ChangeSets,
> that means half the granularity.

I assume this has already been answered since this is Monday morning
and I haven't finished my mountain of email (I try not to read it on
weekends), but I will answer this anyway.

The ChangeSet file has many csets and we only capture around 1/2 of
them in CVS ChangeSet file.  The extra ChangeSets are grouped together
with the merge cset where they were added to the path we are
recording.  That is correct, but it is not the whole story.

What happens is that most csets modifiy a non overlapping set of
files.  So while we didn't get every delta to the ChangeSet file, we
did capture >90% of the actual changes to the source files in the
tree.

Perhaps that will help explain things.

-Wayne

