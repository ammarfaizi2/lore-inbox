Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268324AbRG3FT7>; Mon, 30 Jul 2001 01:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268327AbRG3FTt>; Mon, 30 Jul 2001 01:19:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:15624 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268324AbRG3FTf>; Mon, 30 Jul 2001 01:19:35 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sun, 29 Jul 2001 22:04:59 -0700
Message-Id: <200107300504.f6U54xk01254@penguin.transmeta.com>
To: hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hold cow while breaking
Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.21.0107292212330.1139-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0107291350540.937-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <Pine.LNX.4.21.0107292212330.1139-100000@localhost.localdomain> you write:
>
>Sure, I agree with you on that, but it doesn't let us off the hook.
>This isn't necessarily the first reuse of that page: after paging it
>out and freeing it, it may have got allocated to some other purpose
>and freed again, and then reassigned to the original use.

Ok, you've convinced me. Thanks for showing me the error of my ways.
Fixed.

		Linus
