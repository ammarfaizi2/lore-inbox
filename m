Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbQKGB1c>; Mon, 6 Nov 2000 20:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130428AbQKGB1V>; Mon, 6 Nov 2000 20:27:21 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:9479 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129278AbQKGB1L>;
	Mon, 6 Nov 2000 20:27:11 -0500
Message-Id: <200011070004.eA704KJ05129@sleipnir.valparaiso.cl>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: Message from David Woodhouse <dwmw2@infradead.org> 
   of "Mon, 06 Nov 2000 17:12:16 -0000." <7101.973530736@redhat.com> 
Date: Mon, 06 Nov 2000 21:04:20 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> said:

[...]

> No. You should initialise the hardware completely when the driver is 
> reloaded. Although the expected case is that the levels just happen to be 
> the same as the last time the module was loaded, you can't know that the 
> machine hasn't been suspended and resumed since then.

Oh? Suspending with the module loaded is forbidden then?
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
