Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287184AbSABXLe>; Wed, 2 Jan 2002 18:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287173AbSABXLR>; Wed, 2 Jan 2002 18:11:17 -0500
Received: from ns.suse.de ([213.95.15.193]:37905 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287181AbSABXKd>;
	Wed, 2 Jan 2002 18:10:33 -0500
Date: Thu, 3 Jan 2002 00:10:28 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102174824.A21408@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201030006120.427-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Eric S. Raymond wrote:

> > > Just took a quick look at dmidecode.c and auditing this code doesn't
> > > seem out of reach.
> > Exactly. And 90% of it can be ditched.
> But a setuid program *will not solve my problem*.

Given decoding DMI isn't going to get you 100% fool proof way of
detecting slots (See posts on laptops/other usually-with-crap-bios
hardware), I think you're barking up the wrong tree with this
anyway.

And if you don't know what hardware you've got in the box your
configuring a kernel for, its questionable that you should be
doing so in the first place.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

