Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSKSMO2>; Tue, 19 Nov 2002 07:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbSKSMO2>; Tue, 19 Nov 2002 07:14:28 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:32742 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265355AbSKSMO1>;
	Tue, 19 Nov 2002 07:14:27 -0500
Date: Tue, 19 Nov 2002 12:19:44 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andr??s Su??rez <webmaster@colservers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel errors
Message-ID: <20021119121944.GB27292@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andr??s Su??rez <webmaster@colservers.com>,
	linux-kernel@vger.kernel.org
References: <200211181615.08148.webmaster@colservers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211181615.08148.webmaster@colservers.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 04:15:08PM -0500, Andr??s Su??rez wrote:
 > Hi.
 > Someone could me explain this kernel errors?

Your kernel did something bad. The output needs to be decoded
through ksymoops, and have its results (along with info like
what kernel version this is) posted here.

See Documentation/oops-tracing.txt for more info.

		Dave

 > ****************************
 > Nov 18 12:34:20 linux kernel: Unable to handle kernel paging request at
 > virtual address 70f379d3
 > Nov 18 12:34:20 linux kernel:  printing eip:
 > Nov 18 12:34:20 linux kernel: c0120189
 > Nov 18 12:34:20 linux kernel: *pde = 00000000
 > Nov 18 12:34:20 linux kernel: Oops: 0000
 > Nov 18 12:34:20 linux kernel: CPU:    0
 > Nov 18 12:34:20 linux kernel: EIP:    0010:[<c0120189>]    Not tainted
 > Nov 18 12:34:20 linux kernel: EFLAGS: 00010202
 > Nov 18 12:34:20 linux kernel: eax: 70f379cb   ebx: d5fd8b30   ecx: 00000011
 > edx: 0001f06b
 > Nov 18 12:34:20 linux kernel: esi: 000000a6   edi: 000000bb   ebp: c18fc1ac
 > esp: d9d69ed0
 > Nov 18 12:34:20 linux kernel: ds: 0018   es: 0018   ss: 0018
 > Nov 18 12:34:20 linux kernel: Process ipop3d (pid: 30184,
 > stackpage=d9d69000)
 > Nov 18 12:34:20 linux kernel: Stack: dd1cd0c0 00000015 000000a6 dd1cd0c0
 > 00000020 c0120735 0000001f 0000011a
 > Nov 18 12:34:20 linux kernel:        c18fc0dc c13eb9c0 d5fd8b30 00000087
 > c0120988 00000001 dd1cd0c0 d5fd8a80
 > Nov 18 12:34:20 linux kernel:        c13eb9c0 00001000 00000001 00000000
 > 00000000 d5fd8a80 dd06484c df934a0e
 > Nov 18 12:34:20 linux kernel: Call Trace: [<c0120735>] [<c0120988>]
 > [<e08d7db2>] [<c0120e8a>] [<c0120db0>]
 > Nov 18 12:34:20 linux kernel:    [<c012c305>] [<c012bfd0>] [<c012c17e>]
 > [<c0106cfb>]
 > Nov 18 12:34:20 linux kernel:
 > Nov 18 12:34:20 linux kernel: Code: 39 58 08 75 f4 39 78 0c 75 ef 85 c0 75
 > 4a 8b 43 30 31 d2 e8
 > ******************************************
 > 
 > 
 > Thanks,
 > 
 > Andres Suarez
 > 
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
---end quoted text---

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
