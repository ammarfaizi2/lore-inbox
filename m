Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279824AbRKILdh>; Fri, 9 Nov 2001 06:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279832AbRKILd2>; Fri, 9 Nov 2001 06:33:28 -0500
Received: from mustard.heime.net ([194.234.65.222]:50413 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S279824AbRKILdR>; Fri, 9 Nov 2001 06:33:17 -0500
Date: Fri, 9 Nov 2001 12:33:14 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Jan Kara <jack@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Large files and filesystem block size
In-Reply-To: <20011109103013.B1734@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.30.0111091231100.6010-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm setting up a server serving large >=1GB files. I spoke to this guy
> > that just finished his PhD on the subject
> > (http://ConfMan.unik.no/~paalh/index2.html) , and he said he'd managed to
> > increase the throughput by using a 64kB block size on the files system.
> > This testing was done on NetBSD (as far as I can remember).
> >
> > Does anyone know of a file system that supports large files, large
> > filesystems and large block sizes?

> Linux doesn't support larger block size than page size (ie. 4 KB on i386).

Is this limit the indepandant of file system type?

> > Does any of you have any theories if his practice in using larger block
> > sizes will have the same impact on performance in Linux as it had in BSD?

> I think performance will improve but only for large files (but that's
> probably what you want).

As I'm writing above, the files I'm talking of are typically 1-10GB. So
yes - this is what I want.

roy
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

