Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267014AbSLWX5c>; Mon, 23 Dec 2002 18:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267015AbSLWX5c>; Mon, 23 Dec 2002 18:57:32 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:17136
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S267014AbSLWX5b>; Mon, 23 Dec 2002 18:57:31 -0500
Message-ID: <037301c2aadf$4aea4050$6502a8c0@jeff>
From: "Jeff Nguyen" <jeff@aslab.com>
To: "Carl D. Blake" <carl@boeckeler.com>, <linux-kernel@vger.kernel.org>
References: <1040669417.4563.24.camel@vulcan> <1040678186.2237.4.camel@localhost.localdomain> <1040683214.4447.7.camel@vulcan>
Subject: Re: nforce2 and agpgart
Date: Mon, 23 Dec 2002 15:59:12 -0800
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

Carl,

Are you using the onboard IDE controller for your hard disk?
If so, please check to see if DMA is enabled or not.

Jeff

----- Original Message -----
From: "Carl D. Blake" <carl@boeckeler.com>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, December 23, 2002 2:40 PM
Subject: Re: nforce2 and agpgart


> On Mon, 2002-12-23 at 14:16, Bongani Hlope wrote:
> > On Mon, 2002-12-23 at 20:50, Carl D. Blake wrote:
> > > I'm having trouble getting agpgart support to work with an nforce2
> > > chipset.  Is this supported on any kernels?  I'm running a Redhat 7.1
> > > system with Redhat's 2.4.9-21 kernel.
> >
> > Try to use a newer kernel from Redhat, because that kernel was around
> > looong before nforce was released. IIRC support for nforce2 was added
> > around 2.4.19
> >
>
> I just upgraded to the 2.4.18 kernel provided by Redhat and it didn't
> make any difference.  The message I get in dmesg is:
>
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: unsupported bridge
> agpgart: no supported devices found.
>
> You suggested trying 2.4.19, so I downloaded kernel 2.4.20 from
> kernel.org and compared its agp code (drivers/char/agp) with the code in
> 2.4.18.  There are a few differences - such as supporting AMD 8151 - but
> nothing that indicates improved support for agpgart on the nforce2
> chipset.  The changelog for 2.4.20 indicated some added support for the
> nforce2 chipset, but that seems to be support for the audio and network
> portions of the chipset, not agp.  I was able to incorporate the audio
> changes manually for kernel 2.4.18 by using Nvidia's patches, but I
> can't get agp to work.
>
> Any other suggestions?  Thanks for your help.
> > --
> > For future reference - don't anybody else try to send patches as vi
> > scripts, please. Yes, it's manly, but let's face it, so is
> > bungee-jumping with the cord tied to your testicles.
> >
> >                 -- Linus
> --
> Carl D. Blake
> Director of Engineering
> Boeckeler Instruments, Inc.
> 4650 S. Butterfield Dr.
> Tucson, AZ  85714
>
> Phone: 520-745-0001
> FAX: 520-745-0004
> email: carl@boeckeler.com
>
> .com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

