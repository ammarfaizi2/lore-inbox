Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310383AbSCGQI4>; Thu, 7 Mar 2002 11:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310381AbSCGQIh>; Thu, 7 Mar 2002 11:08:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3344 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310376AbSCGQIY>; Thu, 7 Mar 2002 11:08:24 -0500
Subject: Re: [OOPS] Linux 2.2.21pre[23]
To: luca.montecchiani@teamfab.it (Luca Montecchiani)
Date: Thu, 7 Mar 2002 16:23:10 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        davej@suse.de (Dave Jones)
In-Reply-To: <3C878FC8.86FCC3@teamfab.it> from "Luca Montecchiani" at Mar 07, 2002 05:05:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j0fe-0002m9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a fully reproducible oops on boot with 2.2.21pre2 and 2.2.21pre3.
> Kernels 2.2.19, 2.2.21pre1 and 2.4.18rc2 works great.

Fun.

> CPU serial number disabled.
> Unable to handle kernel paging request at virtual address 756e654f

Thats not good. We tried to use a piece of ascii text as a pointer 8)

> EIP:    0010:[<c0278bc1>]
> EFLAGS: 00010246
> 
> just tel me if I must hand copy the rest of the screen :(

You want EIP and the call trace. Then look those up in System.map


> my 0.2 euro on: [Backport a lot of x86 setup] ;)

Ditto - especially the MCE changes.
