Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSLZSri>; Thu, 26 Dec 2002 13:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSLZSri>; Thu, 26 Dec 2002 13:47:38 -0500
Received: from cpe-66-1-165-152.az.sprintbbd.net ([66.1.165.152]:14070 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262418AbSLZSrd>; Thu, 26 Dec 2002 13:47:33 -0500
Subject: Re: nforce2 and agpgart
From: "Carl D. Blake" <carl@boeckeler.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <037301c2aadf$4aea4050$6502a8c0@jeff>
References: <1040669417.4563.24.camel@vulcan>
	<1040678186.2237.4.camel@localhost.localdomain>
	<1040683214.4447.7.camel@vulcan>  <037301c2aadf$4aea4050$6502a8c0@jeff>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Dec 2002 11:55:46 -0700
Message-Id: <1040928946.6370.35.camel@vulcan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-23 at 16:59, Jeff Nguyen wrote:
> Carl,
> 
> Are you using the onboard IDE controller for your hard disk?
> If so, please check to see if DMA is enabled or not.
> 
> Jeff
> 

I am using the onboard IDE controller and DMA is enabled.

> ----- Original Message -----
> From: "Carl D. Blake" <carl@boeckeler.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Monday, December 23, 2002 2:40 PM
> Subject: Re: nforce2 and agpgart
> 
> 
> > On Mon, 2002-12-23 at 14:16, Bongani Hlope wrote:
> > > On Mon, 2002-12-23 at 20:50, Carl D. Blake wrote:
> > > > I'm having trouble getting agpgart support to work with an nforce2
> > > > chipset.  Is this supported on any kernels?  I'm running a Redhat 7.1
> > > > system with Redhat's 2.4.9-21 kernel.
> > >
> > > Try to use a newer kernel from Redhat, because that kernel was around
> > > looong before nforce was released. IIRC support for nforce2 was added
> > > around 2.4.19
> > >
> >
> > I just upgraded to the 2.4.18 kernel provided by Redhat and it didn't
> > make any difference.  The message I get in dmesg is:
> >
> > Linux agpgart interface v0.99 (c) Jeff Hartmann
> > agpgart: Maximum main memory to use for agp memory: 439M
> > agpgart: unsupported bridge
> > agpgart: no supported devices found.
> >
> > You suggested trying 2.4.19, so I downloaded kernel 2.4.20 from
> > kernel.org and compared its agp code (drivers/char/agp) with the code in
> > 2.4.18.  There are a few differences - such as supporting AMD 8151 - but
> > nothing that indicates improved support for agpgart on the nforce2
> > chipset.  The changelog for 2.4.20 indicated some added support for the
> > nforce2 chipset, but that seems to be support for the audio and network
> > portions of the chipset, not agp.  I was able to incorporate the audio
> > changes manually for kernel 2.4.18 by using Nvidia's patches, but I
> > can't get agp to work.
> >
> > Any other suggestions?  Thanks for your help.
> > > --
> > > For future reference - don't anybody else try to send patches as vi
> > > scripts, please. Yes, it's manly, but let's face it, so is
> > > bungee-jumping with the cord tied to your testicles.
> > >
> > >                 -- Linus
> > --
> > Carl D. Blake
> > Director of Engineering
> > Boeckeler Instruments, Inc.
> > 4650 S. Butterfield Dr.
> > Tucson, AZ  85714
> >
> > Phone: 520-745-0001
> > FAX: 520-745-0004
> > email: carl@boeckeler.com
> >
> > .com
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Carl D. Blake
Director of Engineering
Boeckeler Instruments, Inc.
4650 S. Butterfield Dr.
Tucson, AZ  85714

Phone: 520-745-0001
FAX: 520-745-0004
email: carl@boeckeler.com

.com

