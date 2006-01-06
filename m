Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWAFS6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWAFS6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbWAFS6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:58:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51725 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932417AbWAFS6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:58:18 -0500
Date: Fri, 6 Jan 2006 19:58:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Message-ID: <20060106185812.GZ12131@stusta.de>
References: <20060106173547.GR12131@stusta.de> <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com> <20060106180626.GV12131@stusta.de> <9a8748490601061026t3e467dfdxc90b6403bbd45802@mail.gmail.com> <Pine.LNX.4.58.0601061038130.11324@shark.he.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601061038130.11324@shark.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 10:39:30AM -0800, Randy.Dunlap wrote:
> On Fri, 6 Jan 2006, Jesper Juhl wrote:
> 
> > On 1/6/06, Adrian Bunk <bunk@stusta.de> wrote:
> > > On Fri, Jan 06, 2006 at 06:49:55PM +0100, Jesper Juhl wrote:
> > > > On 1/6/06, Adrian Bunk <bunk@stusta.de> wrote:
> > > > > Do not allow people to create configurations with CONFIG_BROKEN=y.
> > > > >
> > > > > The sole reason for CONFIG_BROKEN=y would be if you are working on
> > > > > fixing a broken driver, but in this case editing the Kconfig file is
> > > > > trivial.
> > > > >
> > > > > Never ever should a user enable CONFIG_BROKEN.
> > > > >
> > > > I disagree (slightly) with this patch for a few reasons:
> > > >
> > > > - It's very convenient to be able to enable it through menuconfig.
> > >
> > > And when do you really need it?
> > >
> > Hmm, when I'm looking for broken stuff to fix ;)
> > I guess you are right, ordinary users don't need it.. Ok, count me in
> > as supporting this move.
> 
> I'm having a little trouble determining why it matters.
> 
> Are you trying to cut down on lkml bug reports or just make
> it harder on everyone?

I'm trying to remove a small trap for users.

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

