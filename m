Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSLVJ7e>; Sun, 22 Dec 2002 04:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbSLVJ7e>; Sun, 22 Dec 2002 04:59:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48054 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264886AbSLVJ7d>;
	Sun, 22 Dec 2002 04:59:33 -0500
Date: Sun, 22 Dec 2002 11:13:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212211858240.8783-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212221111080.31068-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Dec 2002, Linus Torvalds wrote:

> Saving and restoring eflags in user mode avoids all of these
> complications, and means that there are no special cases. None. Zero.
> Nada.

and i'm 100% sure the more robust eflags saving will also avoid security
holes. The amount of security-relevant complexity that comes from all the
x86 features [and their combinations] is amazing.

	Ingo

