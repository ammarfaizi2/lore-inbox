Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSLHKhS>; Sun, 8 Dec 2002 05:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265336AbSLHKhS>; Sun, 8 Dec 2002 05:37:18 -0500
Received: from [66.70.28.20] ([66.70.28.20]:22803 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S265285AbSLHKhR>; Sun, 8 Dec 2002 05:37:17 -0500
Date: Sun, 8 Dec 2002 11:36:03 +0100
From: DervishD <raul@pleyades.net>
To: Edgar Toernig <froese@gmx.de>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unable to boot a raw kernel image :??
Message-ID: <20021208103603.GB135@DervishD>
References: <20021129132126.GA102@DervishD> <3DF08DD0.BA70DA62@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DF08DD0.BA70DA62@gmx.de>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Edgar :)

> >     Anyone knows what's happenning here?
> The long explanation: The BIOS allows bigger-than-track-size reads
> in El-Torito mode which confuses the probe routine which then assumes
> a 2.88MB disk when the BIOS is actually emulating a 1.44MB disk.
> In LBA mode that would be no problem but in CHS mode (which is used
> by the loader) it does not work.

    I've tried too with a home-made boot loader which works in LBA
mode (I use it in my system and works OK) using a no-emulation boot
CD, but then the kernel is not even loaded :(

    Thanks for the explanation :)) Why this did work on older kernels
but not on 2.4.x :????

    Anyway, I think I will use a patched version of Isolinux. Less
complications and more power than a raw disk image :(

    Raúl
