Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRKIJas>; Fri, 9 Nov 2001 04:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279739AbRKIJa2>; Fri, 9 Nov 2001 04:30:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17416 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S279754AbRKIJaU>; Fri, 9 Nov 2001 04:30:20 -0500
Date: Fri, 9 Nov 2001 10:30:13 +0100
From: Jan Kara <jack@suse.cz>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large files and filesystem block size
Message-ID: <20011109103013.B1734@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.30.0111081553470.1479-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0111081553470.1479-100000@mustard.heime.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> I'm setting up a server serving large >=1GB files. I spoke to this guy
> that just finished his PhD on the subject
> (http://ConfMan.unik.no/~paalh/index2.html) , and he said he'd managed to
> increase the throughput by using a 64kB block size on the files system.
> This testing was done on NetBSD (as far as I can remember).
> 
> Does anyone know of a file system that supports large files, large
> filesystems and large block sizes?
  Linux doesn't support larger block size than page size (ie. 4 KB on i386).

> Does any of you have any theories if his practice in using larger block
> sizes will have the same impact on performance in Linux as it had in BSD?
  I think performance will improve but only for large files (but that's
probably what you want).

								Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
