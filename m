Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUBHBjN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUBHBjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:39:13 -0500
Received: from mail.bluebottle.com ([69.20.6.25]:14475 "EHLO
	www.bluebottle.com") by vger.kernel.org with ESMTP id S261875AbUBHBjL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:39:11 -0500
Date: Sat, 7 Feb 2004 23:39:02 -0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: devfs 199.17 not in 2.4 (was Re:2.4.22 devfs/zlib outstanding
 updates ...)
In-Reply-To: <Pine.LNX.4.58L.0402072044040.29406@logos.cnet>
Message-ID: <Pine.CYG.4.58.0402072320530.1032@pervalidus>
References: <Pine.LNX.4.58.0401280110530.949@pervalidus.dyndns.org>
 <Pine.LNX.4.58L.0402072044040.29406@logos.cnet>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004, Marcelo Tosatti wrote:

> On Wed, 28 Jan 2004, Frédéric L. W. Meunier wrote:
>
> > Herbert Pötzl wrote on Sat, 12 Jul 2003 00:22:07 +0200
> >
> > > just wanted to remind/state that the final? v199.17 devfs
> > > patch and the 1.1.4 zlib update are not in 2.4.22-pre5.
> >
> > About the devfs patch.
> >
> > Yes, I already reported it a long time ago -
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0306.2/1655.html
> > and have no idea why it hasn't been merged in 2.4, after all
> > it's supposed to fix some things and there have been no changes
> > since then in the kernel.
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103474534430016&w=2
> >
> > Can someone clarify this ? I've been applying this patch since
> > its release and it didn't broke anything.
>
> Oi Frederic,
>
> Richard Gooch used to send me updates a long time ago.
>
> What are the bugs this new releases are fixing?

E aí Marcelo.

It isn't a new release, really. It's his last patch, released
16 October 2002. All earlier were merged.

I don't know what it fixes besides what's listed at
http://marc.theaimsgroup.com/?l=linux-kernel&m=103474534430016&w=2
. Probably that's all.

He's the expert, but I recall he told me there were important
fixes, and I've been using it since then without any noticeable
problems on all later 2.4 kernels. It only changes code in
fs/devfs/base.c and include/linux/devfs_fs_kernel.h.

I'm just surprised it never made into. Maybe Al Viro or Andrey
Borzenkov will want to review it :-)

And Andrey (he's cleaning up devfs in 2.6) may be able to tell
you if
http://www.cs.helsinki.fi/linux/linux-kernel/2003-25/0100.html
is still needed.

-- 
How to contact me - http://www.pervalidus.net/contact.html
