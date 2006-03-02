Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWCBUdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWCBUdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbWCBUdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:33:25 -0500
Received: from xenotime.net ([66.160.160.81]:29880 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751611AbWCBUdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:33:24 -0500
Date: Thu, 2 Mar 2006 12:34:46 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: bunk@stusta.de, herbert@gondor.apana.org.au, dtor_core@ameritech.net,
       jgeorgas@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-Id: <20060302123446.89fc2c6d.rdunlap@xenotime.net>
In-Reply-To: <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com>
References: <20060301175852.GA4708@stusta.de>
	<E1FEcfG-000486-00@gondolin.me.apana.org.au>
	<20060302173840.GB9295@stusta.de>
	<9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006 21:28:15 +0100 Jesper Juhl wrote:

> On 3/2/06, Adrian Bunk <bunk@stusta.de> wrote:
> > On Thu, Mar 02, 2006 at 12:31:34PM +1100, Herbert Xu wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > > It does also matter in the kernel image size case, since you have to put
> > > > enough modules to the other medium for having a effect bigger than the
> > > > kernel image size increase from setting CONFIG_MODULES=y.
> > >
> > > That's not very difficult considering the large number of modules that's
> > > out there that a system may wish to use.
> > >...
> >
> > This might be true for full-blown desktop systems - but these do not
> > tend to be the systems where kernel image size matters that much.
> > Smaller kernel image size might be an issue e.g. for distribution
> > kernels, but in a much less pressing way.
> >
> > The systems where kernel image size really matters are systems with few
> > modules where you know in advance which modules you might need. I played
> > a bit with the ARM defconfigs, and if you consider that you can't build
> > the filesystem for accessing your modules modular I haven't found any
> > where making everything modular would have given a real kernel image
> > size gain compared to the CONFIG_MODULES=n case.
> >
> 
> I believe the basic question is this: What do we win by making
> CONFIG_UNIX a bool?
> 
> As it is now eople have the option of building it in, building a
> module or not build it at all - I don't see why that's a bad thing.
> For people who want a small core kernel (for whatever reason) and then
> load additional capabilities as modules, the current situation is
> good. If we remove the modular option who will bennefit?
> Why not just leave it as it is?

amen, agreed.

---
~Randy
