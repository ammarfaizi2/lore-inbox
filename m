Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVHDMr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVHDMr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVHDMro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:47:44 -0400
Received: from mx5.mailserveren.com ([213.236.237.251]:5556 "EHLO
	mx5.mailserveren.com") by vger.kernel.org with ESMTP
	id S262509AbVHDMpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:45:31 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Hans Kristian Rosbach <hans.kristian@isphuset.no>
To: dtor_core@ameritech.net
Cc: James Bruce <bruce@andrew.cmu.edu>, "Theodore Ts'o" <tytso@mit.edu>,
       David Weinehall <tao@acc.umu.se>, Lee Revell <rlrevell@joe-job.com>,
       Pavel Machek <pavel@ucw.cz>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <d120d50005080306575372d990@mail.gmail.com>
References: <20050730195116.GB9188@elf.ucw.cz>
	 <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu>
	 <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe>
	 <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>
	 <20050801204245.GC17258@thunk.org>
	 <d120d50005080306575372d990@mail.gmail.com>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Date: Thu, 04 Aug 2005 14:52:05 +0200
Message-Id: <1123159925.15719.1.camel@linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 08:57 -0500, Dmitry Torokhov wrote:
> On 8/3/05, Hans Kristian Rosbach <hans.kristian@isphuset.no> wrote:
> > On Tue, 2005-08-02 at 00:50 -0400, James Bruce wrote:
> > > Theodore Ts'o wrote:
> > >  > On Mon, Aug 01, 2005 at 12:18:18PM -0400, James Bruce wrote:
> > >  >>The tradeoff is a realistic 4.4% power savings vs a 300% increase in
> > >  >>the minimum sleep period.  A user will see zero power savings if they
> > >  >>have a USB mouse (probably 99% of desktops).  On top of that, we can
> > >                                      ^^^^^^^^
> > >
> > >  > Most laptops (including mine, a Thinkpad T40) use a PS/2 mouse.  So in
> > >  > the places where power consumption savins matters most, it's usually
> > >  > quite possible to function without needing any USB devices.  The 90%
> > >  > figure isn't at all right; in fact, it may be that over 90% of the
> > >  > laptops still use PS/2 mice and keyboards.
> > >
> > > Yes, laptops are mostly PS/2, which is why I only claimed a statistic
> > > for desktops.  Desktops pretty much all use USB mice now.  If 250Hz were
> > > only being sold as an option for laptops, we could leave it at that, yet
> > > its being pushed as a default that's "good for everyone".  For desktops
> > > this is not currently true at all.  By the time USB is fixed to do power
> > > saving, we'll probably have a working tick-skipping patch which makes
> > > the whole HZ argument moot.
> > 
> > Most new laptops are moving away from PS/2 ports, for example my
> > shining (literally) new Acer Ferrari 4005 only has USB2 ports for mice
> > and keyboard inputs (unless in the optional pcie docking station maybe).
> > So my suggestion would be to fix USB power management.
> >
> 
> You are talking about external ports. I am pretty sure that installed
> keyboard and touchpad (or whattever pointing device it has) are plain
> old PS/2.

Well, yes..

But as I _never_ use the touchpad, it is quite necessary to keep USB
enabled for me at any time as an external PS2 mouse is not possible.

-HK

