Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSLXUS7>; Tue, 24 Dec 2002 15:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbSLXUS7>; Tue, 24 Dec 2002 15:18:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21000 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265815AbSLXUS7>; Tue, 24 Dec 2002 15:18:59 -0500
Date: Tue, 24 Dec 2002 12:27:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212242116290.6603-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212241225100.1219-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Dec 2002, Ingo Molnar wrote:
>
> this reminds me of another related matter that is not fixed yet, which bug
> caused XFree86 to crash if it was linked against the new libpthreads - in
> vm86 mode we did not save/restore %gs [and %fs] properly, which breaks
> new-style threading. The attached patch is against the 2.4 backport of the
> threading stuff, i'll do a 2.5 patch after christmas eve :-)

Actually, pretty much nothing has changed in vm86 handling, so the patch
should work fine as-is on 2.5.x too.

		Linus

