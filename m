Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281799AbRKWI5J>; Fri, 23 Nov 2001 03:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281814AbRKWI5A>; Fri, 23 Nov 2001 03:57:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59849 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281815AbRKWI4t>;
	Fri, 23 Nov 2001 03:56:49 -0500
Date: Fri, 23 Nov 2001 11:54:30 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sunrpc woes with tux2 in 2.4.15-pre8,9
In-Reply-To: <3BFD7633.2525641E@pobox.com>
Message-ID: <Pine.LNX.4.33.0111231153160.3988-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Nov 2001, J Sloan wrote:

> In 2.4.15-pre8 I applied the tux2 patches to
> take it for a spin - well, it's insanely fast, thanks
> Ingo - but I am having a problem with the sun
> rpc module:

> depmod: *** Unresolved symbols in
> depmod:         atomic_dec_and_lock_R648ef859

hm, it's exported. What does 'grep dec_and_lock /proc/ksyms' show on your
box?

	Ingo

