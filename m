Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129508AbQKRSQG>; Sat, 18 Nov 2000 13:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQKRSPs>; Sat, 18 Nov 2000 13:15:48 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:19465 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129508AbQKRSPq>;
	Sat, 18 Nov 2000 13:15:46 -0500
Message-ID: <3A16C01C.8421220A@mandrakesoft.com>
Date: Sat, 18 Nov 2000 12:45:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: EXPORT_NO_SYMBOLS vs. (null) ?
In-Reply-To: <200011181740.SAA14504@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> Alan Cox wrote:
> > > What is the difference between a module that exports no symbols and
> > > includes EXPORT_NO_SYMBOLS reference, and such a module that lacks
> > > EXPORT_NO_SYMBOLS?
> > >
> > > Alan once upbraided me for assuming they were the same :)
> >
> > EXPORT_NO_SYMBOLS             -       nothing exported
> > MODULE_foo                    -       export specific symbol
> >
> > none of the above, export all globals but without modvers
>                                 ^^^^^^^ and statics!!!!
> 
> I consider that a bug, but...

eh?  Can you give an example of this?  This should definitely -not- be
the case.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
