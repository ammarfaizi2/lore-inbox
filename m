Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270756AbUJUPfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270756AbUJUPfV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270781AbUJUPcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:32:42 -0400
Received: from r200-40-30-222.antel.net.uy ([200.40.30.222]:51021 "EHLO
	mta1.in.adinet.com.uy") by vger.kernel.org with ESMTP
	id S270768AbUJUP3g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:29:36 -0400
Date: Thu, 21 Oct 2004 12:33:01 -0300
Message-ID: <414D12DA00038161@nfs01.in.adinet.com.uy>
From: amahoro@adinet.com.uy
Subject: Kernel panic: memory or hard disk issue?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list folk,

I've subscribed to this list -wish it's the correct one-, because I have
an issue involving a Kernel Panic. I've posted the same info to my local
LUG maling list and to the Debian Spanish User List.

I've a dual boot PC which suddenly beggining crashing at boot time. At the
console, I can read the output I paste below. As a statement, I must say
that the 'other' OS is MS-Windows98SE. It doesn't boot correctly, I hardly
get a blue screen ;-)

I don't have a clue about what the problem is and how to solve it. Perhaps
it's a memory matter or perhaps the hard disk.... :-\

--------------8<-----------CUT HERE-----------8<---------------

VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a(rev 1b) IDE UDMA66 controller on pci00:07.1
  ide0: BM-DMA at 0xffa0-0xffa7<1> Unable to handle Kernel paging request
at virtual address 00001400
  printing eip:
c0139bb2
*pde = 00000000
Ooops : 0002

CPU : 0
EIP : 0018:[<c01139bb2>] Not tainted
EFLAGS : 00253046
eat: c1186070 ebx: c11860707 ecx: 00001400 edx: c03e4d00
esi: 0000ffa0 edi: 000001f0 ebp: c04a8d80 esp: c1199ed4
ed: 0018 es: 0013 ss: 0018
Process swapper (pid: 1,stackpage = c1199000)
Stack : c04a8d80 0000ffa0 c03f8bf0 c04a8d80 c02d1992 c1186070 000001f0
 c1190400
00000800 c04a9198 c04a8d80 c02d1d76 c04a8d80 c1190400 c04434cd c04a8d80
0000ffa0 00000008 c02d8118 c04a8d80 0000ffa0 00070400 c04a8d80 c03f8bf0
Call Trace: [<c02d1992>] [<c02d1076>] [<c02d0118>] [<c0200381>] [<c0105000>]
[<c02d0585>] [<c02bc0c0>]
[<c0105088>] [<c0105000>] [<c0197556>] [<c0105060>]
Code: 3001 0f 84 06 ff ff ff 0f 0b d6 04 05 04 39 c0 e9 f9 fe ff
<0> Kernel panic: Attempted to kill init!

--------------8<-----------CUT HERE-----------8<---------------

The original distro is Morphix, then updated to Debian Unstable, via apt.

If this is not the correct place to ask things like that, please direct
me in the correct location

Thanks in advance,
--
Arlequín

