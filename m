Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319027AbSHMRPo>; Tue, 13 Aug 2002 13:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319028AbSHMRPn>; Tue, 13 Aug 2002 13:15:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37588 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319027AbSHMRPm>;
	Tue, 13 Aug 2002 13:15:42 -0400
Date: Tue, 13 Aug 2002 19:19:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erik Andersen <andersen@codepoet.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] clone_startup(), 2.5.31-A0
In-Reply-To: <20020813160924.GA3821@codepoet.org>
Message-ID: <Pine.LNX.4.44.0208131918360.4369-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Erik Andersen wrote:

> > First the name souns horrible.  What about spawn_thread or create_thread
> > instead?  it's not our good old clone and not a lookalike, it's some
> > pthreadish monster..
> 
> How about "clone2"?

ni fact it was sys_clone2() first time around, but Ulrich Drepper
requested another name for it because in glibc it collided with ia64 where
clone2() is something different. So whatever name there is going to be, it
should not be sys_clone2().

	Ingo

