Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbQK3Uz5>; Thu, 30 Nov 2000 15:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbQK3Uzs>; Thu, 30 Nov 2000 15:55:48 -0500
Received: from einhorn.colt.in-berlin.de ([213.61.118.8]:59399 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id <S129501AbQK3Uzn>; Thu, 30 Nov 2000 15:55:43 -0500
Date: Thu, 30 Nov 2000 21:07:26 +0100
From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Message-Id: <200011302007.eAUK7Qs00611@bogomips.masq.in-berlin.de>
To: dick.streefland@tasking.com, Robert Schiele <rschiele@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: es1371 mixer problems
In-Reply-To: <20001130184209.A17335@kemi.tasking.nl>
In-Reply-To: <20001124135956.A5842@kemi.tasking.nl> <20001130134725.A12437@kemi.tasking.nl> <20001130182428.A2127@schiele.priv> <20001130184209.A17335@kemi.tasking.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, that makes it somewhat clearer to me. However, I don't use modules
> and have everything compiled in, so I can't control the order in which
> the mixer devices get loaded.

Exactly that's why I compile nearly everything as modules :-)
The other reason is that the turn-around times for driver hacking
are *much* smaller (until you managed to code a bug which kills
your box...).

> Perhaps the initialization order in the
> kernel should be changed?

Just because you don't like it?  No.  Get real.  Most newer gui mixer's
I've seen allow you to switch between mixer devices with tab's.  Even
the other ones allow you to specify the device you want to use.  And if
you will never ever use tvmixer just disable it.

> Excuse my ignorance, but what exactly is the purpose of the tvmixer?

Control volume/bass/treble of the TV card (assuming the hardware allows
this, doesn't work with all cards).

> I'm currently controlling the TV audio volume with the ac97 mixer,
> using an external cable between the TV card and sound card.

That's why most people don't need it.  If you would have connected your
speakers directly to the TV card without the soundcard (+ assorted mixer)
inbetween you would probably love tvmixer...

  Gerd

-- 
Wirtschaftsinformatiker == Leute, die zwar die aktuellen Aktienkurse
jedes Softwareherstellers kennen, aber keines der Produkte auch nur
ansatzweise bedienen können.		-- Benedict Mangelsdorff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
