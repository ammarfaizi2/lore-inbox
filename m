Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbSL1RIP>; Sat, 28 Dec 2002 12:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbSL1RIO>; Sat, 28 Dec 2002 12:08:14 -0500
Received: from [81.2.122.30] ([81.2.122.30]:28933 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266199AbSL1RIO>;
	Sat, 28 Dec 2002 12:08:14 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212281715.gBSHFkf3001354@darkstar.example.net>
Subject: Re: Want a random entropy source?
To: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 28 Dec 2002 17:15:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021228164750.A5217@flint.arm.linux.org.uk> from "Russell King" at Dec 28, 2002 04:47:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have never understood how a 16-bit DAC or ADC can have noise above
> > 96 dB.  Surely _by definition_ a 16-bit DAC or ADC is one that does
> > not have noise above that level.
> 
> You're assuming that the ADC input is coupled to a noiseless source.
> Most ADCs have a chunk of analogue circuitry just before them which
> is a nice source of noise.
> 
> Not only will noise be picked up via disconnected inputs, but it will
> also be picked up via the power supply and ground connections to that
> analogue circuit.  How much of that noise gets into the ADC input is
> dependent on the quality, design and physical layout of the analogue
> circuit.

Right...  So basically it can be claimed to be a 16-bit ADC as long as
it is noiseless above 96 dB, when all of the inputs to the ADC are
correctly terminated directly at the ADC inputs.

I just think it's funny that loads of "16-bit" soundcards are
effectively only 12-bit soundcards :-).  Especially as that's about
the noise-floor of good quality vinyl :-).

> (As a side note, it's interesting that (what used to be) Crystal
> Semiconductor published a large chunk of information on the layout of
> boards including the routing of power supplies for combined digital
> and analogue circuits (and ADCs fall into that category.))

Good idea - I'd be grateful if more manufacturers would supply a
datasheet at all :-).

John.
