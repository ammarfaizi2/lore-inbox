Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266132AbSKFVt1>; Wed, 6 Nov 2002 16:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266133AbSKFVt1>; Wed, 6 Nov 2002 16:49:27 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:55825
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266132AbSKFVt0>; Wed, 6 Nov 2002 16:49:26 -0500
Subject: Re: yet another update to the post-halloween doc.
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021106165327.GA11290@suse.de>
References: <20021106140844.GA5463@suse.de>
	<1036599481.3405.1080.camel@phantasy>  <20021106165327.GA11290@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 16:56:11 -0500
Message-Id: <1036619772.3405.1413.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 11:53, Dave Jones wrote:

> I've toyed with this idea, but wondered if perhaps a seperate
> document would be a better idea. Ie, keep this one as a
> end-users guide, and have a seperate programmers guide
> covering things like API changes and the likes.
> The latter would likely be more time consuming than the former,
> we'll see how things go..

Good idea :)

> Wasn't there also some issue in various drivers ? I believe Alan cited
> the 8390 net driver as one example.

Yes, its mainly a performance problem.  In the 8390, for example, you
can get preempted with the specific interrupt disabled (from
disable_irq()).

I will get to fixing those... but biggest concern is the remaining
unprotected per-CPU data.  Which, thankfully, is looking really good -
we are stable.

>  > Albert's tree is a fork.
> 
> *sigh* politics. I changed that text after Albert mailed me complaining
> about the original. Something tells me I'm not going to be able to
> please both of you.  I'll mangle it again, and see which one of you
> complains next time 8-)

Sigh, I guess.  The politics should be whose tree is better - there
should be no issue that Michael Johnson's tree is the original.

> All other suggestions added/changed/etc.
> 
> Thanks for the feedback

You are welcome.

	Robert Love

