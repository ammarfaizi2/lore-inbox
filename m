Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286694AbRL1Ciq>; Thu, 27 Dec 2001 21:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286695AbRL1Cig>; Thu, 27 Dec 2001 21:38:36 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:33929
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S286694AbRL1CiU>; Thu, 27 Dec 2001 21:38:20 -0500
Message-ID: <008a01c18f48$beaa3e90$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20011219104253.A11032@kroah.com> <061101c18f35$5e141e60$6800000a@brownell.org>
Subject: Re: [linux-usb-devel] [PATCH] current state of the 2.5.1 USB tree
Date: Thu, 27 Dec 2001 19:38:34 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I would very much like to see EHCI support in a 2.4.x compatible form,
even if it's not in the mainline kernel. Last time I tried the CVS code, I
couldn't even get it compile, but maybe things have improved since then (two
months ago) :-)

I also have a USB 2.0 external hard drive that I'd sure like to see run at
something higher than 1 megabyte per second <G>

----- Original Message -----
From: "David Brownell" <david-b@pacbell.net>
To: "Greg KH" <greg@kroah.com>; <linux-usb-devel@lists.sourceforge.net>;
<linux-kernel@vger.kernel.org>
Sent: Thursday, December 27, 2001 4:22 PM
Subject: Re: [linux-usb-devel] [PATCH] current state of the 2.5.1 USB tree


> > A patch against a clean 2.5.1 tree is at:
> > http://www.kroah.com/linux/usb/linux-2.5.1-gregkh-1.patch.gz
> >
> > This patch contains 5 new USB drivers (stv680, vidcam, ipaq, kl5kusb105,
> > and the usb 2.0 ehci-hcd driver), documentation for all of these new
> > drivers, a rewrite of usbdevfs/usbfs, and lots of other smaller fixes
> > and changes.
>
> By the way -- if folk need to see EHCI (60 MByte/sec USB) on 2.4,
> drop a line.  The code is in CVS, and clearly most of that development
> was done on the 2.4 kernel.  A number of folk are using that code with
> success on those highspeed USB storage devices.
>
> But most of the USB 2.0 work will be done in the 2.5 tree, so that's
> going to be the place to watch!
>
> - Dave
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

