Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284902AbRLZUq0>; Wed, 26 Dec 2001 15:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284899AbRLZUqQ>; Wed, 26 Dec 2001 15:46:16 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:21212 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S284902AbRLZUqF>;
	Wed, 26 Dec 2001 15:46:05 -0500
Date: Wed, 26 Dec 2001 15:46:05 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: <linux-kernel@vger.kernel.org>
Subject: Unusual Stacksize Question
Message-ID: <Pine.LNX.4.30.0112261534370.21850-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this question is kind of strange, and I am not even sure how to phrase
it clearly:

Are there any possible issues with processes that have ELS (Extremely
Large Stackspace [TM])?  [Ok, I made that term up..].  I have an ELS
process that I was tinkering with..  Purely for academic reasons, mind
you, I created huge arrays of doubles and managed to get the thing to
coredump.  I used setrlimit() to set the stacksize limit to infinity.  No
more core dumps.  But guess what?  Like half the time I now get a kernel
panic screen dump and the system immediately hangs...  I should think that
really, as long as you have enough memory, both real and imagined (I made
that term up too), nothing too bad can happen beyond a coredump maybe.

At any rate, I am suspicious of the motherboard and ram this system uses,
but I was just wondering if you guys knew of any issues in the kernel with
extremely large stack segments.. possibly in the context switch code or
somesuch (again, I should think not.. but I figured I should ask
anyway..).

The kernel is the stock redhat 7.1 kernel: 2.4.2-2

I apologize for the randomness of this question.. but at this point I am
trying to eliminate possibilities and if there were a known issue with
huge stack segments in userspace I would appreciate the info...

-Calin


