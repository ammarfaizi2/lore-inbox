Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289862AbSAWXEl>; Wed, 23 Jan 2002 18:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSAWXEb>; Wed, 23 Jan 2002 18:04:31 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:6224 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S289970AbSAWXEW>; Wed, 23 Jan 2002 18:04:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Denis Oliver Kropp <dok@directfb.org>
Subject: Re: [PATCH] NeoMagic Framebuffer Driver
Date: Thu, 24 Jan 2002 00:04:19 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020110161922.GA27357@skunk.convergence.de> <20020123114357.A29331@wierzbowski.devel.redhat.com> <20020123165741.GA30860@skunk.convergence.de>
In-Reply-To: <20020123165741.GA30860@skunk.convergence.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020123230419.CA8731472@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 23. January 2002 17:57, Denis Oliver Kropp wrote:
> Quoting Bill Nottingham (notting@redhat.com):
> > Denis Oliver Kropp (dok@directfb.org) said:
> > > this version has a MODULE_LICENSE, applies fine to linux-2.4.18-pre6.
> >
> > This seems to react rather badly when loaded from within X; I managed
> > to lock the machine trying to switch VCs after doing so (for example,
> > when I tried with matroxfb, it only screwed up the display.)
>
> The Matrox graphics cards are quite resistant when being programmed
> by two drivers simultaneously.

I'm quite happy since the latest 2.4.1* and X 4.1.0, switching between 
console framebuffers and X with my MGA G450, it didn't result in a color 
screw anymore, although it worked somehow before...

> > Yes, I know this falls into the 'don't *DO* that' category. :)

> Definitely ;)

No, but if you did, your eyes bled category :)

A small glitch remains: 1 of 4 X(dm) (re)starts the screen is 3 cm 
discentered. Switching back and forth fixes it always. 

Cheers,
  Hans-Peter
