Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132542AbRAYXLP>; Thu, 25 Jan 2001 18:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132304AbRAYXLF>; Thu, 25 Jan 2001 18:11:05 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:33551 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129393AbRAYXKx>; Thu, 25 Jan 2001 18:10:53 -0500
Message-ID: <3A70B26C.16DC1C29@transmeta.com>
Date: Thu, 25 Jan 2001 15:10:36 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <Pine.LNX.3.95.1010125180648.24692A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 25 Jan 2001, H. Peter Anvin wrote:
> 
> > Matthew Dharm wrote:
> > >
> > > It occurs to me that it might be a good idea to pick a different port for
> > > these things.  I know a lot of people who want to use port 80h for
> > > debugging data, especially in embedded x86 systems.
> > >
> >
> > Find a safe port, make sure it is tested the hell out of, and we'll
> > consider it.
> >
> >       -hpa
> >
> 
> You could use the DMA scratch register at 0x19. I'm sure Linux doesn't
> "save" stuff there when setting up the DMA controller.
> 

Does that break the BIOS in any way, shape, or form?  Again, someone gets
to make a patch and then test the hell out of it... and find the random
Olivetti which hooks the screen up to the A20M# signal and other weird
crap.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
