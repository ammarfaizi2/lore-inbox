Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSJaVHH>; Thu, 31 Oct 2002 16:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265354AbSJaVFy>; Thu, 31 Oct 2002 16:05:54 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:44207 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265352AbSJaVEx>;
	Thu, 31 Oct 2002 16:04:53 -0500
Subject: Re: What's left over.
From: john stultz <johnstul@us.ibm.com>
To: Stephen Frost <sfrost@snowman.net>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021031031932.GQ15886@ns>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
	<Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com> 
	<20021031031932.GQ15886@ns>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 13:09:21 -0800
Message-Id: <1036098562.12714.50.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 19:28, Stephen Frost wrote:
> The feeling I got on this was the ability to let users define their own
> groups.  Perhaps I'm not following it closely enough but that was the
> impression I got in terms of "what this does for us"; I'm probably
> missing other things.  Just that ability would be nice in my view
> though.  Isn't it something that's been in AFS for a long time too?
> I've got a few friends who've played with AFS before (at CMU and the
> like) and really enjoyed the ACLs there.

Yea, I haven't looked at the submitted implementation, but at CMU ACLs
were critical to be able to selectively share data between a very large
set of users w/o bugging an administrator. Given multiple classes per
semester which had multiple group projects, where you may have different
groups for each project, I have no clue how anyone would be able to
handle the (unix)group management required. ACLs let the users
themselves manage what people got what access to their data.

How else can I fix my partner's bugs (or vice-versa), give the clumsy TA
read only access, and let the cheat across the hall figure it out for
himself? (There may very well be a good solution to this w/o ACLs but
I've not seen it in use.)

So yea, I'd love to see a common ACLs API.
-john

