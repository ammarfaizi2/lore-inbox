Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUIVITU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUIVITU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 04:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUIVITU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 04:19:20 -0400
Received: from [213.146.154.40] ([213.146.154.40]:58496 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261875AbUIVITR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 04:19:17 -0400
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97  
	patch)
From: David Woodhouse <dwmw2@infradead.org>
To: David Lloyd <dmlloyd@tds.net>
Cc: SashaK <sashak@smlink.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0409211504440.7029@tomservo.workpc.tds.net>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se>
	 <20040912011128.031f804a@localhost>
	 <1095785705.17821.760.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.60.0409211504440.7029@tomservo.workpc.tds.net>
Content-Type: text/plain
Message-Id: <1095841141.17821.819.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 22 Sep 2004 09:19:01 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 15:09 -0500, David Lloyd wrote:
> On Tue, 21 Sep 2004, David Woodhouse wrote:
> 
> > On Sun, 2004-09-12 at 01:11 +0300, SashaK wrote:
> >> This is exactly that was discussed - 'slamr' is going to be replaced by
> >> ALSA drivers. I don't know which modem you have, but recent ALSA
> >> driver (CVS version) already supports ICH, SiS, NForce (snd-intel8x0m),
> >> ATI IXP (snd-atiixp-modem) and VIA (snd-via82xx-modem) AC97 modems.
> >
> > What chance of making it work with the ISDN drivers? Should we make an 
> > ALSA driver for ISDN?
> 
> That's an interesting idea.  Some thoughts I'd have off the bat:
> 
> - I don't think there's a software modem implementation (free or
>    otherwise) for linux that can support the server side of a digital
>    (v.90, v.92) connection, but that would be excellent to have

That'd be even better, yes -- but I was thinking of v.34.
Even having just v.29 (fax) would be nice.

> - Americans might have an FCC concern due to power output restrictions on
>    digital modem protocols, and also other voice applications

You can already use the Linux ISDN code in 'voice modem' mode and do
what you like with it... what would concern them more?

> - Presumably it would only make sense to do this with voice connections

Indeed.

> - Could this idea be extended to analog telephony devices?

Ideally, it could be extended to analogue coupling using standard
speakers and microphone. :)

-- 
dwmw2

