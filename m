Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWH1IVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWH1IVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWH1IVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:21:14 -0400
Received: from razorback.tcsn.co.za ([196.41.199.53]:62212 "EHLO tcsn.co.za")
	by vger.kernel.org with ESMTP id S1751402AbWH1IVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:21:13 -0400
Date: Mon, 28 Aug 2006 10:21:49 +0200
From: Henti Smith <henti@geekware.co.za>
To: linux-kernel@vger.kernel.org
Subject: linux on Intel D915GOM oops
Message-ID: <20060828102149.26b05e8b@yoda.foad.za.net>
Organization: Geek Ware
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I've been given a mecer Xhibitor media center machine to try and get
linux on for testing. 

The machine seems pretty much limited to South Africa, however the
setup is used by other companies like
http://www.higrade.com/nqcontent.cfm?a_id=3539 and
http://www.alienware.com/product_detail_pages/DHS_2/dhs_2_features.aspx?SysCode=PC-DHS2&SubCode=SKU-DEFAULT
which use the same mainboard atc. 

for more information ont he mainboard used:
http://www.intel.com/design/motherbd/om/om_documentation.htm

I've tried to boot just about every linux distro I can get my hands on
and they all oops at bootup. 

Unfortunately I cannot get to the first few lines (screen cannot scroll
after oops) 
but here is what I can get to : This is booting with Ubuntu

PREEMPT
Modules linked in:
CPU:	0
EIP:	0060:[<c00f02fa>]	not tainted
EFLAGS:	00010046	(2.6.8.1-3-386)
EIP is at 0xc00f02fa
eax: 49435024 ebx: 00007000 ecx: 00000000 edx: 00000010
esi: 00000001 edi: c02cd4a4 ebp: 49435024 esp: c17f3f90
ds: 007b es: 007b ss: 0068
Process swapper (pid: 1, threadinfo=c17f2000 task=c17f1670)
Stack: 
c00e0060 c01f5724 00000060 00000287 00000000 c00fe140 00000001 00000000
00000000 c01f5780 49435024 c00fe140 c00fe140 c00fe140 00000001 00000000
00000000 c01f5a77 c0336eb0 c031b822 c03086ac c010039e 00000000 c01003d5
Call Trace
[<c01f5724>] bios32_service+0x1c/0x68
[<c01f5780>] check_pcibios+0x10/0xd3
[<c01f5a77>] pci_find_bios+0x70/0x8c
[<c031b822>] pci_pcbios_init+0xe/0x2e
[<c03086ac>] do_initcalls+0x4b/0x99
[<c010039e>] init+0x0/0x10a
[<c01003d5>] init+0x37/0x10a
[<c01041e1>] kernel_thread_helper+0x5/0xb
Code: 00 66 33 d2 66 ba 0d 03 00 00 66 b9 4a 00 00 00 b0 00 cb 66
 <0>Kernel Panic: Attempted to kill init!

any ideas on what the problem could be ... or how to get around it ? 

-- 
Henti Smith
henti@geekware.co.za
+27 82 958 2525
http://www.geekware.co.za

DISCLAIMER : 

Unauthorised use of characters, images, sounds, odors, severed limbs,
noodles, wierd dreams, strange looking fruit, oxygen, and certain parts
of Jupiter are strictly forbidden.  If I find you violating, or
molesting my property in any way, I will employ a pair of burly
convicts to find you, kidnap you, and perform god-awful sexual
experiments on you until you lose the ability to sound out vowels.  I
don't know why you are still reading this, but by doing so you have
proven that you have far too much time on your hands, and you should go
plant a tree, or read a book or something.
	- http://www.ctrlaltdel-online.com/
