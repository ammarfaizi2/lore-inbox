Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLFXnU>; Wed, 6 Dec 2000 18:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbQLFXnK>; Wed, 6 Dec 2000 18:43:10 -0500
Received: from ns1.metabyte.com ([216.218.208.34]:46595 "EHLO ns1.metabyte.com")
	by vger.kernel.org with ESMTP id <S131452AbQLFXm7>;
	Wed, 6 Dec 2000 18:42:59 -0500
From: Pete Zaitcev <zaitcev@metabyte.com>
Message-Id: <200012062312.PAA27858@ns1.metabyte.com>
Subject: Re: YMF PCI - thanks, glitches, patches (fwd)
To: proski@gnu.org (Pavel Roskin)
Date: Wed, 6 Dec 2000 15:12:22 -0800 (PST)
Cc: zaitcev@metabyte.com (Pete Zaitcev), linux-kernel@vger.kernel.org,
        perex@suse.cz (Jaroslav Kysela)
In-Reply-To: <Pine.LNX.4.30.0012061423450.3758-101000@fonzie.nine.com> from "Pavel Roskin" at Dec 06, 2000 03:00:38 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 6 Dec 2000 15:00:38 -0500 (EST)
> From: Pavel Roskin <proski@gnu.org>
> To: Pete Zaitcev <zaitcev@metabyte.com>
> Subject: Re: YMF PCI - thanks, glitches, patches (fwd)

> > > Date: Wed, 6 Dec 2000 13:12:13 -0500 (EST)
> > > From: Pavel Roskin <proski@gnu.org>
> > > cc: Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@metabyte.com>,
> > >         <peter@cadcamlab.org>, <kai@thphy.uni-duesseldorf.de>
> >
> > > The native YMF PCI driver from Linux-2.4.0-test12-pre5 works on my card:
> >
> > I did not have a chance to look at whatever is in 2.4, but from
> > reading Linus's e-mails I understand that Jaroslav made a new
> > port, which is probably unrelated to the stuff that I hastily
> > cooked up for 2.2 (I really wanted to play Doom on my new Sony).
> 
> :-)))

I just found a message from Linus that says:

  The other change is that I forward-ported the ymfpci driver from 2.2.18,
  as it works better than the ALSA one on my now-to-be-main-laptop ;) 

(in http://boudicca.tux.org/hypermail/linux-kernel/2000week50/0200.html)

Now I know why error messages looked so familiar. :)
In other words, Jaroslav was not involved.

I'll see what Linus did and send him updates, if any.

> But please note that opl3 is not enabled by the new driver, so people do
> lose some functionality they used to have.

I'll try to understand what this is all about. Honestly,
I do not know how OPL3 works and who uses it (it's a MIDI
thing, isn't it?)

--Pete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
