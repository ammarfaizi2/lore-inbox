Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263456AbTJ0SVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTJ0SVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:21:45 -0500
Received: from vic20.blipp.com ([217.75.101.38]:10896 "EHLO vic20.blipp.com")
	by vger.kernel.org with ESMTP id S263456AbTJ0SVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:21:42 -0500
Date: Mon, 27 Oct 2003 19:21:41 +0100
From: Patrik Wallstrom <pawal@blipp.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test9
Message-ID: <20031027182141.GH32168@vic20.blipp.com>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org> <20031026120521.GD32168@vic20.blipp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026120521.GD32168@vic20.blipp.com>
Organization: Foodfight Stockholm
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Oct 2003, Patrik Wallstrom wrote:

> On Sat, 25 Oct 2003, Linus Torvalds wrote:
> 
> > Jeff Garzik:
> >   o [libata] Merge Serial ATA core, and drivers for
> >   o [libata] Integrate Serial ATA driver into kernel tree
> 
> I am happy to see these in the kernel now, but I have yet to get them
> working on my KT6 Delta KT600 motherboard with the VT8237 SATA
> southbridge controller or even the Promise controller.
> 
> These are the devices:
> 
>   Bus  0, device  13, function  0:
>     RAID bus controller: PCI device 105a:3373 (Promise Technology, )
>     (rev 2).
>       IRQ 19.
>       Master Capable.  Latency=96.  Min Gnt=4.Max Lat=18.
>       I/O at 0xec00 [0xec3f].
>       I/O at 0xe800 [0xe80f].
>       I/O at 0xe400 [0xe47f].
>       Non-prefetchable 32 bit memory at 0xdffdb000 [0xdffdbfff].
>       Non-prefetchable 32 bit memory at 0xdffa0000 [0xdffbffff].
> 

This patch worked for the Promise-controller:
http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-promise20378.patch

-- 
patrik_wallstrom->foodfight->pawal@blipp.com->+46-733173956
                `-> http://www.gnuheter.com/
