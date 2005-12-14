Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVLNILR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVLNILR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVLNILR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:11:17 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:43149 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751259AbVLNILR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:11:17 -0500
Message-ID: <439FD482.3080806@aitel.hist.no>
Date: Wed, 14 Dec 2005 09:14:58 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	<1133807641.9356.50.camel@laptopd505.fenrus.org>	<4395BBDB.307@ti-wmc.nl> <200512061850.20169.luke-jr@utopios.org>	<4397EB7A.7030404@aitel.hist.no> <87hd9jvgvz.fsf@amaterasu.srvr.nix>	<439D66AF.3010801@aitel.hist.no> <87u0dew12h.fsf@amaterasu.srvr.nix>	<439E81F7.3040803@aitel.hist.no> <87r78gsko7.fsf@amaterasu.srvr.nix>
In-Reply-To: <87r78gsko7.fsf@amaterasu.srvr.nix>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:

>>No.  While it is bad, it is not as bad as sw rendering. Tuxracer
>>with sw rendering is unbearable - 2 seconds per frame or so!
>>    
>>
>
>Ah, yes, tuxracer does have fairly high demands, doesn't it.
>
>[delay]
>
>I just installed the latest ppracer alpha (the closest out there to
>tuxracer)
>
>OK, I see 25-40fps with that, with DRI. If I turn on stencil buffering
>it gets unbearable, but that's just asking too much of the card I think
>
At what resolution?  25fps is nice enough - as good as movies.
I no longer remember exactly, but I had to use 640x480 to get
anything close to playable - lucky to get 10 or so fps.

I have been in touch with DRI developers before - this card isn't
supposed to be "great",  but it _is_ supposed to beat the
matrox G550 which it isn't even close to.  The matrox has its
own problems - it sometimes looses the font in this game, and
the fps reporting is wrong.  But the game is smooth at 1280x1024 . . .

>>Well, there is no AGPmode for a PCI card, is there?
>>    
>>
>
>Ah, this is a pure-PCI 9250, is it? (I wasn't aware you could get hold
>of those anymore... I think X supports them, but textured stuff is
>necessarily going to be slower.)
>  
>
Yes - it is a pure pci thing, because the AGP slot is taken by the matrox.
As for textured stuff being slower, I was under the impression that tuxracer
use something like a total of 3 different textures, that surely should fit
in the 64MB of onboard memory?  Now ppracer have more textures, but
old tuxracer levels don't actually use them.

Getting drawing commands into the card will of course also be slower
with PCI, but 'I hope that is a small part of the work.

Helge Hafting
