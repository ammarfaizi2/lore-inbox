Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284937AbRLQACV>; Sun, 16 Dec 2001 19:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284942AbRLQACM>; Sun, 16 Dec 2001 19:02:12 -0500
Received: from datela-1-3-128.dialup.vol.cz ([212.20.98.18]:9988 "HELO
	ghost.ucw.cz") by vger.kernel.org with SMTP id <S284938AbRLQAB6>;
	Sun, 16 Dec 2001 19:01:58 -0500
Date: Mon, 17 Dec 2001 02:10:28 +0100 (MET)
From: <brain@artax.karlin.mff.cuni.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with OSS driver and GUS PnP card
Message-ID: <Pine.LNX.4.30.0112170152450.770-100000@ghost.ucw.cz>
X-Echelon: GRU Vatutinki Chodynka Khodinka Putin Suvorov USA Aquarium Russia Ladygin Lybia China Moscow missile reconnaissance agent spetsnaz security tactical target operation military nuclear force defense spy attack bomb explode tap MI5 IRS KGB CIA FBI NSA AK-47 MOSSAD M16 plutonium smuggle intercept plan intelligence war analysis president
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Since kernel 2.2 I've got permanent problems with my Gravis Ultrasound PnP card
and the OSS driver. The problem is following: /dev/dsp0 isn't able to
play/record sound because of "IRQ/DMA conflict" messages. /dev/dsp1 is playing
without problems, but it isn't able to record :-(

I have tried all possible settings of IO, IRQ and DMA. The problem persits. Can
anybody help me? Can anybody explain me what does parameters io, irq, dma,
dma16, gus16 and sb16 EXACTLY mean? The documentation is very poor and I'm not
sure if it is io/irq/dma of the GF1 chip or of the "SB digital audio" (as in
isapnp.conf). Is there any documentation on the gus driver?

Don't tell me to use Alsa. It's a piece of crap - the sound is very noisy, like
a waterfall in background.

Thanx

Brain

--------------------------------
Petr `Brain' Kulhavy
<brain@artax.karlin.mff.cuni.cz>
http://artax.karlin.mff.cuni.cz/~brain
Faculty of Mathematics and Physics, Charles University Prague, Czech Republic

---
First Law of Bicycling:
        No matter which way you ride, it's uphill and against the wind.

