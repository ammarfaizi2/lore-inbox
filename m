Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264922AbSJPOqH>; Wed, 16 Oct 2002 10:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265023AbSJPOpD>; Wed, 16 Oct 2002 10:45:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265018AbSJPOoR>; Wed, 16 Oct 2002 10:44:17 -0400
Date: Wed, 16 Oct 2002 07:52:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: NPT library mailing list <phil-list@redhat.com>,
       Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [patch] mmap-speedup-2.5.42-C3
In-Reply-To: <Pine.LNX.4.44.0210161013050.4573-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210160751260.2181-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Oct 2002, Ingo Molnar wrote:

> 
> On Tue, 15 Oct 2002, Saurabh Desai wrote:
> 
> >   Yes, the test_str02 performance improved a lot using NPTL.
> >   However, on a side effect, I noticed that randomly my current telnet
> >   session was logged out after running this test. Not sure, why?
> 
> i think it should be unrelated to the mmap patch. In any case, Andrew
> added the mmap-speedup patch to 2.5.43-mm1, so we'll hear about this
> pretty soon.

There's at least one Oops-report on linux-kernel on 2.5.43-mm1, where the 
oops traceback was somewhere in munmap(). 

Sounds like there are bugs there.

		Linus

