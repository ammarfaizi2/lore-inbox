Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143953AbRAHPlG>; Mon, 8 Jan 2001 10:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143779AbRAHPk5>; Mon, 8 Jan 2001 10:40:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46481 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S143953AbRAHPkq>; Mon, 8 Jan 2001 10:40:46 -0500
Message-ID: <3A59DD1F.E1CB0B0F@videotron.ca>
Date: Mon, 08 Jan 2001 10:30:39 -0500
From: Martin Laberge <mlsoft@videotron.ca>
Organization: MLSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 - sndstat not present
In-Reply-To: <200101081518.QAA01381@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> In article <3A59CD57.6FA72934@videotron.ca> you wrote:
> > i installed 2.4.0 last week and all worked well on my amd-K6-350
> > i use a cheap sound card since 2.0.36 and it always worked well too.
> > it work well now in 2.4.0, BUT , /dev/sndstat report me <no such file or
> > directory>
> > and /proc/sound (as noted in documentation) does not exist...
>
> Please read Documentation/sound/NEWS.
> Where in the documentation is /proc/sound still noted?
>
> > the sound work well, but i cant verify the existence of the driver with
> > sndstat anymore
> >
> > could someone tell me if i should have done some additionnal
> > configuration to see
> > appear the /proc/sound or to enable /dev/sndstat...
>
> No - it's simply gone.
>
> > maybe is it another method now in 2.4 to see the sound status...
>
> cat foo.au > /dev/audio
>
> > Best Wishes to all of you for the new year...
>
>         Christoph
>
> --
> Whip me.  Beat me.  Make me maintain AIX.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

the reference to sndstat and /proc/sound was found in

drivers/sound/soundcard.c

thanks for your lights on this topic...

is there nothing i can use anymore to check existence of sound drivers
in kernel...

these informations were very valuables when i was configuring my cards
for the first time... sometimes the driver loaded but do not appeared in
sndstat
then i was able to change my configuration according to what i see in
sndstat...

now i just guess and try to play something...

hummmmm (((((

Martin Laberge
mlsoft@videotron.ca


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
