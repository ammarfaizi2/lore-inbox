Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318718AbSIEWcx>; Thu, 5 Sep 2002 18:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSIEWcx>; Thu, 5 Sep 2002 18:32:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11930 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318718AbSIEWcw>;
	Thu, 5 Sep 2002 18:32:52 -0400
Date: Fri, 6 Sep 2002 00:41:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
In-Reply-To: <20020905222947.GA13667@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209060040110.17575-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Right - let me rephrase.  Tasks which are either:
> > >   - untraced, normal
> > >   - traced, but traced _by their parent_
> > > are on the sibling/children list.

okay, agreed, this description is correct. Obviously if the parent is the
debugger then a traced task will be in the ->children list.

	Ingo

