Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSFQLSc>; Mon, 17 Jun 2002 07:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSFQLSb>; Mon, 17 Jun 2002 07:18:31 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:5028 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310206AbSFQLSZ>; Mon, 17 Jun 2002 07:18:25 -0400
Date: Mon, 17 Jun 2002 12:50:43 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.22 compile problems
In-Reply-To: <20020617125905.5511b12c.hanno@gmx.de>
Message-ID: <Pine.LNX.4.44.0206171249470.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Hanno Böck wrote:

> I tried to compile 2.5.22 and got the following errors:
> 
> arch/i386/kernel/kernel.o(.text.init+0x1450): undefined reference to `apic_read'
> arch/i386/kernel/kernel.o(.text.init+0x149b): undefined reference to `apic_write_around'
> arch/i386/kernel/kernel.o(.text.init+0x14cd): undefined reference to `apic_read'
> arch/i386/kernel/kernel.o(.text.init+0x14e0): undefined reference to `apic_write_around'
> make: *** [vmlinux] Fehler 1

Thanks, I'll look into that.

> I have tried kernels 2.5.18, 2.5.20, 2.5.21 and 2.5.22 and I always had compile problems. Can't someone test the kernel-source with all options activated before it is released?
> I think it doesn't matter if this happens sometimes in the 2.5-series, but it should not become usual.

Well this particular one would actually 'go away' with all options set, so 
you can't win em all.

Cheers,
	Zwane
-- 
http://function.linuxpower.ca
		

