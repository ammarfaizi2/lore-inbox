Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWJOPeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWJOPeA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 11:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWJOPd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 11:33:59 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:32963 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750900AbWJOPd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 11:33:59 -0400
Date: Sun, 15 Oct 2006 17:31:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
cc: John Richard Moser <nigelenki@comcast.net>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Driver model.. expel legacy drivers? 
In-Reply-To: <200610141854.k9EIs2CN005765@laptop13.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.61.0610151723410.7672@yvahk01.tjqt.qr>
References: <200610141854.k9EIs2CN005765@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I've mapped the growth of the .tar.bz2 archives in kilobytes since
>> 2.6.0, they show an erratic pattern but a strong overall linear growth
>> pattern.  This means the actual size of the kernel is polynomial and
>> integrates crudely to:
>> 
>>    18.59x^2+133.1x+32600
>> 
>> For x == minor (i.e. 2.6.0 == 0; 2.6.18 == 18).  This produces a level
>> of error; however, I've graphed the error and it seems to be off by no
>> more than 400k ever and show a horizontal trend (i.e. overall accurate);
>> however I'll have to apply the same prediction to future kernel versions
>> to get a good picture.
>
>Hum... perhaps going against time (not minor) is better?
>
>You could also include the whole 2.5.x set (at least since git became
>common) for a larger series...

Time to make things clear! Many webpages that compare the sizes of 
kernel evolution levels ("2.2.0 vs 2.4.0 vs 2.6.0") assume it grows 
exponentially. However, if you graph it over time (as Horst suggested), 
you get something that is quite linear. I took the sizes of uncompressed 
tarballs, since the mirror ftp and a good decompressing opteron happens 
to be connected right on the local Ethernet.
Share and enjoy:
http://img455.imageshack.us/img455/9192/kerneljg0.png


>
>[...]
>
>> My math predicts that 2.6.57 (+39) will be 100M (in approximately 7
>> years if you assume 1 kernel release every 2 months); 2.6.92 (+35) will
>> breech 200M; 2.6.117 (+25) will breech 300M; and 2.6.138 (+21)) will
>> breech 400M.  That should suffice for predictions over the next 20 years
>> based on this crude model.
>
>I'd trust your curve for, say, 5 minors. Not more. The quadratic term is
>rather hard to justify in any case... linear growth (== new drivers at a
>(roughly) constant rate, a (roughly) constant number of people actively
>working on the kernel with constant productivity, ...) I give you easily.
>-- 
>Dr. Horst H. von Brand                   User #22616 counter.li.org
>Departamento de Informatica                    Fono: +56 32 2654431
>Universidad Tecnica Federico Santa Maria             +56 32 2654239
>Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
>-


	-`J'
-- 
