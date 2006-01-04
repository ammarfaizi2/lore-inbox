Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWADRRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWADRRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWADRRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:17:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9481 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932553AbWADRRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:17:11 -0500
Date: Wed, 4 Jan 2006 18:17:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] i386: enable 4k stacks by default
Message-ID: <20060104171710.GQ3831@stusta.de>
References: <20060104145138.GN3831@stusta.de> <9a8748490601040839s58a0a26en454f54459006077c@mail.gmail.com> <20060104164445.GO3831@stusta.de> <9a8748490601040849l5e144f18s381854dd7f5f6e6b@mail.gmail.com> <20060104165835.GP3831@stusta.de> <9a8748490601040910q50655fc1sbdef48c8bd3d02d4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601040910q50655fc1sbdef48c8bd3d02d4@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 06:10:45PM +0100, Jesper Juhl wrote:
> On 1/4/06, Adrian Bunk <bunk@stusta.de> wrote:
> > On Wed, Jan 04, 2006 at 05:49:25PM +0100, Jesper Juhl wrote:
> > > To get maximum testing making 4KSTACKS default Y and removing the "if
> > > DEBUG_KERNEL" conditional just seems to me to be the obvious choice...
> >
> > With my version, we are getting the bigger testing coverage - and
> > getting a big testing coverage in -mm is what we need if we want to know
> > whether we have really already fixed all stack problems or whether
> > there are any left.
> >
> Ok, I guess I didn't make myself as clear as I thought.
> What I meant was that if 4K stacks are always enabled by default, then
> you'll get more testing than if only people who enable DEBUG_KERNEL
> are able to turn it on.
>...

This is not what my patch does.

Please apply my patch, use DEBUG_KERNEL=n and you'll understand it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

