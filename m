Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRCBN0O>; Fri, 2 Mar 2001 08:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbRCBN0E>; Fri, 2 Mar 2001 08:26:04 -0500
Received: from hermes.hrz.uni-giessen.de ([134.176.2.15]:38293 "EHLO
	hermes.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id <S129134AbRCBNZx>; Fri, 2 Mar 2001 08:25:53 -0500
Date: Fri, 2 Mar 2001 14:25:45 +0100 (CET)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: <gc1007@fb07-calculator.math.uni-giessen.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <whitney@math.berkeley.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: via 686a audio driver rate locked at 48Khz
In-Reply-To: <3A9D8779.BC475CFC@mandrakesoft.com>
Message-Id: <Pine.LNX.4.31.0103021419461.3806-100000@fb07-calculator.math.uni-giessen.de>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Jeff Garzik wrote:

> Wayne Whitney wrote:
> > I have a system with an MSI-6321 motherboard with the Via 686a
> > southbridge, and I'm having a little trouble with the via82cxxx_audio
> > sound driver.  The stock 2.4.2 driver produces only a rhythmic a buzzing
> > sound.  I saw a patch here a week or two ago for 'rate locking', so I
> > tried that (it didn't apply cleanly to 2.4.2, but I think I applied it by
> > hand correctly).
>
> FYI I sent that change to Linus just now, and posted a quick update on
> the Web site:  http://sourceforge.net/projects/gkernel/

with this 1.1.14b I still can't cat wav files to /dev/dsp but
the aRts deamon (from kde2.0.1) works if I set it to 48000Hz

> > That patch makes some things work fine (e.g. playing a .wav file), but
> > others sound lousy (e.g. playing a 44.1KHz mp3 with xmms).  Am I correct
> > in thinking that it sounds lousy because of the translation from 44.1KHz
> > sampling to 48KHz sampling?

xmms is playing also using the aRts output plugin.


c ya
        Sergei

--------------------------------------------------------------------
         eMail:       Sergei.Haller@math.uni-giessen.de
--------------------------------------------------------------------
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain

