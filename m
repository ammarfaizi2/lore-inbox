Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289506AbSAJPi6>; Thu, 10 Jan 2002 10:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289507AbSAJPij>; Thu, 10 Jan 2002 10:38:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:42017 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289506AbSAJPia>; Thu, 10 Jan 2002 10:38:30 -0500
Date: Thu, 10 Jan 2002 16:37:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Error reading multiple large files
Message-ID: <20020110163742.N3357@inspiron.school.suse.de>
In-Reply-To: <Pine.LNX.4.30.0201071941100.13561-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0201071941100.13561-100000@mustard.heime.net>; from roy@karlsbakk.net on Mon, Jan 07, 2002 at 07:45:57PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 07:45:57PM +0100, Roy Sigurd Karlsbakk wrote:
> Hi all
> 
> I've sent this before, but as far as I can see, nothing's changed.
> 
> I'm having problems reading multiple large files at once. Reading 100 1GB
> files at once.
> 
> What happens is, when the buffer cache gets filled up, it all stalls, and
> transfer speed drops from 40-50 MB/s to a mere 2MB/s.
> 
> This has been tested on all versions from 2.4.16-2.4.18-pre1.

please try to reproduce on 2.4.18pre2aa2:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre2aa2.bz2

> 
> I've been testing Tux, Khttpd, apache 1.3.22, Apache 2, thttpd, cp and
> dd to verify the bug.

tux latest version is just included in -aa. please don't apply any
incremental patch before testing 18pre2aa2 to be sure the problem is not
introduced by some other patch.

> 
> Please help!
> 
> roy
> 
> --
> Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> 
> Computers are like air conditioners.
> They stop working when you open Windows.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
