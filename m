Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275458AbRIZSkc>; Wed, 26 Sep 2001 14:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275456AbRIZSkW>; Wed, 26 Sep 2001 14:40:22 -0400
Received: from ns.suse.de ([213.95.15.193]:57874 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S275455AbRIZSkG>;
	Wed, 26 Sep 2001 14:40:06 -0400
Date: Wed, 26 Sep 2001 20:40:32 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        <bcrl@redhat.com>, <marcelo@conectiva.com.br>, <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <Pine.LNX.4.33.0109261123380.8558-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0109262036480.8655-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Linus Torvalds wrote:

> > > cpuid: 72 cycles
> > cpuid: 79 cycles
> > Only slightly worse, but I'd not expected this.
> That difference can easily be explained by the compiler and options.

Actually repeated runs of the test on that box show it deviating by up
to 10 cycles, making it match the results that Alan posted.
-O2 made no difference, these deviations still occur. They seem more
prominent on the C3 than other boxes I've tried, even with the same
compiler toolchain.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

