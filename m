Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131482AbQLRJUd>; Mon, 18 Dec 2000 04:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbQLRJUX>; Mon, 18 Dec 2000 04:20:23 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:65495 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S131482AbQLRJUL>;
	Mon, 18 Dec 2000 04:20:11 -0500
Message-Id: <4.3.2.7.2.20001218034609.00b31cc0@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 18 Dec 2000 03:49:44 -0500
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
From: David Feuer <David_Feuer@brown.edu>
Subject: Re: /dev/random: really secure?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001218092158.A7328@atrey.karlin.mff.cuni.cz>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKKEFEMIAA.davids@webmaster.com>
 <20001217225057.A8897@atrey.karlin.mff.cuni.cz>
 <NCBBLIEPOCNJOAEKBEAKKEFEMIAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:21 AM 12/18/2000 +0100, Karel Kulhavy wrote:
> >       There are hidden sources of entropy. One is clock skew between 
> the keyboard
> > processor's clock, the keyboard controller's clock, and the CPU clock
> > generator's PLL. Another is data motion between the CPU cache and main
>
>In the RFC 1750, they write it is not recommended to rely on computer 
>clocks to
>generate random. Isn't it this case?

This is the case, but the important thing that David Schwartz said is that 
it does not rely on the time in a clock, but rather on the pretty much 
completely random skew between several independent clocks.  Any particular 
oscillator will vary in speed semi-randomly, and if you compare multiple 
clocks you can get pretty random numbers.

--
This message has been brought to you by the letter alpha and the number pi.
Open Source: Think locally; act globally.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
