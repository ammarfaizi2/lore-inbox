Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTKFIZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 03:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTKFIZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 03:25:53 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:53941 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263415AbTKFIZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 03:25:52 -0500
Message-ID: <3FAA058C.3090202@cyberone.com.au>
Date: Thu, 06 Nov 2003 19:25:48 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Wee Teck Neo <slashboy84@msn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
References: <BAY4-F41WYf5UPHvAo10001c90f@hotmail.com>
In-Reply-To: <BAY4-F41WYf5UPHvAo10001c90f@hotmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Wee Teck Neo wrote:

> My system having 1GB ram and this is the output of vmstat
>
>   procs                      memory      swap          io     
> system      cpu
> r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs 
> us sy id
> 0  0  0   5640  21224 121512 797832    0    0     6     9    3    17  
> 0  0  6
>
>
> It seems that 797MB is used for caching... thats a high number. Anyway 
> to set a lower cache size?
>
> I've read about the /proc/sys/vm/buffermem but my /proc doesn't have it.
>
> Kernel: 2.4.22


Short answer, no.

If it is actually causing you a problem, test the latest 2.4 prerelease.
If that doesn't help, report the details of the problem.


