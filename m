Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130595AbQKGB1x>; Mon, 6 Nov 2000 20:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129278AbQKGB1V>; Mon, 6 Nov 2000 20:27:21 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:9735 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129147AbQKGB1E>;
	Mon, 6 Nov 2000 20:27:04 -0500
Message-Id: <200011070032.eA70WbM05177@sleipnir.valparaiso.cl>
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: Message from Oliver Xymoron <oxymoron@waste.org> 
   of "Mon, 06 Nov 2000 13:09:19 MDT." <Pine.LNX.4.10.10011061305040.30477-100000@waste.org> 
Date: Mon, 06 Nov 2000 21:32:37 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> say:

[...]

> Ioctl (or alternate device for plan9 groupies) is fine. My point is final
> initialization of the device is obviously delayed until the firmware is
> loaded.

Let's play perverse: What if I load the module, but don't initialize the
firmware, then unload? The fact that the firmware has been initialized has
to be kept somewhere...
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
