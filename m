Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTDMLDr (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 07:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTDMLDr (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 07:03:47 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:42114 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263461AbTDMLDq (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 07:03:46 -0400
Subject: Re: 2.5.67-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <200304130317.h3D3HprZ021939@turing-police.cc.vt.edu>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
	 <1050198928.597.6.camel@teapot.felipe-alfaro.com>
	 <200304130317.h3D3HprZ021939@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1050232513.593.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 13 Apr 2003 13:15:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-13 at 05:17, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 13 Apr 2003 03:55:29 +0200, Felipe Alfaro Solana said:
> 
> > Any patches for CardBus/PCMCIA support? It's broken for me since
> > 2.5.66-mm2 (it works with 2.5.66-mm1) probably due to PCI changes or the
> > new PCMCIA state machine: if I boot my machine with my 3Com CardBus NIC
> > plugged in, the kernel deadlocks while checking the sockets, but it
> > works when booting with the card unplugged, and then plugging it back
> > once the system is stable (for example, init 1).
> 
> Also seeing this with a Xircom card under vanilla 2.5.67.
> 
> lspci reports this card as:
> 
> 03:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
> 03:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03)
> 
> Russel King posted an analysis back on April 1, which indicated he knew
> about the problem, understood it, and was working on it.

Yeah! I know, but I wrote him and didn't get a response, so I'm a little
bit worried. I assume he'll be too busy.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

