Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSLMRnX>; Fri, 13 Dec 2002 12:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbSLMRnX>; Fri, 13 Dec 2002 12:43:23 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:44752 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264984AbSLMRnW>; Fri, 13 Dec 2002 12:43:22 -0500
Message-Id: <4.3.2.7.2.20021213182103.00ae6f00@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 13 Dec 2002 18:51:37 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Intel P6 vs P7 system call performance
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, in the 2.4.x kernels, the P4 gets compiled as a I686 with NO special
treatment :-) (Not even prefetch, because of an ifdef bug)
The P3 at least gets one level of prefetch and the AMD's get special compile
options(arch=k6,athlon), full prefetch and SSE.

 >From Mike Hayward
 >Dual Pentium 4 Xeon 2.4Ghz 2.4.19 kernel 33661.9 lps (10 secs, 6 samples)

Hmm, P4 2.4Ghz , also gcc -O3 -march=i686

margit:/disk03/bytebench-3.1/src # ./hanoi 10
576264 loops
margit:/disk03/bytebench-3.1/src # ./hanoi 10
571001 loops
margit:/disk03/bytebench-3.1/src # ./hanoi 10
571133 loops
margit:/disk03/bytebench-3.1/src # ./hanoi 10
570517 loops
margit:/disk03/bytebench-3.1/src # ./hanoi 10
571019 loops
margit:/disk03/bytebench-3.1/src # ./hanoi 10
582688 loops

Margit 

