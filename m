Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275391AbRIZSBb>; Wed, 26 Sep 2001 14:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275392AbRIZSBM>; Wed, 26 Sep 2001 14:01:12 -0400
Received: from ns.suse.de ([213.95.15.193]:29198 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S275393AbRIZSBG>;
	Wed, 26 Sep 2001 14:01:06 -0400
Date: Wed, 26 Sep 2001 20:01:32 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <bcrl@redhat.com>,
        <marcelo@conectiva.com.br>, <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <E15mIfQ-0001E5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0109262000350.8655-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Alan Cox wrote:

> Original core Athlon (step 2 and earlier)
>
> nothing: 11 cycles
> locked add: 22 cycles
> cpuid: 67 cycles
>
> I don't currently have a palomino core to test

Exactly the same as the original core.

nothing: 11 cycles
locked add: 11 cycles
cpuid: 67 cycles

(cpuid varies 63->68)

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

