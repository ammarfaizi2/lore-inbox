Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287585AbSAHCxX>; Mon, 7 Jan 2002 21:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287579AbSAHCxO>; Mon, 7 Jan 2002 21:53:14 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:18697 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287585AbSAHCxF>; Mon, 7 Jan 2002 21:53:05 -0500
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
From: Miles Lane <miles@megapathdsl.net>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Abramo Bagnara <abramo@alsa-project.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Jaroslav Kysela <perex@suse.cz>,
        sound-hackers@zabbo.net, linux-sound@vger.rutgers.edu,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <200201072125.g07LPgE02318@ns.caldera.de>
In-Reply-To: <200201072125.g07LPgE02318@ns.caldera.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 07 Jan 2002 18:53:03 -0800
Message-Id: <1010458384.27296.28.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-07 at 13:25, Christoph Hellwig wrote:
> In article <3C39E6A0.34A88990@alsa-project.org> you wrote:
> > If you want to keep top level cleaner and avoid proliferation of entries
> > we might have:
> >
> > subsys/sound
> > subsys/sound/drivers
> > subsys/net
> > subsys/net/drivers
> 
> And what part of the kernel is no subsystem?
> Your subsystem directory is superflous.

Change subsys/ to some name that means "not device-specific".  
The point is that the net and sound system-level stuff isn't 
composed of device-specific drivers and the other directories 
below linux/ do not have a bunch of device-specific drivers 
associated with them (kernel, fs and mm).

> If, for some reason, we want to move all code in the kernel around
> we should do it once and in a planned manner.

Maybe a better structure is needed, but moving /net alone 
would be a big project.

	Miles

