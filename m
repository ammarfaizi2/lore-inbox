Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbQLIFG0>; Sat, 9 Dec 2000 00:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQLIFGR>; Sat, 9 Dec 2000 00:06:17 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:17412 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129596AbQLIFGC>;
	Sat, 9 Dec 2000 00:06:02 -0500
Message-Id: <200012090353.eB93rca07843@sleipnir.valparaiso.cl>
To: Donald Becker <becker@scyld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: question about tulip patch to set CSR0 for pci 2.0 bus 
In-Reply-To: Message from Donald Becker <becker@scyld.com> 
   of "Fri, 08 Dec 2000 16:09:47 CDT." <Pine.LNX.4.10.10012081558000.797-100000@vaio.greennet> 
Date: Sat, 09 Dec 2000 00:53:38 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker <becker@scyld.com> said:

[...]

> The best way to check for this buggy chipset was to check for a 486
> processor.  There are very few 486 chips on non-buggy motherboards, and the
> performance impact of shorter PCI bursts is minimal given the slow speed of
> the 486.

Enable it #if CONFIG_M486 || CONFIG_386 then?
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
