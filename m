Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130462AbRCDQ6P>; Sun, 4 Mar 2001 11:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbRCDQ6F>; Sun, 4 Mar 2001 11:58:05 -0500
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:18079 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S130462AbRCDQ5x>; Sun, 4 Mar 2001 11:57:53 -0500
Date: Sun, 4 Mar 2001 11:57:36 -0500 (EST)
From: Arthur Pedyczak <arthur-p@home.com>
To: Romain Chantereau <romainc@mail.dotcom.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel error..
In-Reply-To: <3AA25C25.ADE552F1@mail.dotcom.fr>
Message-ID: <Pine.LNX.4.30.0103041153060.22265-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My personal experience strongly suggests that the NVdriver is the
culprit.
Try geting rid of it.

Arthur


On Sun, 4 Mar 2001, Romain Chantereau wrote:

> Hi,
>
> I didn't know where send this bug report, so I send it here as writen in
> the Doc... Sorry if I mistake...
>
> Ok, I have a Debian sid (sic), on a AMD K6-2 300, on a Asus P5A, I have
> enabled AGP etc...
> Ah ! My graphic card is a Riva TNT, and I use it with the Nvidia driver
> 0.9.6..
>
> Ok, let's talk about the problem: That's it :
>
> (fidel is my computer name)
>
> fidel login: Unable to handle kernel paging request at virtual address
> 18297044
>  printing eip:
>  c6a9ed43
>  *pde = 00000000
>  Oops: 0002
>  CPU:    0
>  EIP:    0010:[<c6a9ed43>]
>  EFLAGS: 00013246
>  eax: 18297044   ebx: c58cfa1f   ecx: 00000000   edx: 00000001
>  esi: c14b8220   edi: 00000000   ebp: c1643e18   esp: c1643e0c
>  ds: 0018   es: 0018   ss: 0018
>  Process X (pid: 658, stackpage=c1643000)
>  Stack: c14b83e0 cbb2f004 c1f96204 c1643e34 c6a9f0af cbb2f004 c14b8220
> c58cfa20
>         c14b83e0 c58cf9f0 c1643e50 c6a9741a cbb2f004 c58cf9f0 c14b83e0
> 00000000
>         00000000 c1643e74 c6a9c0df cbb2f004 c58cf9f0 00000001 00000101
> c14b83e0
> Call Trace: [<cbb2f004>] [<c6a9f0af>] [<cbb2f004>] [<c6a9741a>]
> [<cbb2f004>] [<c6a9c0df>] [<cbb2f004>]
>        [<c6a9bc35>] [<cbb2f004>] [<cbb2f004>] [<c6a9bac2>] [<c6b142f8>]
> [<c0164f6a>] [<c6a98590>] [<c6a95dab>]
>        [<c6b14080>] [<c6b14080>] [<c6a9567d>] [<c0130d50>] [<c012ffcb>]
> [<c0118448>] [<c0118a2f>] [<c0118bc2>]
>        [<c0108e13>]
>
> Code: 08 14 38 46 89 d8 4b 85 c0 75 e4 8d 65 f4 5b 5e 5f c9 c3 89
>
>
> My computer use to crash a short time after if I don't reboot...
>
> ouch !
>
> Thanks for your reply, or return receipt, good luck,
>
> vala
>
> romain
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

