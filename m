Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284711AbSAGSM2>; Mon, 7 Jan 2002 13:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284761AbSAGSMV>; Mon, 7 Jan 2002 13:12:21 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:528 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284728AbSAGSMK>; Mon, 7 Jan 2002 13:12:10 -0500
Date: Mon, 7 Jan 2002 16:10:38 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@ns.caldera.de>,
        Jaroslav Kysela <perex@suse.cz>, <sound-hackers@zabbo.net>,
        <linux-sound@vger.rutgers.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: ALSA patch for 2.5.2pre9 kernel
Message-ID: <20020107181038.GB1026@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@ns.caldera.de>,
	Jaroslav Kysela <perex@suse.cz>, <sound-hackers@zabbo.net>,
	<linux-sound@vger.rutgers.edu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E16Ndc4-0001sW-00@the-village.bc.nu> <Pine.LNX.4.33.0201070959430.6559-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201070959430.6559-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 07, 2002 at 10:00:57AM -0800, Linus Torvalds escreveu:
> 
> On Mon, 7 Jan 2002, Alan Cox wrote:
> > > Or we could just have a really _deep_ hierarchy, and put everything under
> > > "linux/drivers/sound/..", but I'd rather break cleanly with the old.
> >
> > Christoph has an interesting point. Networking is
> >
> > 	net/[protocol]/
> > 	drivers/net/[driver]
> >
> > so by that logic we'd have
> >
> > 	sound/soundcore.c
> > 	sound/alsa/alsalibcode
> > 	sound/oss/osscore
> >
> > 	sound/drivers/cardfoo.c
> >
> > which would also be much cleaner since the supporting crap would be seperate
> > from the card drivers
> 
> I would certainly not oppose that. Look sane to me, although the question
> then ends up being about "drivers/sound" or "sound/drivers" (the latter
> has the advantage that it keeps sound together, the former is more
> analogous to the "net" situation).

One ring^Wlayout to rule them all <stops here ;)> I would not be unhappy if
drivers/net became net/drivers, etc 8)

- Arnaldo
