Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWADV4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWADV4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWADV4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:56:55 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:29513 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030243AbWADV4y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:56:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C9wocVHZ5gYAB06FUvoXLnrc40qAUQ/bp6kYsrbAR3Q8ksjG1yWjvLY12PxeLCPZEwSrdY9aiSB8Ev22JYNuR3zishMLYwNy1a31EDLQs6nyhIZaDHi4CpTjAyHIRQ5cVa2jAHeNBNeVauUtcnda8QYOk/1UmUA5K4ntfxZGW/4=
Message-ID: <9a8748490601041356p7a98428qd904fd19af7cf12d@mail.gmail.com>
Date: Wed, 4 Jan 2006 22:56:53 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] i386: enable 4k stacks by default
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060104171710.GQ3831@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060104145138.GN3831@stusta.de>
	 <9a8748490601040839s58a0a26en454f54459006077c@mail.gmail.com>
	 <20060104164445.GO3831@stusta.de>
	 <9a8748490601040849l5e144f18s381854dd7f5f6e6b@mail.gmail.com>
	 <20060104165835.GP3831@stusta.de>
	 <9a8748490601040910q50655fc1sbdef48c8bd3d02d4@mail.gmail.com>
	 <20060104171710.GQ3831@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Wed, Jan 04, 2006 at 06:10:45PM +0100, Jesper Juhl wrote:
> > On 1/4/06, Adrian Bunk <bunk@stusta.de> wrote:
> > > On Wed, Jan 04, 2006 at 05:49:25PM +0100, Jesper Juhl wrote:
> > > > To get maximum testing making 4KSTACKS default Y and removing the "if
> > > > DEBUG_KERNEL" conditional just seems to me to be the obvious choice...
> > >
> > > With my version, we are getting the bigger testing coverage - and
> > > getting a big testing coverage in -mm is what we need if we want to know
> > > whether we have really already fixed all stack problems or whether
> > > there are any left.
> > >
> > Ok, I guess I didn't make myself as clear as I thought.
> > What I meant was that if 4K stacks are always enabled by default, then
> > you'll get more testing than if only people who enable DEBUG_KERNEL
> > are able to turn it on.
> >...
>
> This is not what my patch does.
>
> Please apply my patch, use DEBUG_KERNEL=n and you'll understand it.
>
I see now what it is your patch does. I misread it - sorry - should
have just downloaded it and tried it.
It does exactely what I thought it didn't do - I like it :-)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
