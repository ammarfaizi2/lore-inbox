Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262444AbTCRPWC>; Tue, 18 Mar 2003 10:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbTCRPWC>; Tue, 18 Mar 2003 10:22:02 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:16019 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262444AbTCRPWB>; Tue, 18 Mar 2003 10:22:01 -0500
Date: Wed, 19 Mar 2003 02:33:03 +1100
From: CaT <cat@zip.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, hch@lst.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.65
Message-ID: <20030318153303.GI504@zip.com.au>
References: <20030318103557.GF504@zip.com.au> <Pine.LNX.4.44.0303180714140.11305-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303180714140.11305-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 07:16:06AM -0800, Linus Torvalds wrote:
> On Tue, 18 Mar 2003, CaT wrote:
> > Ahhh. So if I want module support but not use it as a module then I'm
> > SOL?
> 
> Well, does it _work_ as a built-in? If it does, just send me a patch for 
> the Kconfig file. 

Well, I would if I could. I don't actually have the card, I was just
going to compile it in incase I had to use one one day. Saves time not
having to recompile the kernel and I don't wanna waste disk space on
modules (and having to clean them up from old kernel versions etc). My
laptop HD space is precious. :)

> A lot of the PCMCIA stuff (16-bit) historically _only_ works as modules,
> because the old PCMCIA code depended on module unload to do a lot of the 
> cleanups that the regular internal eject handling didn't do. But if that 
> driver works for you built-in, then the Kconfig file itself is simply just 
> wrong.

It might be an idea to modify the help and maybe the error message right
now as at the moment the help indicates that it can be compiled in
without stating any conditions for it, and the error message talks about
some other mysterious component that this one depends on that was selected
as a module and so this one will be, which would send the user off on a
goose chace (like it did me for a wee bit :). Is there a way to
customize that? If so I could make up a patch that clarifies things
more.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of Regime of the United States
          September 26, 2002 (from a political fundraiser in Houston, Texas)
