Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290748AbSARQtV>; Fri, 18 Jan 2002 11:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290745AbSARQtH>; Fri, 18 Jan 2002 11:49:07 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:59915 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290750AbSARQsN>;
	Fri, 18 Jan 2002 11:48:13 -0500
Date: Mon, 14 Jan 2002 03:10:29 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Abramo Bagnara <abramo@alsa-project.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@ns.caldera.de>, Jaroslav Kysela <perex@suse.cz>,
        sound-hackers@zabbo.net, linux-sound@vger.rutgers.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
Message-ID: <20020114031029.D2157@toy.ucw.cz>
In-Reply-To: <3C39EB68.BC8C804@alsa-project.org> <Pine.LNX.4.33.0201071044260.6694-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0201071044260.6694-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 07, 2002 at 10:47:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Just to resume, you think that the way to go is:
> >
> > 1) to have sound/ with *all* sound related stuff inside
> > 2) to leave drivers/net/ and net/ like they are now (because although
> > it's suboptimal, to change it is a mess we don't want to face now)
> 
> This is my current feeling.
> 
> However, la donna é mobile, and I'm a primus donna, fer shure. So don't
> take it _too_ seriously, continue to argue the merits of other approaches.

Where does USB soundcard go, then? It should be in drivers/usb by current
standards... Having sound drivers both inside and outside drivers/ seems
ugly to me.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

