Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbSIWVYZ>; Mon, 23 Sep 2002 17:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSIWVYZ>; Mon, 23 Sep 2002 17:24:25 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:30258 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S261423AbSIWVYI>;
	Mon, 23 Sep 2002 17:24:08 -0400
Subject: Re: kernel BUG at vmalloc.c:236!  version 2.4.19
From: James Stevenson <james@stev.org>
To: Martin Knott <martin@knotthome.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E17tHIy-0005Rd-00.2002-09-23-01-42-28@cmailg2.svr.pol.co.uk>
References: <E17tHIy-0005Rd-00.2002-09-23-01-42-28@cmailg2.svr.pol.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Sep 2002 22:25:37 +0100
Message-Id: <1032816337.1699.0.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following appears in dmesg:
> 
> kernel BUG at vmalloc.c:236!
> invalid operand: 0000
> CPU:    0
> EIP:    1010:[<c012a997>]    Not tainted
> EFLAGS: 00210246
> eax: 00000000   ebx: 00000000   ecx: 00000000   edx: d20ddbfc
> esi: 00000200   edi: d20ddc1c   ebp: c6a0fe5c   esp: c6a0fe2c
> ds: 1018   es: 1018   ss: 1018
> Process madvout (pid: 2750, stackpage=c6a0f000)
> Stack: 00000000 00000200 d20ddc1c c02c8d5f 00000000 00000000 00000010 fffffffe
>        00000000 00000041 000031b5 d1df7f7c c6a0fe7c e21f8085 00000000 000001f2
>        00000163 d20ddb80 00000200 d20ddc1c c6a0fea0 e21f82f8 00000000 bffdb808
> Call Trace:    [<e21f8085>] [<e21f82f8>] [<c0117318>] [<e21f949b>] 
> [<c013a8d1>]
>   [<c013b21c>] [<c013a829>] [<c013bacb>] [<c01316af>] [<c01315bf>] 
> [<c013e679>]
>   [<c01099fb>]
> 
> Code: 0f 0b ec 00 20 1b 24 c0 e9 65 01 00 00 6a 02 53 e8 94 fe ff
>  mask: 8000000000000000 usage: 8000000000000000

would you be able to run that though ksymopps please.

thanks
	James



