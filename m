Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285182AbRLRVQQ>; Tue, 18 Dec 2001 16:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285179AbRLRVOk>; Tue, 18 Dec 2001 16:14:40 -0500
Received: from datelc-237.dialup.vol.cz ([212.20.103.238]:33028 "HELO
	ghost.ucw.cz") by vger.kernel.org with SMTP id <S285161AbRLRVNb>;
	Tue, 18 Dec 2001 16:13:31 -0500
Date: Tue, 18 Dec 2001 23:13:38 +0100 (MET)
From: <brain@artax.karlin.mff.cuni.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with GUS PnP: ad1848, pnp
Message-ID: <Pine.LNX.4.30.0112182250200.1216-100000@ghost.ucw.cz>
X-Echelon: GRU Vatutinki Chodynka Khodinka Putin Suvorov USA Aquarium Russia Ladygin Lybia China Moscow missile reconnaissance agent spetsnaz security tactical target operation military nuclear force defense spy attack bomb explode tap MI5 IRS KGB CIA FBI NSA AK-47 MOSSAD M16 plutonium smuggle intercept plan intelligence war analysis president
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

When I'm loading modules for my GUS PnP card, I get "No PnP cards found! Trying
standard ones..." message from the ad1848 module. Can you tell me if this is
an error or correct behaviour?

Do I have to give the ad1848 module some parameters? It has io, irq, dma and
dma2 parameters.

I also don't know which pnp driver/tool use to initialize the card. When I use
isapnp tools (and set io=0x220 irq=11,12 dma=5,7) and then read /proc/isapnp, I
get really WEIRD output. I'm using lates 1.26 version of isapnp tools.

Card 1 'GRV0001:Advanced Gravis InterWave Audio' PnP version 1.0 Product version 1.0
  Logical device 0 'GRV0000:Synth & Codec'
    Supported registers 0x2
    Device is active
    Active port 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
    Active IRQ 255 [0xff],255 [0xff]
    Active DMA 255,255
    Active memory 0xffffffff,0xffffffff,0xffffffff,0xffffffff

When I set the values using cat > /proc/isapnp (as described in
Documentation/isapnp.txt) and then cat /proc/isapnp, the values are correct.
That means one of (or both ;-) ) either isa-pnp module or isapnp tools ISN'T
ABLE to setup the PnP card. Can you tell me which one is the bad working?

Thanx

Brain

--------------------------------
Petr `Brain' Kulhavy
<brain@artax.karlin.mff.cuni.cz>
http://artax.karlin.mff.cuni.cz/~brain
Faculty of Mathematics and Physics, Charles University Prague, Czech Republic

---
Putt's Law:
        Technology is dominated by two types of people:
                Those who understand what they do not manage.
                Those who manage what they do not understand.

