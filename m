Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbQKMBZD>; Sun, 12 Nov 2000 20:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKMBYy>; Sun, 12 Nov 2000 20:24:54 -0500
Received: from jalon.able.es ([212.97.163.2]:60318 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129915AbQKMBYj>;
	Sun, 12 Nov 2000 20:24:39 -0500
Date: Mon, 13 Nov 2000 02:24:32 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.2.x-BUG(?) memmory not detected
Message-ID: <20001113022432.C886@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <5.0.0.25.2.20001113002439.0572d070@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <5.0.0.25.2.20001113002439.0572d070@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Mon, Nov 13, 2000 at 01:43:44 +0100
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Nov 2000 01:43:44 Anton Altaparmakov wrote:
> Hi,
> 
> Just noticed that both 2.2.18pre21 and RedHat-7.0-patched-2.2.16 kernels 
> only detect 64Mb out of 192Mb RAM on my Dual Celeron/Intel 440GX chipset 
> based workstation. - I haven't tried any other 2.2 kernels on that 
> particular PC so maybe this is a general 2.2.x thing.
> 
> The setup is one 64Mb SDRAM and one 128Mb SDRAM so it would seem that the 
> 128Mb one is not detected at all.
> 
> All 2.3/2.4 kernels I have tried have always detected the full 192Mb RAM.
> 

It's a bug, but in the mobo. Some motherboards lie about its installed ram.
2.3+ kernels have a workaround for detection, but in 2.2 you still have
to manually add <append="mem=128M"> in your lilo.conf file.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
