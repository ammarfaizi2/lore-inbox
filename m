Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbTCRKY5>; Tue, 18 Mar 2003 05:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262264AbTCRKY5>; Tue, 18 Mar 2003 05:24:57 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:26256 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262260AbTCRKY4>; Tue, 18 Mar 2003 05:24:56 -0500
Date: Tue, 18 Mar 2003 21:35:57 +1100
From: CaT <cat@zip.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, hch@lst.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.65
Message-ID: <20030318103557.GF504@zip.com.au>
References: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com> <20030318052257.GB635@zip.com.au> <Pine.LNX.4.44.0303181040150.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303181040150.12110-100000@serv>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 11:08:08AM +0100, Roman Zippel wrote:
> > The help and the tristate seems to indicate that I should be able to
> > compile it into the kernel, but menuconfig wont let me. This is
> > presumably due to the dependancy but is it right?
> 
> Yes, this was the behaviour of the old config tools, which was restored 
> with 2.5.65. This means 'm' is a marker that this thing works only as a 
> module.
> If you want the other behaviour, that it can only be built as a module in 
> a modular kernel, but compile it into a nonmodular kernel, you can use "m 
> || !MODULES" instead.

Ahhh. So if I want module support but not use it as a module then I'm
SOL?

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of Regime of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

