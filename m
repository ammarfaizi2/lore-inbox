Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132756AbRDDHAq>; Wed, 4 Apr 2001 03:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132757AbRDDHAf>; Wed, 4 Apr 2001 03:00:35 -0400
Received: from dial082.za.nextra.sk ([195.168.64.82]:260 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S132754AbRDDHA1>;
	Wed, 4 Apr 2001 03:00:27 -0400
Date: Wed, 4 Apr 2001 09:44:12 +0200
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: Basic Text Mode (was: Re: Question about SysRq)
Message-ID: <20010404094412.B808@Boris>
In-Reply-To: <20010331230454.A801@Boris> <000201c0bb97$6c4e4ae0$de00a8c0@homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000201c0bb97$6c4e4ae0$de00a8c0@homeip.net>; from eccesys@topmail.de on Mon, Apr 02, 2001 at 04:35:56PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is a very good idea, and to implement quite easy. You just do have to
> diff between three types of video cards (MDA, MGA and HGC vs. CGA and AGA vs. EGA+).
> Then you do direct register writes. For the HGC I did it recently in a DOS proggy
> which switched from text to gfx and back. I had a TSR which simulated a gfx BIOS.
> Only problem is, I lost the source. But I could rewrite and test it on request.
> I even would put it under GPL for the kernel (normally this is a no-no for me),
> just ask me. I will write it in NASM then because I can't the AT&T syntax.
> For non-i386 Platforms I do not know about this topic. (IIRC the Apples didnt
> even have a text mode)
> Maybe I could look up the EGA register values somewhere.

The hardware part of mode restoring could really be done the register way and
may be interesting - i did code a lot in dos and this is what i did too, 
if i had experience with register programming and vga(..). Mostly i skipped
this arena, because i have had information about vga registers just enough
to damage monitor, so rather used VESA for video stuff :)
But i think only this way should break some internal state of console or
what driver. 

Thanks for the willingness, thought. I read from the thread - James Simmons,
console developer, is working on it, so you may eg. ask to cooperate with him,
he surely has a lot of ideas of text/vga switching in linux.

Cheers                                                               B.
