Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129114AbQKGB1V>; Mon, 6 Nov 2000 20:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQKGB1L>; Mon, 6 Nov 2000 20:27:11 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:9991 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129114AbQKGB07>;
	Mon, 6 Nov 2000 20:26:59 -0500
Message-Id: <200011062354.eA6NsT705093@sleipnir.valparaiso.cl>
To: "James A. Sutherland" <jas88@cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: Message from "James A. Sutherland" <jas88@cam.ac.uk> 
   of "Mon, 06 Nov 2000 17:01:36 -0000." <00110617033201.01646@dax.joh.cam.ac.uk> 
Date: Mon, 06 Nov 2000 20:54:29 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James A. Sutherland" <jas88@cam.ac.uk> said:
> On Mon, 06 Nov 2000, Horst von Brand wrote:

[...]

> > The problem (AFAIU) is that if the levels aren't set on startup, they are
> > random in some cases.

> So set them on startup. NOT when the driver is first loaded. Put it in
> the rc.d scripts.

There is a noticeable delay between to moment the module is insmod(8)ed,
and the moment when its settings are set by the startup script. Not funny
if it is going full blast ATM.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
