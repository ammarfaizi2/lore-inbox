Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbTAXPph>; Fri, 24 Jan 2003 10:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267761AbTAXPph>; Fri, 24 Jan 2003 10:45:37 -0500
Received: from dial-ctb05175.webone.com.au ([210.9.245.175]:7428 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267765AbTAXPpg>;
	Fri, 24 Jan 2003 10:45:36 -0500
Message-ID: <3E3161D0.1060403@cyberone.com.au>
Date: Sat, 25 Jan 2003 02:54:56 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: big ext3 sequential write improvement in 2.5.51-mm1 gone in 2.5.53-mm1
References: <20030124044119.GA15252@rushmore> <20030123231117.29c8eb98.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>rwhron@earthlink.net wrote:
>
>>qsbench creates heavy swap load and simultaneous ed build. (small gnu package 
>>"tar xzf/configure/make/make check").
>>
>
>[snip]
>(Well, 2.5 _used_ to run it faster.  The anticipatory scheduling patch makes
>2.5's qsbench a little slower than 2.4.  `qsbench -m 350' on `mem=256m').
>
Some regressions are probably unavoidable, however a lot should be
able to be tuned out.

Nick

