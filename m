Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135360AbRA0Usa>; Sat, 27 Jan 2001 15:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135488AbRA0UsU>; Sat, 27 Jan 2001 15:48:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4613 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135360AbRA0UsN>; Sat, 27 Jan 2001 15:48:13 -0500
Message-ID: <3A7333FF.AA813685@transmeta.com>
Date: Sat, 27 Jan 2001 12:47:59 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <200101271020.LAA22568@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> H. Peter Anvin wrote:
> > Followup to:  <3A709E99.25ADE5F6@echostar.com>
> > By author:    "Ian S. Nelson" <ian.nelson@echostar.com>
> > In newsgroup: linux.dev.kernel
> > >
> > > I'm curious.  Why does Linux make that friendly 98/9a/88 looking
> > > postcode pattern when it's running?  DOS and DOS95 don't do that.
> > >
> > > I'm begining to feel like I can tell the system health by observing it,
> > > kind of like "seeing the matrix."
> 
> > It output garbage to the 80h port in order to enforce I/O delays.
> > It's one of the safe ports to issue outs to.
> 
> Yes, because it is reserved for POST codes. You can get "POST
> debugging cards" that simply have a BIN -> 7segement encoder and two 7
> segment displays on them. They decode 0x80. That's what it's for.
> 

Again, if you want to change it, find another safe port, test the hell
out of it, an *PUBLICIZE IT* so noone will use it in the future.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
