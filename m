Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264941AbRFZNkc>; Tue, 26 Jun 2001 09:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbRFZNkW>; Tue, 26 Jun 2001 09:40:22 -0400
Received: from hinako.ambusiness.com ([64.59.51.7]:17168 "EHLO
	Hinako.AMBusiness.com") by vger.kernel.org with ESMTP
	id <S264941AbRFZNkP>; Tue, 26 Jun 2001 09:40:15 -0400
Message-ID: <008d01c0fe43$7cc875f0$9865fea9@optima>
From: "Anthony Barbachan" <barbacha@Hinako.AMBusiness.com>
To: "Christoph Hellwig" <hch@ns.caldera.de>,
        "Horst von Brand" <vonbrand@sleipnir.valparaiso.cl>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200106251553.f5PFr0v17268@ns.caldera.de>
Subject: Re: Making a module 2.4 compatible
Date: Tue, 26 Jun 2001 09:25:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Christoph Hellwig" <hch@ns.caldera.de>
To: "Horst von Brand" <vonbrand@sleipnir.valparaiso.cl>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, June 25, 2001 11:53 AM
Subject: Re: Making a module 2.4 compatible


> Hi Horst,
>
> In article <200106241713.f5OHDItV000540@sleipnir.valparaiso.cl> you wrote:
> > Seconded! There are a few users of iBCS around here, who _need_ the
> > functionality and don't get it with 2.4.x (in this case, Red Hat 7.1).
Or
> > is there a replacement for it?
>
> Take a look at inux-abi:
>
>   http://linux-abi.sourceforge.net
>   ftp://ftp.openlinux.org/pub/people/hch/linux-abi

    I've tried linux-abi myself.  No luck at all.  Best I can tell it has
yet to reach the level of compatibility that iBCS has.  Although last
version I tried was the 2.4.3 patch on the linux abi web site.  I noticed a
newer one on the openlinux ftp site, might give that one a try too though
considering what happened with the one I previously tried I am nowhere near
optimistic.  Unfortunately this has burned me since I need to setup a new
system that uses the new features of the 2.4.x kernels (latest rieserfs,
better smp, support for the latest ide chipsets, better scaling) which also
can run SCO binaries.  I am actually at the point where I am strongly
considering trying to port iBCS myself though not sure about it yet mainly
due to concerns that I may not implement it correctly to work with some of
the latest kernel changes without understanding how the original iBCS was
designed.

    By the way is there a reason there isn't a patch to support the latest
available for the 2.2.x kernels?  Is it incompatible with the 2.2.x kernels?
I recently needed to downgrade the kernel on a machine due to 2.4.x
instability but was unable to due to the lack of a patch to support the
latest rieserfs on 2.2.x.

