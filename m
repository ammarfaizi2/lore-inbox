Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310750AbSCMQXx>; Wed, 13 Mar 2002 11:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310745AbSCMQXp>; Wed, 13 Mar 2002 11:23:45 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:5239 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S310743AbSCMQXi>; Wed, 13 Mar 2002 11:23:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: John Schmerge <schmerge@speakeasy.net>
Subject: Re: Oops/Crash with 2.4.17 and 2.4.18 kernels
Date: Wed, 13 Mar 2002 17:23:13 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0203121005060.13438-100000@grace.speakeasy.net>
In-Reply-To: <Pine.LNX.4.44.0203121005060.13438-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020313162314.6623B843@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 12. March 2002 19:05, John Schmerge wrote:
> Thanks for the insight... It turns out that you're conjecture seems to be
> correct. Boy, I feel like a n00b... I had run memtest86 after first
> noticing these problems and everything seemed ok, but after a good long run
> last night, I started to see the failures. Sigh. Looks like i have either a
> bad mobo or a bad processor.
>
> Thanks again,
> John

Power supply problems are also very common these days...

Cheers,
  Hans-Peter

> On Mon, 11 Mar 2002, Andrew Morton wrote:
> > John Schmerge wrote:
> > > ...
> > >   Asus CUV4X-D motherboard
> > >   2 x Pentium III 1.0 ghz processors
> > >   1024 Mb ram (4x256mb)
> > >   IBM Deskstar 40gb ata100 disk
> > >   Radeon QD AGP card
> > >   Realtek 8139 pci NIC
> > >
> > > ...
> > > Mar  9 03:46:07 voltaire kernel: Unable to handle kernel paging request
> > > at virtual address 04000004
> >
> > Single-bit error.  Kernel expected either a valid address or a null
> > pointer, but bit 26 was set.
> >
> > You should run memtest86 for 24 hours, and be suspicious of your
> > shiny new hardware :(
> >
> > -
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
