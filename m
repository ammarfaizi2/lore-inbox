Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275377AbRIZRqL>; Wed, 26 Sep 2001 13:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275381AbRIZRqC>; Wed, 26 Sep 2001 13:46:02 -0400
Received: from ns.suse.de ([213.95.15.193]:48652 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S275379AbRIZRpN>;
	Wed, 26 Sep 2001 13:45:13 -0400
Date: Wed, 26 Sep 2001 19:45:39 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        <bcrl@redhat.com>, <marcelo@conectiva.com.br>, <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0109261945090.8655-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Linus Torvalds wrote:

> What are the athlon numbers?

nothing: 11 cycles
locked add: 11 cycles
cpuid: 63 cycles

(cpuid varies between 63->68 here)

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

