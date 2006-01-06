Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWAFSjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWAFSjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWAFSjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:39:46 -0500
Received: from xenotime.net ([66.160.160.81]:13790 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932388AbWAFSjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:39:45 -0500
Date: Fri, 6 Jan 2006 10:39:30 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
In-Reply-To: <9a8748490601061026t3e467dfdxc90b6403bbd45802@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0601061038130.11324@shark.he.net>
References: <20060106173547.GR12131@stusta.de> 
 <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com> 
 <20060106180626.GV12131@stusta.de> <9a8748490601061026t3e467dfdxc90b6403bbd45802@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Jesper Juhl wrote:

> On 1/6/06, Adrian Bunk <bunk@stusta.de> wrote:
> > On Fri, Jan 06, 2006 at 06:49:55PM +0100, Jesper Juhl wrote:
> > > On 1/6/06, Adrian Bunk <bunk@stusta.de> wrote:
> > > > Do not allow people to create configurations with CONFIG_BROKEN=y.
> > > >
> > > > The sole reason for CONFIG_BROKEN=y would be if you are working on
> > > > fixing a broken driver, but in this case editing the Kconfig file is
> > > > trivial.
> > > >
> > > > Never ever should a user enable CONFIG_BROKEN.
> > > >
> > > I disagree (slightly) with this patch for a few reasons:
> > >
> > > - It's very convenient to be able to enable it through menuconfig.
> >
> > And when do you really need it?
> >
> Hmm, when I'm looking for broken stuff to fix ;)
> I guess you are right, ordinary users don't need it.. Ok, count me in
> as supporting this move.

I'm having a little trouble determining why it matters.

Are you trying to cut down on lkml bug reports or just make
it harder on everyone?

-- 
~Randy
