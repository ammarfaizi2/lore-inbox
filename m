Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319369AbSIKWcD>; Wed, 11 Sep 2002 18:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319370AbSIKWcD>; Wed, 11 Sep 2002 18:32:03 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:41733 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S319369AbSIKWcC>; Wed, 11 Sep 2002 18:32:02 -0400
Message-Id: <200209112236.g8BMaMMD016898@pincoya.inf.utfsm.cl>
To: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USER_HZ & NTP problems 
In-Reply-To: Message from Rolf Fokkens <fokkensr@fokkensr.vertis.nl> 
   of "Tue, 10 Sep 2002 08:37:17 +0200." <200209100637.g8A6bMm01628@fokkensr.vertis.nl> 
Date: Wed, 11 Sep 2002 18:36:22 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Fokkens <fokkensr@fokkensr.vertis.nl> said:
> On Tuesday 10 September 2002 08:09, Vojtech Pavlik wrote:
> > Actually, the clock true frequency is 1193181.8 Hz, although most
> > manuals say 1.19318 MHz, which, because truncating more digits, also
> > correct. But 1193180 Hz isn't. If you're trying to count the time
> > correctly, you should better use 1193182 Hz if staying in integers.
> 
> I copied the clock frequency from the kernel source, timex.h defines:
> 
> #define CLOCK_TICK_RATE 1193180
> 
> If what you're saying is correct, timex.h uses the wrong value as wel I guess.

I'd be _really_ surprised if that number is within 1% (+-11932 or so)
correct, an error in the last digit (0.0001%) is surely lost. 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
