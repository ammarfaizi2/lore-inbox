Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131218AbQLEPDa>; Tue, 5 Dec 2000 10:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131216AbQLEPDU>; Tue, 5 Dec 2000 10:03:20 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:63755 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130484AbQLEPDF>; Tue, 5 Dec 2000 10:03:05 -0500
Date: Tue, 5 Dec 2000 15:32:36 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip_nat_ftp and different ports
In-Reply-To: <Pine.LNX.4.21.0012040258260.479-100000@tux.rsn.hk-r.se>
Message-ID: <Pine.LNX.4.21.0012051526460.12507-100000@hewpac.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm running 1.1.2 right now, actually, which should have the 'ftp-multi
> > patch for non-standard ftp servers'...
> 
> Well have you applied the ftp-multi patch? (this is a patch so that the
> ftp-module takes a ports parameter, the thing you probably are talking
> about is a bug which I and several others found in the ftp-module, these
> two things have nothing with each other to do.) 

Well, after having no time for a coule of days, back to business ;))
I've downloaded + applied the ftp-multi patch and recompiled the modules.
then loaded them with ports=21,41,42,62,63, which works (well, no
errors/warnings...).
Then trying the application for which i needed it: doesn't work ;((

Are there maybe some major/crucial differences between the 2.2.x version
(which works) of ip_masq_ftp and the 2.4.x version of ip_nat_ftp ??

Cheers,
Taco.
---
"I was only 75 years old when I met her and I was still a kid...."
          -- Duncan McLeod

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
