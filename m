Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285058AbRLFIqG>; Thu, 6 Dec 2001 03:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbRLFIp4>; Thu, 6 Dec 2001 03:45:56 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51470 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285054AbRLFIpo>; Thu, 6 Dec 2001 03:45:44 -0500
Message-ID: <3C0F301D.3368595@zip.com.au>
Date: Thu, 06 Dec 2001 00:45:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Yusuf Goolamabbas <yusufg@outblaze.com>
CC: ext3-users@redhat.com, linux-kernel@vger.kernel.org, anton@samba.org,
        axboe@suse.de
Subject: Re: 2.4.17-pre2+ext3-0.9.16+anton's cache aligned smp
In-Reply-To: <3C0B12C5.F8F05016@zip.com.au> <1007595740.818.2.camel@phantasy>,
		<1007595740.818.2.camel@phantasy> <20011206163056.A15550@outblaze.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yusuf Goolamabbas wrote:
> 
> Running 2.4.17-pre2 + ext3-0.9.16 + Anton Blanchards
> cacheline_aligned_smp patch available at
> 
> http://samba.org/~anton/linux/cacheline_aligned/

omigod look at that graph.

Excuse me while I get frustrated.  Will someone *please* send that
damn patch to marcelo@conectiva.com.br?

(It can be improved further by putting padding *behind* the lock
but hey).

> ...
> 
> With Anton's patch, the number of ctx-swtch/sec drops by around 3000
> from avg of 9000 (for 17-pre2+ext3) to avg of 6000 (with anton) as seen
> by vmstat 1

Really?  The spinlock cacheline alignment alone made that
difference?  I wonder why.


Thanks for testing.

-
