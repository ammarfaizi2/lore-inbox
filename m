Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264791AbRFSVNA>; Tue, 19 Jun 2001 17:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264792AbRFSVMu>; Tue, 19 Jun 2001 17:12:50 -0400
Received: from intranet.resilience.com ([209.245.157.33]:11942 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S264791AbRFSVMi>; Tue, 19 Jun 2001 17:12:38 -0400
Mime-Version: 1.0
Message-Id: <p0510030ab7556d686012@[10.128.7.49]>
In-Reply-To: <15151.48287.782428.953466@pizda.ninka.net>
In-Reply-To: <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca>
 <3B2F769C.DCDB790E@kegel.com>	<20010619090956.R3089@work.bitmover.com>
 <p05100302b7553d481172@[10.128.7.49]>
 <15151.48287.782428.953466@pizda.ninka.net>
Date: Tue, 19 Jun 2001 14:11:16 -0700
To: "David S. Miller" <davem@redhat.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:57 PM -0700 2001-06-19, David S. Miller wrote:
>So my basic point is that I don't want people to read what you said
>and believe "oh then the difference between threads vs. different
>processes under Solaris is due to Sparc hw architecture reasons
>instead of sw reasons" which simply isn't true.

Yeah, my observation wasn't central to the discussion, and the 
overhead of SPARC register windows is probably more relevant to 
user-level threads, not to mention small compared to IO.

It seems to me that the telling argument against threads has much 
more to do with the potential complexity of the resulting code than 
with after-all-minor performance considerations. If threads truly 
gave one an elegant, fool-proof way to implement otherwise complex 
applications, well, what are MIPS for, anyway?

I have a question, though. The SGI "state threads" mentioned earlier 
use threads in a controlled way with a state-machine programming 
model, which among other things has the potential to take advantage 
of multiple processors. How does one otherwise take advantage of MP 
with a state machine? Multiple processes and shared memory?


-- 
/Jonathan Lundell.
