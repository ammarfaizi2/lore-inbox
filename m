Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132519AbRDKBM6>; Tue, 10 Apr 2001 21:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132517AbRDKBMi>; Tue, 10 Apr 2001 21:12:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:20241 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132514AbRDKBMh>; Tue, 10 Apr 2001 21:12:37 -0400
Date: Tue, 10 Apr 2001 18:12:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: David Weinehall <tao@acc.umu.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
In-Reply-To: <20010411030739.A29277@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.31.0104101809260.15069-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Apr 2001, Andi Kleen wrote:
>
> Fixup for user space is probably not that nice (CMPXCHG is used there by
> linuxthreads)

In user space I'm not convinced that you couldn't do the same thing
equally well by just having the proper dynamically linked library.  You'd
not get in-lined lock primitives, but that's probably fine.

		Linus

