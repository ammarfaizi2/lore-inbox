Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRJMHmv>; Sat, 13 Oct 2001 03:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278276AbRJMHmm>; Sat, 13 Oct 2001 03:42:42 -0400
Received: from [202.135.142.195] ([202.135.142.195]:3346 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S276591AbRJMHm2>; Sat, 13 Oct 2001 03:42:28 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
        paul.mckenney@us.ibm.com
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion 
In-Reply-To: Your message of "Fri, 12 Oct 2001 09:28:07 PDT."
             <Pine.LNX.4.33.0110120919130.31677-100000@penguin.transmeta.com> 
Date: Sat, 13 Oct 2001 17:38:21 +1000
Message-Id: <E15sJNF-0005Je-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0110120919130.31677-100000@penguin.transmeta.com> you
 write:
> And hey, if you want to, feel free to create the regular
> 
> 	#define read_barrier()		rmb()
> 	#define write_barrier()		wmb()
> 	#define memory_barrier()	mb()

I agree... read_barrier_depends() then?

Rusty.
--
Premature optmztion is rt of all evl. --DK
