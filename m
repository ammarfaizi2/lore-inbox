Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132857AbRALWfv>; Fri, 12 Jan 2001 17:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135504AbRALWfl>; Fri, 12 Jan 2001 17:35:41 -0500
Received: from rachael.franken.de ([193.175.24.38]:63500 "EHLO
	rachael.franken.de") by vger.kernel.org with ESMTP
	id <S132857AbRALWfg>; Fri, 12 Jan 2001 17:35:36 -0500
Date: Fri, 12 Jan 2001 23:33:32 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Danny ter Haar <dth@lin-gen.com>
Cc: Hans Grobler <grobh@sun.ac.za>, linux-kernel@vger.kernel.org
Subject: Re: PRoblem with pcnet32 under 2.4.0 , was :Drivers under 2.4
Message-ID: <20010112233332.C2501@alpha.franken.de>
In-Reply-To: <93kn8a$itt$1@voyager.cistron.net> <Pine.LNX.4.30.0101111836460.30013-100000@prime.sun.ac.za> <20010112125010.A6371@lin-gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010112125010.A6371@lin-gen.com>; from dth@lin-gen.com on Fri, Jan 12, 2001 at 12:50:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 12:50:10PM +0100, Danny ter Haar wrote:
> eth0: PCnet/FAST III 79C973 at 0xfce0, 00 00 e2 24 41 1d
> pcnet32: pcnet32_private lp=c3c42000 lp_dma_addr=0x3c42000 assigned IRQ 9. 
> pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de 

same chip works for me von my P5 SMP box.

> irq  0:     16840 timer              irq  9:         0 acpi, PCnet/FAST III  

no interrupts for PCnet driver sounds more like interrupt routing problem to
me.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                 [ Alexander Viro on linux-kernel ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
