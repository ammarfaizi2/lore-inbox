Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277580AbRJ3I3p>; Tue, 30 Oct 2001 03:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278949AbRJ3I3f>; Tue, 30 Oct 2001 03:29:35 -0500
Received: from gw1-mail.cict.fr ([195.220.59.20]:52496 "EHLO gw1-mail.cict.fr")
	by vger.kernel.org with ESMTP id <S277580AbRJ3I32>;
	Tue, 30 Oct 2001 03:29:28 -0500
Message-ID: <3BDE648E.135B39B8@irit.fr>
Date: Tue, 30 Oct 2001 09:27:58 +0100
From: Jerome AUGE <auge@irit.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: opl3sa2 sound driver and mixers
In-Reply-To: <Pine.LNX.4.33.0110300140020.20844-100000@rancor.yyz.somanetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Murray wrote:
> 
> On Mon, 29 Oct 2001, Alan Cox wrote:
> 
> > > Please read Documentation/sound/OPL3-SA2 (the two mixers are intentional,
> > > some channels are available only on the MSS mixer, others only on the
> > > OPL3-SA2), and don't break the driver! Since the latest DMA fix finally
> > > everything works fine on my Portege 3010 (which is exactly the same as the
> > > 3020 except for a slower CPU and smaller disk).
> >
> > Thanks for warning me and saving me the effort of decoding it all
> 
> I've found myself too busy at work over the last while to really look into
> any issues with this driver.  Anyone keen on taking over as maintainer?
> 

Some times ago I wanted to change the mixer part and get back to the
"original" one, with a single mixer ... but as it was intentional, I
left it like this.

However I think it would be a good thing to present, to the user, a
single mixer. You have 1 or more soundcards and each soundcard have a
single mixer that control all the volume available with this card, no ?

If Alan has not yet released a patch that changes this ... I could try
to put all the controls back together ... and it will be the occasion to
learn a little bit more of that "mighty and scaring kernel" :)

--
