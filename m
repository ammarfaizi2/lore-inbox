Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTESPwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 11:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbTESPwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 11:52:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40866 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id S261190AbTESPwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 11:52:41 -0400
Date: Mon, 19 May 2003 18:02:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: bert hubert <ahu@ds9a.nl>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2
In-Reply-To: <20030519144716.GA20193@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0305191801480.13379-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 May 2003, bert hubert wrote:

> I for one would want the ability to select, poll and epoll on a futex
> while also being notified of availability of data on sockets. I see no
> alternative even, except for messing with signals or running select with
> a small timeout, introducing needless latency.
> 
> It may be weird, but it does work in practice. 'Unrobust' would be a
> problem but I fail to see how this is unclean.

ok, i was flaming away mindlessly. New patch on the way.

	Ingo

