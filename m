Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314285AbSEFIx5>; Mon, 6 May 2002 04:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314287AbSEFIx4>; Mon, 6 May 2002 04:53:56 -0400
Received: from precia.cinet.co.jp ([210.166.75.133]:20608 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S314285AbSEFIxz>; Mon, 6 May 2002 04:53:55 -0400
Message-ID: <3CD64412.A59C09A@cinet.co.jp>
Date: Mon, 06 May 2002 17:51:30 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.79C-ja  [ja/Vine] (X11; U; Linux 2.5.14-pc98smp i686)
X-Accept-Language: ja, en-US, en
MIME-Version: 1.0
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14  Kernel panic
In-Reply-To: <200205060815.AA00092@prism.kumin.ne.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You will get more information by showing symbol.
Use ksymoops or do symbolize virtual address by hand (using ``System.map'').
``Call Trace'' may be useful.

Seiichi Nakashima wrote:
> Unable to handle kernel NULL pointer dereference at virtual address 00000040
>  printing eip:
> c01a6946
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c01a6946>]    Not tainted
> EFLAGS: 00010202
> eax: 00000020   ebx: 00000040   ecx: 00000008   edx: 00000000
> esi: c02a18a0   edi: 00000040   ebp: 00000020   esp: c5f97e50
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 1, threadinfo=c5f96000 task=c5f94040)
> Stack: c02a1b88 00000000 c02a1a60 00000000 00005656 00000008 00000010 c01ab1a7
>        c022984c c02a1b88 00000000 00000010 00000010 00000000 00000010 c0243c64
>        c022984c 00000001 00000000 c02a1a60 00007f58 c029d520 c10da160 00000000
> Call Trace: [<c01ab1a7>] [<c01a96c4>] [<c01a96df>] [<c01747d4>] [<c0177f57>]
>    [<c01a66f1>] [<c0105023>] [<c010553c>]
> 
> Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 4c 24 24 8b 44 24
>  <0>Kernel panic: Attempted to kill init!

-- 
Osamu Tomita
E-mail: tomita@cinet.co.jp
