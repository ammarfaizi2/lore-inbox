Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131952AbQKJVkH>; Fri, 10 Nov 2000 16:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbQKJVj5>; Fri, 10 Nov 2000 16:39:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47364 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131952AbQKJVjv>; Fri, 10 Nov 2000 16:39:51 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: APIC errors w/ 2.4.0-test11-pre2
Date: 10 Nov 2000 13:39:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uhpuj$1uf$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0011101523170.14596-100000@bochum.redhat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0011101523170.14596-100000@bochum.redhat.de>
By author:    Bernhard Rosenkraenzer <bero@redhat.de>
In newsgroup: linux.dev.kernel
>
> Hi,
> after booting a 2.4.0 (any testx-release I've tried so far, including
> test11-pre2) on a Dual-Pentium III box, the system works ok, but the
> console gets filled with
> 
> APIC error on CPU0: 08(08)
> 
> every couple of seconds, occasionally some lines in between say
> 
> APIC error on CPU0: 08(02)
> 
> and
> 
> APIC error on CPU0: 02(08)
> 
> This doesn't happen with 2.2.x, but I've seen "unexpected IRQ vector 208
> on CPU0" in 2.2.18 occasionally (nowhere near as often, maybe once a
> month).
> 
> This is an ASUS P2-D board (Intel 440BX chipset), 2 Pentium III-700
> processors.
> 
> The same kernel works perfectly on a similar (but slower) system, Gigabyte
> P2B-D board (Intel 440BX chipset), 2 Pentium III-450 processors.
> 

I have seen the same problem on the same motherboard.  It appears to
be a motherboard bug that 2.4 exposes and 2.2 doesn't.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
