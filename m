Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131259AbQKUV0t>; Tue, 21 Nov 2000 16:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbQKUV0k>; Tue, 21 Nov 2000 16:26:40 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:2308 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131259AbQKUV0W>; Tue, 21 Nov 2000 16:26:22 -0500
Date: Tue, 21 Nov 2000 20:56:08 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: Hakan Lennestal <hakanl@cdt.luth.se>,
        Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0, test10, test11: HPT366 problem 
In-Reply-To: <Pine.LNX.4.10.10011211033180.26689-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0011212053540.1029-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Andre Hedrick wrote:
>
> Does that fix it?

WorksForMe(tm)

Grrr. I specifically went and read the HPT366 blacklist before buying my
shiny new hard drive.

> On Tue, 21 Nov 2000, David Woodhouse wrote:
> > Index: drivers/ide/hpt366.c
> > ===================================================================
> > RCS file: /inst/cvs/linux/drivers/ide/Attic/hpt366.c,v
> > retrieving revision 1.1.2.10
> > diff -u -r1.1.2.10 hpt366.c
> > --- drivers/ide/hpt366.c	2000/11/10 14:56:31	1.1.2.10
> > +++ drivers/ide/hpt366.c	2000/11/21 13:27:32
> > @@ -55,6 +55,8 @@
> >  };
> >
> >  const char *bad_ata66_4[] = {
> > +	"IBM-DTLA-307045",
> > +	"IBM-DTLA-307030",
> >  	"WDC AC310200R",
> >  	NULL
> >  };

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
