Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSFJMki>; Mon, 10 Jun 2002 08:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSFJMjj>; Mon, 10 Jun 2002 08:39:39 -0400
Received: from 27.Red-80-59-189.pooles.rima-tde.net ([80.59.189.27]:63478 "EHLO
	femto") by vger.kernel.org with ESMTP id <S313628AbSFJMik>;
	Mon, 10 Jun 2002 08:38:40 -0400
Date: Sun, 9 Jun 2002 19:36:55 +0200
From: Eric Van Buggenhaut <Eric.VanBuggenhaut@AdValvas.be>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 ooops when modprobe'ing if pci=biosirq
Message-ID: <20020609173654.GC2350@eric.ath.cx>
Reply-To: Eric.VanBuggenhaut@AdValvas.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Echelon: FBI WTC NSA Handgun Anthrax Afgahnistan Bomb Heroin Laden
X-message-flag: Microsoft discourages the use of Outlook.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My kernel ooops at boot time when using pci=biosirq.


Loading modules: 3c59x Unable to handle kernel paging request at
virtual address 00009a28
 printing eip:
c00f7241
*pde = 00000000
Oops: 0000
[...]
Process modprobe (pid: 34, stackpage=c1ddb000)



I tried pci=biosirq because I had a :

kernel: PCI: No IRQ known for interrupt pin A of device 00:09.0. Please try
using pci=biosirq.

When trying to get a Ricoh RL5c475 CardBus bridge working.

Is this a known bug ? What is the workaround ?

I'm not a kernel guru, so I don't exactly know how to give you useful
infos.

If you want the full ooops output, just let me know, i'd copy it by
hand.

Cheers,

-- 
Eric VAN BUGGENHAUT
Eric.VanBuggenhaut@AdValvas.be
