Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312891AbSDCAFo>; Tue, 2 Apr 2002 19:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312904AbSDCAFd>; Tue, 2 Apr 2002 19:05:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36356 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312891AbSDCAFX>; Tue, 2 Apr 2002 19:05:23 -0500
Date: Tue, 2 Apr 2002 16:04:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: Michal Moskal <malekith@pld.org.pl>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.1 ffs problem, kernel 2.4.18
In-Reply-To: <20020402145955.A12932@twiddle.net>
Message-ID: <Pine.LNX.4.33.0204021604190.1760-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Apr 2002, Richard Henderson wrote:
> 
> That said, we should probably be using __builtin_ffs
> instead.  The compiler knows how to do bsfl plus the
> adjustment.  Plus, it knows how to evaluate it at
> compile-time for constants.

When was __builtin_ffs introduced? I know it didn't use to exist, but 
we've obviously bumped up the gcc requirements several times, so..

		Linus

