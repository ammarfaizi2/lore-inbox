Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262558AbSI0S5v>; Fri, 27 Sep 2002 14:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262561AbSI0S5u>; Fri, 27 Sep 2002 14:57:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56771 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262558AbSI0S5t>;
	Fri, 27 Sep 2002 14:57:49 -0400
Date: Fri, 27 Sep 2002 21:12:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache' take #2,
 vcache-2.5.38-C4
In-Reply-To: <Pine.LNX.4.44.0209272043260.17678-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209272111130.18454-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [...] The method is to do a cheap physpage lookup (ie. only the
> read-lock is taken, the page is forced writable), [...]
                                 ^---not

