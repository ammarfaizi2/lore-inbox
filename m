Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTDHCmP (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 22:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTDHCmP (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 22:42:15 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:17614 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263887AbTDHCmO (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 22:42:14 -0400
Message-ID: <3E934363.3040507@blue-labs.org>
Date: Tue, 08 Apr 2003 17:47:15 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030403
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Oleg Drokin <green@namesys.com>, Hans Reiser <reiser@namesys.com>
Subject: Re: [OOPS] 100% repeatable OOPS, 2.5.61-66, NFS and reiserfs
References: <3E92F953.8080401@blue-labs.org> <16018.1797.59286.752771@notabene.cse.unsw.edu.au>
In-Reply-To: <16018.1797.59286.752771@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 917; timestamp 2003-04-08 02:53:38, message serial number 896384
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest 2.5 kernel being .67?

Yes, dev kernels are like that...  but I'm not going to get into my 
angst over 'release' kernels and NFS ;)

david

Neil Brown wrote:

>On Tuesday April 8, david+powerix@blue-labs.org wrote:
>  
>
>>1. Power loss this morning
>>2. Fixed filesystems (reiserfstools is fscking useless on root filesystems)
>>3. Now server OOPSes when nfs client tries to stat/read files/dirs
>>
>>Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> printing eip:
>>00000000
>>*pde = 00000000
>>Oops: 0000
>>CPU:    0
>>EIP:    0060:[<00000000>]    Not tainted
>>    
>>
>
>Development kernels are like that....
>
> This is a bug in the kernel which is triggered by using nfs-utils
> 1.0.3
>
> Either upgrade to the latest 2.5 kernel, or downgrade nfs-utils until
> you can upgrade the kernel.
>
>NeilBrown
>  
>

