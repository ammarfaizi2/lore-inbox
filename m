Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284175AbRLKX1f>; Tue, 11 Dec 2001 18:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284182AbRLKX1Z>; Tue, 11 Dec 2001 18:27:25 -0500
Received: from rj.SGI.COM ([204.94.215.100]:18913 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S284178AbRLKX1S>;
	Tue, 11 Dec 2001 18:27:18 -0500
Date: Tue, 11 Dec 2001 15:27:35 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Jack Steiner <steiner@sgi.com>
cc: Dipankar Sarma <dipankar@in.ibm.com>, Niels Christiansen <nchr@us.ibm.com>,
        kiran@linux.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
In-Reply-To: <200112091734.LAA45393@fsgi055.americas.sgi.com>
Message-ID: <Pine.SGI.4.21.0112111524090.220891-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001, Jack Steiner wrote:

> If code want to allocate close to a cpu, then kmem_cache_alloc_cpu()
> is the best choice. However, I would also expect that some code
> already knows the node. Then kmem_cache_alloc_node() is best.

yup.


> As precident, the page allocation routines are all node-based.
> (ie., alloc_pages_node(), etc...)

My inclinations would be to prefer more cpu-based allocators.
But until I happen to catch you in a room with a white board,
my inclinations are unlikely to go anywhere ... perhaps someday.


                          I won't rest till it's the best ...
			  Manager, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

