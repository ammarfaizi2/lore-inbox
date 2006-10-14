Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422800AbWJNSzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWJNSzP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422812AbWJNSzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:55:15 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:54948 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1422800AbWJNSzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:55:14 -0400
Message-Id: <200610141854.k9EIs2CN005765@laptop13.inf.utfsm.cl>
To: John Richard Moser <nigelenki@comcast.net>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Driver model.. expel legacy drivers? 
In-Reply-To: Message from John Richard Moser <nigelenki@comcast.net> 
   of "Sat, 14 Oct 2006 11:04:46 -0400." <4530FC8E.7020504@comcast.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Sat, 14 Oct 2006 14:54:02 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 14 Oct 2006 14:54:04 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser <nigelenki@comcast.net> wrote:

[...]

> I've mapped the growth of the .tar.bz2 archives in kilobytes since
> 2.6.0, they show an erratic pattern but a strong overall linear growth
> pattern.  This means the actual size of the kernel is polynomial and
> integrates crudely to:
> 
>    18.59x^2+133.1x+32600
> 
> For x == minor (i.e. 2.6.0 == 0; 2.6.18 == 18).  This produces a level
> of error; however, I've graphed the error and it seems to be off by no
> more than 400k ever and show a horizontal trend (i.e. overall accurate);
> however I'll have to apply the same prediction to future kernel versions
> to get a good picture.

Hum... perhaps going against time (not minor) is better?

You could also include the whole 2.5.x set (at least since git became
common) for a larger series...

[...]

> My math predicts that 2.6.57 (+39) will be 100M (in approximately 7
> years if you assume 1 kernel release every 2 months); 2.6.92 (+35) will
> breech 200M; 2.6.117 (+25) will breech 300M; and 2.6.138 (+21)) will
> breech 400M.  That should suffice for predictions over the next 20 years
> based on this crude model.

I'd trust your curve for, say, 5 minors. Not more. The quadratic term is
rather hard to justify in any case... linear growth (== new drivers at a
(roughly) constant rate, a (roughly) constant number of people actively
working on the kernel with constant productivity, ...) I give you easily.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
