Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbTANPPV>; Tue, 14 Jan 2003 10:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbTANPPV>; Tue, 14 Jan 2003 10:15:21 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:40303
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263291AbTANPPV>; Tue, 14 Jan 2003 10:15:21 -0500
Date: Tue, 14 Jan 2003 10:24:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Capaul Giachen F (KADA 12)" <flurin.capaul@csfs.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Assinging of IRQ to an ethernet card
In-Reply-To: <F12E8D9F1EA37D4E9165C8D13ECA6952013672FE@sxchs017.csintra.net>
Message-ID: <Pine.LNX.4.44.0301141020120.14166-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, Capaul Giachen F (KADA 12) wrote:

> My ethernet card is unfortunately being assigned IRQ 19 instead of IRQ 
> 11. My C and kernel knowledge is virtually inexisten, yet I'd like to try 
> and fix that myself, by  basically telling my kernel that IRQ 11 is the 
> one to take. I had a look at a driver code (8139too.c) and was under the 
> impression that the assignment of the IRQ is done somewhere else. I'm 
> currently looking at irq.c in the arch\i386\pci\ directory. Is that the 
> . right place to attempt this, or should I be looking somewhere else? 

It could be your irq line wiring to the IOAPIC, can you try booting with 
the 'noapic' kernel parameter?

	Zwane
-- 
function.linuxpower.ca


