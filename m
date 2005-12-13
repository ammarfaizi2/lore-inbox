Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbVLMWVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVLMWVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVLMWVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:21:19 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:15876 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030277AbVLMWVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:21:18 -0500
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	<1133807641.9356.50.camel@laptopd505.fenrus.org>
	<4395BBDB.307@ti-wmc.nl> <200512061850.20169.luke-jr@utopios.org>
	<4397EB7A.7030404@aitel.hist.no> <87hd9jvgvz.fsf@amaterasu.srvr.nix>
	<439D66AF.3010801@aitel.hist.no> <87u0dew12h.fsf@amaterasu.srvr.nix>
	<439E81F7.3040803@aitel.hist.no>
From: Nix <nix@esperi.org.uk>
X-Emacs: anything free is worth what you paid for it.
Date: Tue, 13 Dec 2005 22:21:12 +0000
In-Reply-To: <439E81F7.3040803@aitel.hist.no> (Helge Hafting's message of
 "Tue, 13 Dec 2005 09:10:31 +0100")
Message-ID: <87r78gsko7.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, Helge Hafting mused:
> Nix wrote:
> [...]
> 
>>FWIW when glxgears is running, X consumes about 2% more CPU time
>>than normal: it's almost impossible to detect.
>>
> Sure - the load is low - and so is performance.  As if the machine
> isn't really trying - perhaps the driver is waiting when there is
> no need to wait.

If it gets it wrong X deadlocks, but yes, it does seem... odd.

>>It sounds to me almost like direct rendering is disabled, which will of
>>course have catastropic effects on performance. What does glxinfo say?
>>
> No.  While it is bad, it is not as bad as sw rendering. Tuxracer
> with sw rendering is unbearable - 2 seconds per frame or so!

Ah, yes, tuxracer does have fairly high demands, doesn't it.

[delay]

I just installed the latest ppracer alpha (the closest out there to
tuxracer)

OK, I see 25-40fps with that, with DRI. If I turn on stencil buffering
it gets unbearable, but that's just asking too much of the card I think.

>>The X startup log can also be useful here. I've noticed that if you
>>get the AGPMode wrong in either direction, the results can be
>>catastrophic: if it's too low the card is terribly slow and if it's
>>too high you soon get the X server hanging as it waits forever for
>>the card to respond to something it hasn't had time to receive (or
>>something like that, anyway).
>>
> Well, there is no AGPmode for a PCI card, is there?

Ah, this is a pure-PCI 9250, is it? (I wasn't aware you could get hold
of those anymore... I think X supports them, but textured stuff is
necessarily going to be slower.)

-- 
`I must caution that dipping fingers into molten lead
 presents several serious dangers.' --- Jearl Walker
