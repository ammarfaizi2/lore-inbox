Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbSLESAK>; Thu, 5 Dec 2002 13:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbSLESAK>; Thu, 5 Dec 2002 13:00:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56584 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267421AbSLESAF>; Thu, 5 Dec 2002 13:00:05 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: is KERNEL developement finished, yet ???
Date: Thu, 5 Dec 2002 18:07:22 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aso4kq$2ka$1@penguin.transmeta.com>
References: <200212051224.50317.shanehelms@eircom.net> <000901c29c5d$6d194760$2e833841@joe>
X-Trace: palladium.transmeta.com 1039111649 19330 127.0.0.1 (5 Dec 2002 18:07:29 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 5 Dec 2002 18:07:29 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <000901c29c5d$6d194760$2e833841@joe>,
Joseph D. Wagner <wagnerjd@prodigy.net> wrote:
>
>Unix (and Linux) developers are far too concerned with clinging to the
>30-year-old outdated POSIX standard, which creates numerous problems when
>trying to advance new features.

No.

Only stupid people think they should throw away old proven concepts. 
What happens quite often in academia in particular is that you find a
problem you want to fix, and you re-design the whole system around your
fix. 

This is how we get crap like microkernels.  They have "an agenda", and
that's the _worst_ thing you can have when designing software.  You
fixate on some perceived problem, and the end result is that yes, maybe
you fixed _that_ problem, but in the meantime you also generated a whole
new of issues - usually things that were solved by the original
approach. 

The UNIX/Linux approach is a very pragmatic thing - leave the things
that work well alone.  There's no point in re-inventing the whole system
just because of some small perceived flaws. 

>This is not a design flaw per say, but let's face it: Unix would be a lot
>more secure (and more flexible in it's security) with ACL's.
>
>Microsoft Windows has had ACL's since 1991 (Windows NT 3.5?); that was 11
>years ago.

Yeah, and look how much more secure it is than UNIX.

		Linus
