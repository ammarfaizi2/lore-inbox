Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317546AbSFEE3U>; Wed, 5 Jun 2002 00:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSFEE3T>; Wed, 5 Jun 2002 00:29:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7596 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317546AbSFEE3S>;
	Wed, 5 Jun 2002 00:29:18 -0400
Message-ID: <3CFD9393.2090704@us.ibm.com>
Date: Tue, 04 Jun 2002 21:29:07 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ruth Forester <lilo@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Lockstats for SMP DB Workload
In-Reply-To: <200206050016.g550Gl110934@eng4.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Forester wrote:
>   2.4%  1.0%   38us(  15ms) 3185us(  12ms)(0.13%)      6291 99.0%  
 >                                 1.0%    0%  kernel_flag_cacheline
<snip>
 >  2.3%  9.1% 6865us(  15ms) 3551us(5592us)(0.01%)        33 90.9%
 >                                 0.1%    0%    do_exit+0xf4

I thought that the DB workload was running the LSE patches too.  I 
have a simple fix for do_exit().  This 2.4.17 patch should apply 
against your 2.4.19pre8aa2+dj2...  If it doesn't, I can regenerate it 
pretty quickly.

Download here:
http://lse.sourceforge.net/lockhier/bkl_rollup.html#doexit

-- 
Dave Hansen
haveblue@us.ibm.com

