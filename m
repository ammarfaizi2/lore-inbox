Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275389AbRIZR7V>; Wed, 26 Sep 2001 13:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275391AbRIZR7L>; Wed, 26 Sep 2001 13:59:11 -0400
Received: from ns.suse.de ([213.95.15.193]:20238 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S275389AbRIZR7H>;
	Wed, 26 Sep 2001 13:59:07 -0400
Date: Wed, 26 Sep 2001 19:59:34 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <bcrl@redhat.com>,
        <marcelo@conectiva.com.br>, <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <E15mIoy-0001Hd-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0109261958290.8655-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Alan Cox wrote:

> VIA Cyrix CIII (original generation 0.18u)
>
> nothing: 28 cycles
> locked add: 29 cycles
> cpuid: 72 cycles

Interesting. From a newer C3..

nothing: 30 cycles
locked add: 31 cycles
cpuid: 79 cycles

Only slightly worse, but I'd not expected this.
This was from a 866MHz part too, whereas you have a 533 iirc ?

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

