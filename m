Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbTBIW5Y>; Sun, 9 Feb 2003 17:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbTBIW5Y>; Sun, 9 Feb 2003 17:57:24 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:53619
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267467AbTBIW5X>; Sun, 9 Feb 2003 17:57:23 -0500
Date: Sun, 9 Feb 2003 18:06:07 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jurriaan <thunder7@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm8 / ext3 oops
In-Reply-To: <20030209131259.GA1944@middle.of.nowhere>
Message-ID: <Pine.LNX.4.50.0302091757400.2812-100000@montezuma.mastecende.com>
References: <20030209131259.GA1944@middle.of.nowhere>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, Jurriaan wrote:

> This just happened after startup, before I was inputting anything.
> It certainly isn't repeatable, since I never got it in the 10+ earlier
> reboots I did with 2.5.59-mm8. Below are the oops, the mounting table,
> dmesg, .config and lspci.
> 
> Kind regards,
> Jurriaan
> 
> ------------[ cut here ]------------
> kernel BUG at fs/ext3/super.c:1724!
> invalid operand: 0000
> CPU:    1
> EIP:    0060:[<c019ae0c>]    Tainted: PF
> EFLAGS: 00010246
> EIP is at ext3_write_super+0x4c/0x90
> eax: 00000000   ebx: 00000000   ecx: c1789050   edx: dfdbc000
> esi: c1789000   edi: dfdbdfdc   ebp: dfdbdfd0   esp: dfdbdec8
> ds: 007b   es: 007b   ss: 0068
> Process pdflush (pid: 11, threadinfo=dfdbc000 task=dfdbe680)
> Stack: df74aa00 00000000 c1789000 c1789050 c015b42b c1789000 dfdbc000 dfdbc000
>        c013c6ce c04ef340 00012fe0 0000a728 00000000 00000000 dfdbdef4 00000000
>        00000001 00000000 00000001 00000000 0000019b 00000000 00002e11 00000134
> Call Trace:
>  [<c015b42b>] sync_supers+0xcb/0xf0
>  [<c013c6ce>] wb_kupdate+0x4e/0x120
>  [<c011d4c8>] do_schedule+0x1d8/0x3c0
>  [<c013cfdc>] __pdflush+0x16c/0x290
>  [<c011ca55>] schedule_tail+0x65/0x70
>  [<c013d100>] pdflush+0x0/0x20
>  [<c013d10f>] pdflush+0xf/0x20
>  [<c013c680>] wb_kupdate+0x0/0x120
>  [<c01072c8>] kernel_thread_helper+0x0/0x18
>  [<c01072cd>] kernel_thread_helper+0x5/0x18
> 
> Code: 0f 0b bc 06 78 a9 3b c0 c6 46 15 00 8b 86 48 01 00 00 c7 44

Wow how did you manage that? Is the machine otherwise very stable?

	Zwane
-- 
function.linuxpower.ca
