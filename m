Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267678AbTACVed>; Fri, 3 Jan 2003 16:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTACVed>; Fri, 3 Jan 2003 16:34:33 -0500
Received: from main.gmane.org ([80.91.224.249]:46998 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267678AbTACVeb>;
	Fri, 3 Jan 2003 16:34:31 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Steven Barnhart" <sbarn03@softhome.net>
Subject: Re: [2.5.54, PNP, SOUND] compile error
Date: Fri, 03 Jan 2003 16:42:15 -0500
Message-ID: <pan.2003.01.02.16.03.15.835788@softhome.net>
References: <87hecr4w6x.fsf@jupiter.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.0 (The whole remains beautiful)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jan 2003 12:39:50 +0100, Jochen Hein wrote:


> 
>   CC [M]  sound/isa/cs423x/cs4232.o
> In file included from sound/isa/cs423x/cs4232.c:2:
> sound/isa/cs423x/cs4236.c: In function `snd_card_cs4236_isapnp':
> sound/isa/cs423x/cs4236.c:287: warning: implicit declaration of function `isapnp_find_dev'
> sound/isa/cs423x/cs4236.c:287: warning: assignment makes pointer from integer without a cast
> sound/isa/cs423x/cs4236.c:288: structure has no member named `active'
> sound/isa/cs423x/cs4236.c:292: warning: assignment makes pointer from integer without a cast
> sound/isa/cs423x/cs4236.c:293: structure has no member named `active'
> sound/isa/cs423x/cs4236.c:298: warning: assignment makes pointer from integer without a cast
> sound/isa/cs423x/cs4236.c:299: structure has no member named `active'
> sound/isa/cs423x/cs4236.c:307: structure has no member named `prepare'
> sound/isa/cs423x/cs4236.c:310: warning: implicit declaration of function `isapnp_resource_change'
> sound/isa/cs423x/cs4236.c:321: structure has no member named `activate'
> sound/isa/cs423x/cs4236.c:339: structure has no member named `prepare'
> sound/isa/cs423x/cs4236.c:340: structure has no member named `deactivate'
> sound/isa/cs423x/cs4236.c:345: structure has no member named `activate'
> sound/isa/cs423x/cs4236.c:347: structure has no member named `deactivate'
> sound/isa/cs423x/cs4236.c:356: structure has no member named `prepare'
> sound/isa/cs423x/cs4236.c:357: structure has no member named `deactivate'
> sound/isa/cs423x/cs4236.c:358: structure has no member named `deactivate'
> sound/isa/cs423x/cs4236.c:365: structure has no member named `activate'
> sound/isa/cs423x/cs4236.c: In function `snd_card_cs4236_deactivate':
> sound/isa/cs423x/cs4236.c:386: structure has no member named `deactivate'
> sound/isa/cs423x/cs4236.c:390: structure has no member named `deactivate'
> sound/isa/cs423x/cs4236.c:394: structure has no member named `deactivate'
> sound/isa/cs423x/cs4236.c: In function `alsa_card_cs423x_init':
> sound/isa/cs423x/cs4236.c:588: warning: implicit declaration of function `isapnp_probe_cards'
> make[4]: *** [sound/isa/cs423x/cs4232.o] Fehler 1
> make[3]: *** [sound/isa/cs423x] Fehler 2
> make[2]: *** [sound/isa] Fehler 2
> make[1]: *** [sound] Fehler 2
> make[1]: Leaving directory `/usr/src/linux-2.5.54'
> make: *** [stamp-build] Fehler 2
> 
> Jochen

I got the same problem. I'm guessing maybe a missing include file?

Steven


