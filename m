Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270749AbTGUWQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 18:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270752AbTGUWQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 18:16:26 -0400
Received: from web13304.mail.yahoo.com ([216.136.175.40]:43923 "HELO
	web13304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270749AbTGUWQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 18:16:24 -0400
Message-ID: <20030721223126.36712.qmail@web13304.mail.yahoo.com>
Date: Mon, 21 Jul 2003 15:31:26 -0700 (PDT)
From: Ronald Jerome <imun1ty@yahoo.com>
Subject: Re: [2.6.0-test1] Unable to handle kernel NULL pointer dereference at virtual address 00000324
To: ramon.rey@hispalinux.es, linux-kernel@vger.kernel.org
In-Reply-To: <1058803534.28902.2.camel@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is the exact same Oops I get.  I wasunable to
catpure or print it because the kernel locks up.

How were you are ble catch the Oops message if yoru
system froze?


--- Ramón Rey Vicente  ó® ’ <ramon.rey@hispalinux.es>
wrote:
> Hello.
> 
> With test1 and the bitkeeper changesets until
> yesterday, I obtain this
> 
> Unable to handle kernel NULL pointer dereference at
> virtual address
> 00000324
>  printing eip:
> c01605a9
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c01605a9>]    Not tainted
> EFLAGS: 00010206
> EIP is at iput+0x9/0x80
> eax: 00000000   ebx: 00000200   ecx: caab2664   edx:
> caab2664
> esi: 00000200   edi: c13e4000   ebp: 00000061   esp:
> c13e5e88
> ds: 007b   es: 007b   ss: 0068
> Process kswapd0 (pid: 8, threadinfo=c13e4000
> task=c13eac60)
> Stack: caab2640 c015ddf3 00000200 00000080 c13e4000
> 00000041 cfffeba0
> c015e273 
>        00000080 c0138968 00000080 000000d0 0000d4c8
> 01e04b6c 00000000
> 00000241 
>        00000000 0000035a c027826c fffffffd 00000001
> c0139abe 0000035a
> 000000d0 
> Call Trace:
>  [<c015ddf3>] prune_dcache+0x153/0x1a0
>  [<c015e273>] shrink_dcache_memory+0x33/0x40
>  [<c0138968>] shrink_slab+0x108/0x160
>  [<c0139abe>] balance_pgdat+0x15e/0x180
>  [<c0139be6>] kswapd+0x106/0x120
>  [<c01180a0>] autoremove_wake_function+0x0/0x40
>  [<c0108d96>] ret_from_fork+0x6/0x20
>  [<c01180a0>] autoremove_wake_function+0x0/0x40
>  [<c0139ae0>] kswapd+0x0/0x120
>  [<c0106fe5>] kernel_thread_helper+0x5/0x20
> 
> Code: 83 bb 24 01 00 00 20 8b 83 80 00 00 00 8b 40
> 24 74 4b 85 c0
> -- 
> /================================================\
> | Ramón Rey Vicente <ramon.rey at hispalinux.es> |
> |                                                |
> | Jabber ID <rreylinux at jabber.org>            |
> |                                                |
> | Public GPG Key http://pgp.escomposlinux.org    |
> |                                                |
> | GLiSa http://glisa.hispalinux.es               |
> \================================================/
> 

> ATTACHMENT part 2 application/pgp-signature
name=signature.asc



__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
