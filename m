Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLKVI0>; Mon, 11 Dec 2000 16:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQLKVIG>; Mon, 11 Dec 2000 16:08:06 -0500
Received: from jalon.able.es ([212.97.163.2]:40630 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129387AbQLKVIF>;
	Mon, 11 Dec 2000 16:08:05 -0500
Date: Mon, 11 Dec 2000 21:37:26 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Heiko.Carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU attachent and detachment in a running Linux system
Message-ID: <20001211213726.A1750@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <C12569B2.004D4100.00@d12mta01.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <C12569B2.004D4100.00@d12mta01.de.ibm.com>; from Heiko.Carstens@de.ibm.com on Mon, Dec 11, 2000 at 15:03:47 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Dec 2000 15:03:47 Heiko.Carstens@de.ibm.com wrote:
> 
> Recently I had some thoughts on how to realise CPU attachment and
> detachment in a running Linux system (based on the 2.4 kernel).
> 
> CPU attachment and detachment would make sense on an S/390 when there
> are several Linuxes running, each in its own logical partition. This
> way a CPU could be taken from one partition and be given to another
> partition (e.g. dependent on the current workload) on the fly without
> the need to reboot anything.
> 

Perhaps the PSet project can help you, take a look at

http://isunix.it.ilstu.edu/~thockin/pset/

I think it can be a good thing, now that linux has to manage with many
CPUs. But i think it is discontinued.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.18-vm #1 SMP Mon Dec 11 02:36:30 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
