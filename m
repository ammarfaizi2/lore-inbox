Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268304AbTCFSN3>; Thu, 6 Mar 2003 13:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268308AbTCFSN3>; Thu, 6 Mar 2003 13:13:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:10637 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268304AbTCFSNZ>; Thu, 6 Mar 2003 13:13:25 -0500
Date: Thu, 06 Mar 2003 10:13:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, rml@tech9.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <9420000.1046974427@flay>
In-Reply-To: <Pine.LNX.4.44.0303061900230.16118-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303061900230.16118-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> But the proof is in the pudding. Does this actually make things appear
>> "nicer" to people? Or is it just another wanking session?
> 
> yes, it would be interesting to see Andrew's experiments redone for the 
> following combinations:
> 
>    - your patch
>    - my patch
>    - both patches
> 
> in fact my patch was tested and it mostly solved the problem for Andrew,
> but i'm now convinced that the combination of patches will be the real
> solution for this class of problems - as that will attack _both_ ends,
> both CPU hogs are recognized better, and interactivity detection
> interactivity-distribution is improved.

It would be nice if we had a "batch-job-able" simulation of this situation,
to do more accurate testing with ... can anyone think of an easy way to
do such a thing? "waggle a few windows around on X and see if it feels 
better to you or not" is kind of hard to do accurate testing with.
Of course, the simulation has to be accurate too, or it gets stupid ;-)

M.

