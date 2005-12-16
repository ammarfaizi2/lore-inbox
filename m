Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVLPHiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVLPHiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 02:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVLPHiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 02:38:12 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:44808 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932164AbVLPHiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 02:38:11 -0500
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	<1133807641.9356.50.camel@laptopd505.fenrus.org>
	<4395BBDB.307@ti-wmc.nl> <200512061850.20169.luke-jr@utopios.org>
	<4397EB7A.7030404@aitel.hist.no> <87hd9jvgvz.fsf@amaterasu.srvr.nix>
	<439D66AF.3010801@aitel.hist.no> <87u0dew12h.fsf@amaterasu.srvr.nix>
	<439E81F7.3040803@aitel.hist.no> <87r78gsko7.fsf@amaterasu.srvr.nix>
	<439FD482.3080806@aitel.hist.no>
From: Nix <nix@esperi.org.uk>
X-Emacs: the answer to the world surplus of CPU cycles.
Date: Fri, 16 Dec 2005 07:38:02 +0000
In-Reply-To: <439FD482.3080806@aitel.hist.no> (Helge Hafting's message of
 "Wed, 14 Dec 2005 09:14:58 +0100")
Message-ID: <87r78dh4px.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[My Radeon 9250-AGP is fine, Helge's 9250-PCI is dog slow]

On Wed, 14 Dec 2005, Helge Hafting wrote:
> Nix wrote:
> 
>>OK, I see 25-40fps with that, with DRI. If I turn on stencil buffering
>>it gets unbearable, but that's just asking too much of the card I think
>>
> At what resolution?  25fps is nice enough - as good as movies.
> I no longer remember exactly, but I had to use 640x480 to get
> anything close to playable - lucky to get 10 or so fps.

1280x1024.

I think we can fairly say that there's a system config difference here
of some kind. :)

> I have been in touch with DRI developers before - this card isn't
> supposed to be "great",  but it _is_ supposed to beat the
> matrox G550 which it isn't even close to.  The matrox has its
> own problems - it sometimes looses the font in this game, and
> the fps reporting is wrong.  But the game is smooth at 1280x1024 . . .

... as with my 9250.

>>Ah, this is a pure-PCI 9250, is it? (I wasn't aware you could get hold
>>of those anymore... I think X supports them, but textured stuff is
>>necessarily going to be slower.)
>>
> Yes - it is a pure pci thing, because the AGP slot is taken by the matrox.
> As for textured stuff being slower, I was under the impression that tuxracer
> use something like a total of 3 different textures, that surely should fit
> in the 64MB of onboard memory?  Now ppracer have more textures, but
> old tuxracer levels don't actually use them.

True enough.


I'll admit I'm not sure why you're seeing such a speed difference if
hardware rendering is on; an order of magnitude seems a bit much just
for PCI versus AGP. Perhaps Dave knows?

-- 
`I must caution that dipping fingers into molten lead
 presents several serious dangers.' --- Jearl Walker
