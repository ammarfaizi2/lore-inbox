Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbRENWz0>; Mon, 14 May 2001 18:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262556AbRENWzQ>; Mon, 14 May 2001 18:55:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:58889 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262554AbRENWzD>; Mon, 14 May 2001 18:55:03 -0400
Message-ID: <3B006229.EA65A868@transmeta.com>
Date: Mon, 14 May 2001 15:54:33 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105141852140.19333-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 14 May 2001, Alan Cox wrote:
> 
> > > > Except that Linus wont hand out major numbers, which means I can't even boot
> > > > simply off such a device. I bet the vendors in question dont think the sun
> > > > shines out of linus backside any more.
> > >
> > > Not really. Special-casing for mounting root is trivially solvable. BTDT,
> > > and you've reviewed the patch.
> >
> > And lilo ?
> 
> LILO uses BIOS, for fsck sake. It couldn't care less for device numbers
> on the kernel side. Ask Andries how much do they have in common with
> BIOS drive numbers.
> 

That's not the issue.  LILO takes whatever you pass to root= and converts
it to a device number at /sbin/lilo time.  An idiotic practice on the
part of LILO, in my opinion, that ought to have been fixed a long time
ago.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
