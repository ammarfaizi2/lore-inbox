Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264383AbRFYOUo>; Mon, 25 Jun 2001 10:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264563AbRFYOUe>; Mon, 25 Jun 2001 10:20:34 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:4621 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S264383AbRFYOUV>; Mon, 25 Jun 2001 10:20:21 -0400
Message-Id: <200106241733.f5OHXpW2000565@sleipnir.valparaiso.cl>
To: Fabian Arias <dewback@vtr.net>
cc: Anuradha Ratnaweera <anuradha@gnu.org>, Anatoly Ivanov <avi@levi.spb.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 and gcc v3 final 
In-Reply-To: Message from Fabian Arias <dewback@vtr.net> 
   of "Sun, 24 Jun 2001 12:33:58 -0400." <Pine.LNX.4.21.0106241230300.876-100000@localhost.localdomain> 
Date: Sun, 24 Jun 2001 13:33:51 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabian Arias <dewback@vtr.net> said:
> On Sun, 24 Jun 2001, Anuradha Ratnaweera wrote:
> > On Fri, Jun 22, 2001 at 10:29:25AM +0400, Anatoly Ivanov wrote:
> > > I hope that lk-developers would fix it one day.

> > Multi-string literals is a nice little ANSI C feature that appears
> > everywhere.  Why it is necessary to "fix" them?

> I think that "fix" doesn't necesary mean "kill" the feature.
> But is a problem that some of us, compiling the ac series with gcc-3, have
> had. 

What gcc objects to is stuff like:

   "This is a nice long string
    that just goes on
    and on\n"

which is illegal in C AFAIU. It does not object to:

   "This long string"
   "spans several lines, "
   "but legally.\n"

The first form does/did appear in several asm()s. Fix them, send a patch.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
