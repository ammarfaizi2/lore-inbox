Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTKUNx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 08:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTKUNxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 08:53:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:54944 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264104AbTKUNxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 08:53:49 -0500
X-Authenticated: #4512188
Message-ID: <3FBE19E8.6000802@gmx.de>
Date: Fri, 21 Nov 2003 14:58:00 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4
References: <20031118225120.1d213db2.akpm@osdl.org> <3FBDCCDF.9010304@gmx.de> <20031121130810.GQ22764@holomorphy.com>
In-Reply-To: <20031121130810.GQ22764@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
 > On Fri, Nov 21, 2003 at 09:29:19AM +0100, Prakash K. Cheemplavam wrote:
 >
 >>kernel BUG at arch/i386/mm/fault.c:357!
 >>invalid operand: 0000 [#1]
 >>PREEMPT
 >>CPU:    0
 >>EIP:    0060:[<c011da40>]    Tainted: PF  VLI
 >>EFLAGS: 00210293
 >>EIP is at do_page_fault+0x3a0/0x53a
 >>eax: f6415dc0   ebx: f6415dc0   ecx: 00000000   edx: f6415dc0
 >>esi: f6415de0   edi: f69f9180   ebp: f6c3dfb4   esp: f6c3df0c
 >>ds: 007b   es: 007b   ss: 0068
 >
 >
 >
 > diff -prauN mm4-2.6.0-test9-1/mm/memory.c

Great, with that patch the rest of the warnings disappeared.

Though still one thing left (probably nothing serious). Since mm3 I get 
this when starting X/kde at the very end of dmesg:

atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).

Prakash


