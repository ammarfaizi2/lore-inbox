Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTKFJAB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTKFJAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:00:00 -0500
Received: from smtp2.su.se ([130.237.93.212]:50648 "EHLO smtp2.su.se")
	by vger.kernel.org with ESMTP id S263448AbTKFI76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 03:59:58 -0500
Message-ID: <3FAA0D8C.7040304@it.su.se>
Date: Thu, 06 Nov 2003 09:59:56 +0100
From: =?ISO-8859-1?Q?Jerry_Lundstr=F6m?= <jerry.lundstrom@it.su.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: Wee Teck Neo <slashboy84@msn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
References: <BAY4-F41WYf5UPHvAo10001c90f@hotmail.com>
In-Reply-To: <BAY4-F41WYf5UPHvAo10001c90f@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wee Teck Neo wrote:
> My system having 1GB ram and this is the output of vmstat
> 
>   procs                      memory      swap          io     
> system      cpu
> r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
> sy id
> 0  0  0   5640  21224 121512 797832    0    0     6     9    3    17  0  
> 0  6
> 
> 
> It seems that 797MB is used for caching... thats a high number. Anyway 
> to set a lower cache size?
> 
> I've read about the /proc/sys/vm/buffermem but my /proc doesn't have it.
> 
> Kernel: 2.4.22
> 

I don't see the problem? Linux uses unused memory as cache and unless 
you have processes using more memory then thats free you dont have a 
problem, this is all dynamic and nothing to worry about.

