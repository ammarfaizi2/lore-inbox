Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQLDQmD>; Mon, 4 Dec 2000 11:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbQLDQly>; Mon, 4 Dec 2000 11:41:54 -0500
Received: from smtp2.ihug.co.nz ([203.109.252.8]:35853 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S129532AbQLDQlj>;
	Mon, 4 Dec 2000 11:41:39 -0500
Message-ID: <3A2BC207.45B8EF2E@ihug.co.nz>
Date: Tue, 05 Dec 2000 05:10:47 +1300
From: Gerard Sharp <gsharp@ihug.co.nz>
Reply-To: gsharp@ihug.co.nz
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11-ac4-smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gnea <gnea@rochester.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
In-Reply-To: <3A2785BB.EB36DDE0@ihug.co.nz> <20001202162105.AAA28297@mail2.nyroc.rr.com@celery>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gnea wrote:
> >  [1.] One line summary of the problem:
> >  Intermittent corruption of 4 bytes in SMP kernels using HPT366
> [snip]
> Have you tried updating the bios on the bp6? This solved a LOT of
> problems for me, and afaik, ru is the latest... 

RU seems the latest. Flashed bios as per your nicely detailed
instructions.
No improvement in condition, alas.

> also, the overclocking might be a bad thing in this case unless you 
> have the proper cooling for it (lm-sensors is great for this sort of
> thing :) there's a neat wm applet called wmbp6 too) so u may want to 
> try clocking it straight at 300 for awhile and see what effect that 
> has.. hope this helps

Err. "300(66)" probably won't help too much. The cpu's are multiplier
locked (love that one, Intel); so will run at 7 * 66 (466) when set to
chip defaults - which I currently am - to rule out flaky / stressed
hardware.

Temperatures are a nice frosty 30 deg C across all the temperature
sensors lm_sensors offers; and the thermal probe I have dangling in the
psu exhaust :)
[this is with two rc5des clients running - loadavg of 2 - btw]

Back to the original topic, I've done some more 'research'; and I'm not
_certain_ of my findings, but there's a few coincidences here...

I think I'll make a more general post to lkml direct in a minute.


Gerard Sharp
Two penguins at 1024x768
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
