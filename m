Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318275AbSG3NhN>; Tue, 30 Jul 2002 09:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318280AbSG3NhM>; Tue, 30 Jul 2002 09:37:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27410 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318275AbSG3NhM>; Tue, 30 Jul 2002 09:37:12 -0400
Date: Tue, 30 Jul 2002 06:40:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
       <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>
Subject: Re: async-io API registration for 2.5.29
In-Reply-To: <20020730091140.A6726@infradead.org>
Message-ID: <Pine.LNX.4.44.0207300637230.2599-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Jul 2002, Christoph Hellwig wrote:
>
> And even if there is a syscall reservation the way to do it is not to add
> the real syscall names to entry.S and implement stubs but to use
> sys_ni_syscall.

Note that something needs to get moving on this rsn, I'm not interested in
getting aio patches on Oct 30th. The feature freeze may be on Halloween,
but if I get some big feature just days before I'm likely to just say
"screw it".

I think we can still change the stuff in 2.5.x, but I really want to start
seeing some code, so that I'm not taken by surprise by something that
obviously sucks.

Is there any activity on linux-aio? I haven't heard anything since Ottawa.

		Linus

