Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281818AbRLGPZt>; Fri, 7 Dec 2001 10:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281836AbRLGPZj>; Fri, 7 Dec 2001 10:25:39 -0500
Received: from dsl-213-023-043-071.arcor-ip.net ([213.23.43.71]:29705 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S281818AbRLGPZ0>;
	Fri, 7 Dec 2001 10:25:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Yusuf Goolamabbas <yusufg@outblaze.com>
Subject: Re: 2.4.17-pre2+ext3-0.9.16+anton's cache aligned smp
Date: Fri, 7 Dec 2001 16:27:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org, anton@samba.org,
        axboe@suse.de
In-Reply-To: <3C0B12C5.F8F05016@zip.com.au> <20011206163056.A15550@outblaze.com> <3C0F301D.3368595@zip.com.au>
In-Reply-To: <3C0F301D.3368595@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16CMuT-0000tz-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 6, 2001 09:45 am, Andrew Morton wrote:
> Yusuf Goolamabbas wrote:
> > 
> > Running 2.4.17-pre2 + ext3-0.9.16 + Anton Blanchards
> > cacheline_aligned_smp patch available at
> > 
> > http://samba.org/~anton/linux/cacheline_aligned/
> 
> omigod look at that graph.
> 
> Excuse me while I get frustrated.  Will someone *please* send that
> damn patch to marcelo@conectiva.com.br?
> 
> (It can be improved further by putting padding *behind* the lock
> but hey).
> 
> > ...
> > 
> > With Anton's patch, the number of ctx-swtch/sec drops by around 3000
> > from avg of 9000 (for 17-pre2+ext3) to avg of 6000 (with anton) as seen
> > by vmstat 1
> 
> Really?  The spinlock cacheline alignment alone made that
> difference?  I wonder why.

Before getting *too* excited, remember, it's dbench, so effects could easily 
be magnified.  Maybe test with something better behaved?

--
Daniel
