Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbSAGTXJ>; Mon, 7 Jan 2002 14:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285484AbSAGTXB>; Mon, 7 Jan 2002 14:23:01 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:51191 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S285424AbSAGTWp> convert rfc822-to-8bit;
	Mon, 7 Jan 2002 14:22:45 -0500
Date: Mon, 7 Jan 2002 20:21:57 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Abramo Bagnara <abramo@alsa-project.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@ns.caldera.de>, Jaroslav Kysela <perex@suse.cz>,
        <sound-hackers@zabbo.net>, <linux-sound@vger.rutgers.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <Pine.LNX.4.33.0201071044260.6694-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.30.0201072016390.18386-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 7 Jan 2002, Abramo Bagnara wrote:
> >
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


Well, I do think that doing a cleanup sooner is better than later as it
always gets bigger and bigger pain (both the change and keeping up the old
situation), so I would suggest to agree on a clear and consistent dirtree
now, and make that change whatever it is.

Though this is really not a big issue, it's still a great moment for this
kind of change imho.

-- 
Balazs Pozsar

