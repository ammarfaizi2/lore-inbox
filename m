Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRBBO4C>; Fri, 2 Feb 2001 09:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129149AbRBBOzw>; Fri, 2 Feb 2001 09:55:52 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:16900 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S129399AbRBBOzm>;
	Fri, 2 Feb 2001 09:55:42 -0500
Date: Fri, 2 Feb 2001 12:55:35 -0200
From: Rogerio Brito <rbrito@iname.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the VIA KT133 chipset misbehaving in Linux
Message-ID: <20010202125535.A6248@iname.com>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3A75278F.B41B492B@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A75278F.B41B492B@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 29 2001, Dylan Griffiths wrote:
> The VIA KT133 chipset exhibits the following bugs under Linux 2.2.17 and
> 2.4.0:
> 1) PS/2 mouse cursor randomly jumps to upper right hand corner of screen and
> locks for a bit
> 2) Detects a maximum of 64mb of ram, unless worked around by the "mem="
> switch
> 3) The clock drifts slowly (more so under heavy load than light load),
> leaking time.

	I know that I am late here, but I'm also using a via KT133
	chipset with a Duron 600MHz and I'm using a kernel 2.2.18 here
	with the IDE patches and I'm not seeing anything of the above
	problems. Everything just works fine.

	What are you using? I'm using an Asus A7V, with BIOS 1003 (I
	didn't upgrade it, since I'm terribly scarred of it going
	wrong and not being to boot again).

	This is with kernel 2.2.18 (no signs of filesystem corruption
	also, and I have UDMA/66 enabled, but my system is not exactly
	stressed).

> I think #2 is because e820h memory detection

	While I don't have problems with the Duron above, I do have a
	486 here with 8MB of memory that I intend to use as a router
	for my local LAN, but 2.4.0 only recognizes 7MB, while 2.2.18
	recognizes all 8MB. Under 2.4.0 (I haven't tried 2.4.1 yet), I
	used a mem=8M option and it worked fine, but I don't know if
	this is indeed safe or not (I'd guess that it would be, since
	the 2.2 kernels use all memory, but you never know).


	[]s, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
