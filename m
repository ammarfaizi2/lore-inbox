Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316423AbSEUH1s>; Tue, 21 May 2002 03:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316533AbSEUH1r>; Tue, 21 May 2002 03:27:47 -0400
Received: from kura.mail.jippii.net ([195.197.172.113]:57248 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S316423AbSEUH1r>; Tue, 21 May 2002 03:27:47 -0400
Date: Tue, 21 May 2002 10:30:33 +0300
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Planning on a new system
Message-ID: <20020521073033.GA20335@sci.fi>
In-Reply-To: <1021856882.1814.12.camel@tiger> <20020520192136.GC25125@artax.karlin.mff.cuni.cz> <20020520154244.2bfb882e.arodland@noln.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 03:42:44PM -0400, Andrew Rodland wrote:
> On Mon, 20 May 2002 21:21:36 +0200
> Jan Hudec <bulb@ucw.cz> wrote:
> 
> > On Sun, May 19, 2002 at 09:07:58PM -0400, Louis Garcia wrote:
> > > Graphics adapter 32MB NVIDIA ? GeForce2? MX200 AGP Graphics
> > 
> > AFAIK there some binary-only driver for this card, that causes trouble
> > time to time and as it's binary only, no one can debug them.
> > I am not sure what really requres the driver, that is how much X can
> > do without it.
> 
> You get 2d, semi-accelerated (that is, XAA only) graphics, at whatever
> resolution you want, with X's "nv" driver.
 
What's full-accelerated 2d then?

> Installing the NVidia kernel stuff + other libraries gets you better
> acceleration on X, Render, Xv, and of course hardware-accelerated GLX.

The "nv" driver in X (since 4.1.0) has Xv also, for apparently all
Geforce 2 and 3 chips. In my experience it's fine for running my desktop
at 1600x1200x32 and also for watching videos using Xv support.
