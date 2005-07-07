Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVGGJyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVGGJyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 05:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVGGJyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 05:54:35 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:7902 "EHLO smtp.cegetel.net")
	by vger.kernel.org with ESMTP id S261253AbVGGJye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 05:54:34 -0400
Message-ID: <42CCFBA1.1090807@lifl.fr>
Date: Thu, 07 Jul 2005 11:53:37 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
Organization: LIFL
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: Sheo Shanker Prasad <ssp@creativeresearch.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: Disturbing wide variation in execution time
References: <200507062344.53615.ssp@creativeresearch.org> <20050707.001038.71088533.davem@davemloft.net> <200507070103.25563.ssp@creativeresearch.org>
In-Reply-To: <200507070103.25563.ssp@creativeresearch.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please do not top-post)

07.07.2005 10:03, Sheo Shanker Prasad wrote/a écrit:
> Dear David,
> 
> The program is an atmospheric chemistry-transport modeling code that computes 
> the distributions of atmospheric species (e.g., ozone) as a function of 
> latitude and altitude and how that changes with time.
Well, to let us examine your  problem, you need to describe what 
*technicaly* does your program. ie: lots of disk access, lots of 
networks acces, lots of CPU access, allocate huge memory... in 
particular, is it CPU bound or I/O bound? You should also mention how 
tasks/thread is your program composed of.

It's good to describe your hardware: cluster of NUMA computers or just 
one x86? How much memory, what kind of network, how many hard disks, 
which exact version of the kernel....

Cherry on the top, you could include a *small* program which exhibit the 
same problem.

> 
> Thanks for taking time to think about my problem. I greatly appreciate it.
> 
To answer briefly your question, _in general_ a program which takes more 
than a few seconds to execute should take roughly the same time to 
execute all the times.


Eric
