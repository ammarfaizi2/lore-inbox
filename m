Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286807AbSABHjP>; Wed, 2 Jan 2002 02:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286806AbSABHjF>; Wed, 2 Jan 2002 02:39:05 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:47119 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S286802AbSABHi4>; Wed, 2 Jan 2002 02:38:56 -0500
Date: Wed, 2 Jan 2002 18:39:42 +1100
From: john slee <indigoid@higherplane.net>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New Scheduler and Digital Signal Processors?
Message-ID: <20020102183942.A14169@higherplane.net>
In-Reply-To: <20020101050208.OMXO20896.femail24.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020101050208.OMXO20896.femail24.sdc1.sfba.home.com@there>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2001 at 04:00:26PM -0500, Rob Landley wrote:
> DSP is just a processor designed to do I/O. It runs a program telling it how 
> to convert input into output.  Ooh.  This is half of unix programming, and 
> why we have the pipe command, only now you can unload each pipe stage on a 

thats all well and good if whatever is on the output side of the dsp is
the final destination for your data but surely bouncing it around
between all those dsp chips is going to take time...

> dedicated coprocessor, so you can program your sound output chip to do speech 
> synthesis or decompress MP3's.  And latency becomes way less of a problem if 
> you can dedicate a processor to it.  (Think of a DMA channel that can run a 
> filter program on the data it's transporting, and boom: you've got a DSP.)  
> In theory, anything you can write as a filter that sits on a pipe could be 
> done by a DSP, and in the Unix philosophy that's just about everything.

i have a high-end-ish soundcard that has four analogdevices SHARC DSPs
on it.  using the (unfortunately windows/mac only) software you upload
synth/effects code to it, draw your signal routing on teh screen, then
control it through midi ports on the back of the card... (or with cubase
or similar.)

its a great system, and as you allude to the latency is fantastically
low.  for more info, see http://www.creamware.com/.  my card is a bit
old (the "pulsar" model) but all of their cards are built on the same
platform.  i believe that with their proprietary bus and more expensive
cards you can use up to 45 SHARCs as one huge synth engine.

these days people are doing much the same thing in software (witness
cubase VST, buzz, fruityloops, rebirth, reason, logic, etc etc) but
while today's athlons et al. are getting fast enough for it there's a
few nice aspects of the dsp solution that make it a clear winner (in my
eyes at least).   such as not hearing clicks/jitter when you move the
mouse too rapidly...

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
