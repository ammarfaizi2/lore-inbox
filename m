Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265294AbSJaTJZ>; Thu, 31 Oct 2002 14:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265300AbSJaTJZ>; Thu, 31 Oct 2002 14:09:25 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:12715 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265294AbSJaTJW>; Thu, 31 Oct 2002 14:09:22 -0500
Date: Thu, 31 Oct 2002 12:15:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: Bernd Petrovitsch <bernd@gams.at>, Matt Porter <porter@cox.net>,
       Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031191535.GA815@opus.bloom.county>
References: <20021031100855.A3407@home.com> <22051.1036083179@frodo.gams.co.at> <20021031194348.A12469@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031194348.A12469@jaquet.dk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 07:43:48PM +0100, Rasmus Andersen wrote:
> On Thu, Oct 31, 2002 at 05:52:59PM +0100, Bernd Petrovitsch wrote:
> > Matt Porter <porter@cox.net> wrote:
> > >Thank you.  This is exactly why in the last CONFIG_TINY thread I made
> > >it clear that a one-size-fits-all option is not all that helpful for
> > >serious embedded systems designers.
> > >
> > >Collecting these parameters in a single tweaks.h file and perhaps using
> > >things like CONFIG_TINY, CONFIG_DESKTOP, CONFIG_FOO as profile selectors
> > 
> > In an ideal world there would be several options invidually 
> > selectable.
> 
> But there is? Please look at 2.5.44-config. Or did I misunderstand
> you. Anyways, this work is far from the point where how this is
> selected is a major concern. 

There currently isn't a CONFIG_TINY / CONFIG_DESKTOP / CONFIG_FOO.  The
idea is that all of these changes you're working on to make a smaller
kernel shouldn't all be under CONFIG_TINY, but which ones are on / off
are read from some sort of template and there's a default 'tiny'
template, 'desktop' 'foo', etc template which has some on and some off.

And this is a major concern since many of us who would have to deal with
this when it enters the kernel want it to done in a flexible manner
initially, not later on.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
