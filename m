Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbREOF6n>; Tue, 15 May 2001 01:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262643AbREOF6e>; Tue, 15 May 2001 01:58:34 -0400
Received: from [195.180.174.169] ([195.180.174.169]:2176 "EHLO idun.neukum.org")
	by vger.kernel.org with ESMTP id <S262639AbREOF60>;
	Tue, 15 May 2001 01:58:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: "H. Peter Anvin" <hpa@transmeta.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Tue, 15 May 2001 07:56:35 +0200
X-Mailer: KMail [version 1.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0105141852140.19333-100000@weyl.math.psu.edu> <3B006229.EA65A868@transmeta.com>
In-Reply-To: <3B006229.EA65A868@transmeta.com>
MIME-Version: 1.0
Message-Id: <01051507563500.01598@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 15. May 2001 00:54, H. Peter Anvin wrote:
> Alexander Viro wrote:
> > On Mon, 14 May 2001, Alan Cox wrote:
> > > > > Except that Linus wont hand out major numbers, which means I can't
> > > > > even boot simply off such a device. I bet the vendors in question
> > > > > dont think the sun shines out of linus backside any more.
> > > >
> > > > Not really. Special-casing for mounting root is trivially solvable.
> > > > BTDT, and you've reviewed the patch.
> > >
> > > And lilo ?
> >
> > LILO uses BIOS, for fsck sake. It couldn't care less for device numbers
> > on the kernel side. Ask Andries how much do they have in common with
> > BIOS drive numbers.
>
> That's not the issue.  LILO takes whatever you pass to root= and converts
> it to a device number at /sbin/lilo time.  An idiotic practice on the
> part of LILO, in my opinion, that ought to have been fixed a long time
> ago.

And happily passes a "root=" argument through "append=" for the kernel to 
evaluate.

	Regards
		Oliver
