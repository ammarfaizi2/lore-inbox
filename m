Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRACDqQ>; Tue, 2 Jan 2001 22:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbRACDp4>; Tue, 2 Jan 2001 22:45:56 -0500
Received: from jalon.able.es ([212.97.163.2]:31165 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129401AbRACDpt>;
	Tue, 2 Jan 2001 22:45:49 -0500
Date: Wed, 3 Jan 2001 04:15:16 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre5
Message-ID: <20010103041516.C1497@werewolf.able.es>
In-Reply-To: <E14Ddzo-0003MV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14Ddzo-0003MV-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 03, 2001 at 03:49:46 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.03 Alan Cox wrote:
> 2.2.19pre5
> o	Fix dumpable stuff				(Wolfgang Walter)
> o	PPA driver update				(Tim Waugh)
> o	ARM updates (Russell - ptrace.c errored please	(Russell King)
> 		resolve)
> o	Fix NFS data alignment on ARM			(Russell King)
> o	Fix hang on boot with ALi5451 shared irq midi	(Stephen Usher)
> o	ESS Maestro 3 driver				(Zach 'Fufu'
Brown)
> o	Belorussia/Ukraine NLS table (koi8-ru)		(Andy Rysin)
> 

I have seen that the CCFOUND stuff has flown away. I have read it
breaks somthing, and the CROSS_COMPILE in alphas and m68k.
Perhaps this way could be better : ??

..
include arch/$(ARCH)/Makefile

AS  :=$(AS)
LD  :=$(LD)
CC  :=$(CC)
CPP :=$(CPP)

..



-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre3-aa4 #2 SMP Wed Jan 3 00:10:48 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
