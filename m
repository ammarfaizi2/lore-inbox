Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132512AbRDKBE6>; Tue, 10 Apr 2001 21:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132513AbRDKBEt>; Tue, 10 Apr 2001 21:04:49 -0400
Received: from ns.suse.de ([213.95.15.193]:36366 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132512AbRDKBEk>;
	Tue, 10 Apr 2001 21:04:40 -0400
Date: Wed, 11 Apr 2001 03:04:30 +0200
From: Andi Kleen <ak@suse.de>
To: David Weinehall <tao@acc.umu.se>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
Message-ID: <20010411030430.A29239@gruyere.muc.suse.de>
In-Reply-To: <20010410220551.A24251@gruyere.muc.suse.de> <E14n6Be-0005Ir-00@the-village.bc.nu> <20010411020058.B28670@gruyere.muc.suse.de> <20010411021318.A21221@khan.acc.umu.se> <20010411022028.A28874@gruyere.muc.suse.de> <20010411025632.C21221@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010411025632.C21221@khan.acc.umu.se>; from tao@acc.umu.se on Wed, Apr 11, 2001 at 02:56:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 02:56:32AM +0200, David Weinehall wrote:
> My reasoning is that the choice of computer is a direct function of
> your financial situation. I can get hold of a lot of 386's/486's, but
> however old a Pentium may be, people are still reluctant to give away
> those. Doing the sometimes necessary updates on my 386:en is already
> painfully slow, and I'd rather not take another performance hit.

As long as you don't use multithreaded applications there is no performance
hit with a kernel-mode CMPXCHG handler. iirc most multithreaded applications
are either too bloated for a 386 anyways, or trivial so that it doesn't matter.

-Andi

