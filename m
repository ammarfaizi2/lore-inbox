Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRCBNbq>; Fri, 2 Mar 2001 08:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRCBNbf>; Fri, 2 Mar 2001 08:31:35 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48574 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129146AbRCBNbX>;
	Fri, 2 Mar 2001 08:31:23 -0500
Message-ID: <3A9FA0AA.9E4A5CAB@mandrakesoft.com>
Date: Fri, 02 Mar 2001 08:31:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-4mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
Cc: whitney@math.berkeley.edu, LKML <linux-kernel@vger.kernel.org>
Subject: Re: via 686a audio driver rate locked at 48Khz
In-Reply-To: <Pine.LNX.4.31.0103021419461.3806-100000@fb07-calculator.math.uni-giessen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Haller wrote:
> 
> On Wed, 28 Feb 2001, Jeff Garzik wrote:
> 
> > Wayne Whitney wrote:
> > > I have a system with an MSI-6321 motherboard with the Via 686a
> > > southbridge, and I'm having a little trouble with the via82cxxx_audio
> > > sound driver.  The stock 2.4.2 driver produces only a rhythmic a buzzing
> > > sound.  I saw a patch here a week or two ago for 'rate locking', so I
> > > tried that (it didn't apply cleanly to 2.4.2, but I think I applied it by
> > > hand correctly).
> >
> > FYI I sent that change to Linus just now, and posted a quick update on
> > the Web site:  http://sourceforge.net/projects/gkernel/
> 
> with this 1.1.14b I still can't cat wav files to /dev/dsp but
> the aRts deamon (from kde2.0.1) works if I set it to 48000Hz

Unless the wav file is at 48000 Hz and you set the rate to 48000 Hz,
that's correct.  You'll need arts or esd or a sound app that supports
locked rates.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
