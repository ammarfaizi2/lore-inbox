Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279839AbRKILgH>; Fri, 9 Nov 2001 06:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279832AbRKILf5>; Fri, 9 Nov 2001 06:35:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19730 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S279839AbRKILfp>; Fri, 9 Nov 2001 06:35:45 -0500
Date: Fri, 9 Nov 2001 12:35:39 +0100
From: Jan Kara <jack@suse.cz>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large files and filesystem block size
Message-ID: <20011109123538.A20155@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011109103013.B1734@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.30.0111091231100.6010-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0111091231100.6010-100000@mustard.heime.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I'm setting up a server serving large >=1GB files. I spoke to this guy
> > > that just finished his PhD on the subject
> > > (http://ConfMan.unik.no/~paalh/index2.html) , and he said he'd managed to
> > > increase the throughput by using a 64kB block size on the files system.
> > > This testing was done on NetBSD (as far as I can remember).
> > >
> > > Does anyone know of a file system that supports large files, large
> > > filesystems and large block sizes?
> 
> > Linux doesn't support larger block size than page size (ie. 4 KB on i386).
> 
> Is this limit the indepandant of file system type?
  Yes it is. But all reasonable filesystems like ext2, ext3, reiserfs etc. support
4KB block sizes. Maybe you can try XFS which should be designed for large files
but I have no experience with it..

								Honza
