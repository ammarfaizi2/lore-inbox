Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131710AbRC0Xno>; Tue, 27 Mar 2001 18:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131729AbRC0Xn0>; Tue, 27 Mar 2001 18:43:26 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22461 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S131710AbRC0XnV>; Tue, 27 Mar 2001 18:43:21 -0500
Date: Tue, 27 Mar 2001 16:42:28 -0700
Message-Id: <200103272342.f2RNgSo23933@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Dan Hollis <goemon@anime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <3AC11AFA.92889B47@transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0103271454190.2234-100000@anime.net>
	<3AC11AFA.92889B47@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> Dan Hollis wrote:
> > 
> > On Tue, 27 Mar 2001, H. Peter Anvin wrote:
> > > c) Make sure chown/chmod/link/symlink/rename/rm etc does the right thing,
> > > without the need for "tar hacks" or anything equivalently gross.
> > 
> > write-through filesystem, like overlaying a r/w ext2 on top of an iso9660
> > fs.
> 
> This is not necessarily the right way to do it, since it may not
> carry with it the appropriate information.  Richard, I belive, was
> planning to implement this using devfsd.

I did, back in April 2000. I'm fairly sure I told you at OLS :-)

Create and change events can be passed to devfsd and this may be
recorded in a filesystem.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
