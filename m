Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280136AbRKOClS>; Wed, 14 Nov 2001 21:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280339AbRKOClI>; Wed, 14 Nov 2001 21:41:08 -0500
Received: from rigel.neo.shinko.co.jp ([210.225.91.71]:21902 "EHLO
	rigel.neo.shinko.co.jp") by vger.kernel.org with ESMTP
	id <S280136AbRKOClB>; Wed, 14 Nov 2001 21:41:01 -0500
Message-ID: <3BF32B36.8B1375D0@neo.shinko.co.jp>
Date: Thu, 15 Nov 2001 11:40:54 +0900
From: nakai <nakai@neo.shinko.co.jp>
X-Mailer: Mozilla 4.78 [ja] (WinNT; U)
X-Accept-Language: ja,en,pdf
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
CC: Sven.Riedel@tu-clausthal.de
Subject: Re: 2.4.14 Oops during boot (KT133A Problem?)
In-Reply-To: <20011115021142.A12923@moog.heim1.tu-clausthal.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you'd be better compile kernel for K6, not for K7.  There is
something wrong with KT133 chip set and Athlon/Duron.

Sven.Riedel@tu-clausthal.de wrote:
> I get the following kernel oops when booting 2.4.14 vanilla on an Athlon
> 1200, KT133A Chipset Motherboard, 768MB RAM. Kernel has been compiled
> for Athlon CPUs, non-SMP. The next thing the kernel would have done
> after the oops would have been to start kswapd.
> Sidenote: booting the exact same kernel from floppy (debian rescue with
> kernels exchanged and booting with 'linux root=/dev/hda6') gives me a rather
> unstable system for a short while (uptime usually < 6 hours before oopsing).
> 
> Linux NET 4.0 for Linux 2.4
> Based upon Swansea University Computer Society Net 3.039
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000003 printing eip:
> c0112073
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0112073>]  Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: f7efe000   ebx: f7efe000     ecx: 00000000 edx: ffffffff
> esi: c1e1a5a0 edi: fffffff5     ebp: 00000700       esp: c1e1bf50
> ds: 0018        es: 0018       ss:0018
> Process swapper (pid: 1, stackpage=c1e1b000)

-- 
-=-=-=-=  SHINKO ELECTRIC INDUSTRIES CO., LTD.           =-=-=-=-
=-=-=-=-    Core Technology Research & Laboratory,       -=-=-=-=
-=-=-=-=      Infomation Technology Research Dept.       =-=-=-=-
=-=-=-=-  Name:Hisakazu Nakai          TEL:026-283-2866  -=-=-=-=
-=-=-=-=  Mail:nakai@neo.shinko.co.jp  FAX:026-283-2820  =-=-=-=-
