Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268970AbSIRSFE>; Wed, 18 Sep 2002 14:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268983AbSIRSFD>; Wed, 18 Sep 2002 14:05:03 -0400
Received: from franka.aracnet.com ([216.99.193.44]:31722 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268970AbSIRSFC>; Wed, 18 Sep 2002 14:05:02 -0400
Date: Wed, 18 Sep 2002 11:08:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Cort Dougan <cort@fsmlabs.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <344349498.1032347281@[10.10.2.3]>
In-Reply-To: <20020918115710.A656@host110.fsmlabs.com>
References: <20020918115710.A656@host110.fsmlabs.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm also a big fan of "Do that crap outside the kernel until it 
> works properly" type projects. 

Agreed. That's why we have things like the lse (scalability) rollup
patches for 2.4. People have been playing with such things outside
the kernel. And nobody's suggesting that it should get accepted before
being properly tested.

> The Linux view should not be that N-way boxes are its manifest 
> destiny. The same goes for thousands of threads.  Linux works 
> pretty well on 95% of the boxes that it is being run on.  Lets 
> not screw that up to fix the other 5%.  Try some fixes _outside_ 
> the main kernel for a while, find a workable solution and then 
> merge it in.

Why do you think these things are floating around as patches for 
a while, and not going straight into the kernel?
Why do you think there are things like a Redhat Advanced server 
build?

Nobody's trying to screw the desktop users, we're being mind-
bogglingly careful not to, in fact. If you have specific objections
to a particular patch, raise them as technical arguments. Saying 
"we shouldn't do that because I'm not interested in it" is far 
less useful.

The fact that there's lots of patches floating around for larger
systems isn't some evil plot to undermine the world - there's
just a lot of people working on it full time because that's where
much of the money is ...

M.

