Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTKFJBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTKFJBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:01:52 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:46350 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263463AbTKFJBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 04:01:51 -0500
Message-ID: <3FAA1056.6020003@aitel.hist.no>
Date: Thu, 06 Nov 2003 10:11:50 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: no, en
MIME-Version: 1.0
To: Wee Teck Neo <slashboy84@msn.com>
CC: linux-kernel@vger.kernel.org
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

Yes - _use_ the memory for something else. 
1. All unused memory will be put to good use as cache.
2. Memory is taken from the cache whenever you need it for
   something else, so (1) is not a problem at all.

Helge Hafting

