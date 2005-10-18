Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbVJRGkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVJRGkX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVJRGkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:40:23 -0400
Received: from styx.suse.cz ([82.119.242.94]:42720 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751440AbVJRGkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:40:22 -0400
Date: Tue, 18 Oct 2005 08:39:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Andrew Morton <akpm@osdl.org>, Brice Goglin <Brice.Goglin@ens-lyon.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-rc4-mm1
Message-ID: <20051018063941.GA7104@midnight.suse.cz>
References: <20051016154108.25735ee3.akpm@osdl.org> <43539762.2020706@ens-lyon.org> <20051017132242.2b872b08.akpm@osdl.org> <20051017212721.GA8997@midnight.suse.cz> <d120d5000510171439l556be0d7sccb7f3c0e65d07bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d120d5000510171439l556be0d7sccb7f3c0e65d07bd@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 04:39:52PM -0500, Dmitry Torokhov wrote:
> On 10/17/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Mon, Oct 17, 2005 at 01:22:42PM -0700, Andrew Morton wrote:
> > > Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> > > >
> > > > Le 17.10.2005 00:41, Andrew Morton a écrit :
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
> > > > >
> > > > > - Lots of i2c, PCI and USB updates
> > > > >
> > > > > - Large input layer update to convert it all to dynamic input_dev allocation
> > > > >
> > > > > - Significant x86_64 updates
> > > > >
> > > > > - MD updates
> > > > >
> > > > > - Lots of core memory management scalability rework
> > > >
> > > > Hi Andrew,
> > > >
> > > > I got the following oops during the boot on my laptop (Compaq Evo N600c).
> > > > .config is attached.
> > > >
> > > > Regards,
> > > > Brice
> >
> > Where did get support for IBM TrackPoints into that kernel? It's
> > certainly not in 2.6.14, and it's not in the -mm patch either ...
> >
> 
> Yes it is. We merged it at the beginning of 2.6.14.. ;)

Ahh, sorry. I've seen it cause trouble so many times before I forgot we
actually did merge it.

> > That's likely the cause here, since the TP patch probably relies on
> > non-dynamic allocation semantics.
> >
> 
> It was converted but I am aftraid when Greg created sub-class devices
> something broke a bit. Do you see the ugly names input core prints?
> 
> --
> Dmitry
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
