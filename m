Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbQKIEDA>; Wed, 8 Nov 2000 23:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129766AbQKIECv>; Wed, 8 Nov 2000 23:02:51 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21774 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129764AbQKIECk>;
	Wed, 8 Nov 2000 23:02:40 -0500
Message-ID: <3A0A21BE.8934BEE1@mandrakesoft.com>
Date: Wed, 08 Nov 2000 23:02:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] media/radio [check_region() removal... ]
In-Reply-To: <Pine.LNX.4.21.0011090124350.23238-100000@tricky>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 
> On Wed, 8 Nov 2000, Jeff Garzik wrote:
> 
> > Patch looks generally ok.  Some of the whitespace/formatting changes are
> > questionable, I usually leave that up to the maintainer unless it is
> > very gratuitously opposite to CodingStyle.
> >
> 
> These drivers seem to be unmantained :)
> Anyway if this is a problem I can undo these changes ...

I don't have any problem with them.  Make sure you CC the individual
maintainers of the drivers...  some of the pop up every now and then :)


> > Some of the driver messages ("foo version 1.0") are purposefully printed
> > -after-, not before, the device is probed and registered.  Your patch
> > gets this wrong in at least one place.
> >
> 
> Yes... I wasn't sure about this... can undo...

When in doubt, follow the behavior of the existing driver.  :) 
Especially since we're in a freeze, and stuff...

-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
