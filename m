Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVCODtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVCODtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVCODtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:49:20 -0500
Received: from c-67-177-11-111.client.comcast.net ([67.177.11.111]:45953 "EHLO
	vger") by vger.kernel.org with ESMTP id S262226AbVCODs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:48:57 -0500
Message-ID: <4236587E.5060200@utah-nac.org>
Date: Mon, 14 Mar 2005 20:37:34 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: adilger@shaw.ca, strombrg@dcs.nac.uci.edu, linux-kernel@vger.kernel.org
Subject: Re: huge filesystems
References: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu>	<20050314164137.GC1451@schnapps.adilger.int>	<4235C251.7000801@utah-nac.org> <20050314192140.1b3680da.akpm@osdl.org>
In-Reply-To: <20050314192140.1b3680da.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>jmerkey <jmerkey@utah-nac.org> wrote:
>  
>
>>I am running the DSFS file system as a 7 TB file system on 2.6.9.
>>    
>>
>
>On a 32-bit CPU?
>  
>

Yep.

>  
>
>>There are a host of problems with the current VFS,
>>    
>>
>
>I don't recall you reporting any of them.  How can we expect to fix
>anything if we aren't told about it?
>
>  
>
I report them when I can't get around them myself. I've been able to get
around most of them.

>>ad I have gotten around most of them 
>> by **NOT** using the linux page cache interface.
>>    
>>
>
>Well that won't fly.
>
>
>  
>
For this application it will.

>The VFS should support devices up to 16TB on 32-bit CPUs.  If you know of
>scenarios in which it fails to do that, please send a bug report.
>
>
>  
>
Based on the changes I've mode to it locally for my version of 2.6.9, it
now goes to
1 zetabyte (1024 pedabytes). Largest one I've configured so far with
actual storage
is 128 TB, though. Had to drop the page cache and replace though -- for now.


Jeff


