Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLOTjf>; Fri, 15 Dec 2000 14:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLOTj0>; Fri, 15 Dec 2000 14:39:26 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:21509 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129408AbQLOTjQ>; Fri, 15 Dec 2000 14:39:16 -0500
Message-Id: <200012151906.eBFJ6ac28241@pincoya.inf.utfsm.cl>
To: root@chaos.analogic.com
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Andrea Arcangeli <andrea@suse.de>, Mike Black <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h 
In-Reply-To: Message from "Richard B. Johnson" <root@chaos.analogic.com> 
   of "Fri, 15 Dec 2000 13:34:41 CDT." <Pine.LNX.3.95.1001215131538.1528B-100000@chaos.analogic.com> 
Date: Fri, 15 Dec 2000 16:06:36 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> said:

[...]

> 	Both examples allow an extern declaration inside a function scope
> 	which is also contrary to any (even old) 'C' standards. 'extern'
> 	is always file scope, there's no way to make it otherwise.

AFAIR (rather dimly... no K&R at hand here) if you have an extern
declaration inside a block, it will be visible only within that block. The
object itself certainly is file scope (or larger).
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
