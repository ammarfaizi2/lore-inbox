Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269318AbRH0V7F>; Mon, 27 Aug 2001 17:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269387AbRH0V6z>; Mon, 27 Aug 2001 17:58:55 -0400
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:1411 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S269318AbRH0V6n>; Mon, 27 Aug 2001 17:58:43 -0400
Date: Mon, 27 Aug 2001 23:58:41 +0200 (CEST)
From: Bosko Radivojevic <bole@falcon.etf.bg.ac.yu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 2.4.9
In-Reply-To: <E15bS70-0004WY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108272357010.18996-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Aug 2001, Alan Cox wrote:

> Does this help

Nope :(

But, I am able to boot that machine with 2.4.5 generic kernel with
builtin Adaptec AIC 7xxx support that comes with Slackware 8.0.

Oops output is now a little bit different ;)

SCSI subsystem driver Revision: 1.00
Unable to handle kernel NULL pointer dereference at virtual address 0000003c
 printing eip:
c01a31c0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01a31c0>]
EFLAGS: 00010082
eax: 00000000   ebx: c1124340   ecx: 00000000 edx: ffffffff
esi: c1155600   edi: c1155700   ebp: c1155600 esp: c1121e70
ds: 0018   es: 0018  ss: 0018

Process swapper (pid: 1, stackpage=c1121000)
Stack: c0187d2a 00000000 ffffffff 00000000 00000200 c1124340 00000200 000000fc
       0000000f c0192b0c c1155600 c1124320 c1155700 00000001 c1155758 c1155600
       000000fc 0000000f c022e4a4 c1155600 c022e4a4 c11242ac c022e4a4 00000026
Call Trace: [<c0187d2d>] [<c0192b0c>] [<c0197c49>] [<c018b925>] [<c01a3f14>]
   [<c01a2f94>] [<c018bb6b>] [<c018826c>] [<c017f82e>] [<c0141d6b>] [<c0142095>]

   [<c018007d>] [<c0105037>] [<c010545c>]

Code: 89 50 3c 31 c0 c3 b8 fb ff ff ff c3 8b 54 24 08 23 54 24 04
Kernel panic: Attempted to kill init!


Greetings,
Bosko


