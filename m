Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262552AbRENWxg>; Mon, 14 May 2001 18:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262554AbRENWx0>; Mon, 14 May 2001 18:53:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40606 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262552AbRENWxM>;
	Mon, 14 May 2001 18:53:12 -0400
Date: Mon, 14 May 2001 18:53:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zR79-0001bn-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105141852140.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, Alan Cox wrote:

> > > Except that Linus wont hand out major numbers, which means I can't even boot
> > > simply off such a device. I bet the vendors in question dont think the sun
> > > shines out of linus backside any more.
> > 
> > Not really. Special-casing for mounting root is trivially solvable. BTDT,
> > and you've reviewed the patch.
> 
> And lilo ?

LILO uses BIOS, for fsck sake. It couldn't care less for device numbers
on the kernel side. Ask Andries how much do they have in common with
BIOS drive numbers.

