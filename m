Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274222AbRIXWkK>; Mon, 24 Sep 2001 18:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274223AbRIXWkA>; Mon, 24 Sep 2001 18:40:00 -0400
Received: from zeus.kernel.org ([204.152.189.113]:3770 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S274222AbRIXWjv>;
	Mon, 24 Sep 2001 18:39:51 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 24 Sep 2001 16:39:49 -0600
To: Andrew Morton <akpm@zip.com.au>
Cc: J Troy Piper <jtp@dok.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.10
Message-ID: <20010924163949.K14526@turbolinux.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	J Troy Piper <jtp@dok.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20010924163546.C244@dok.org> <3BAFABA9.9A8DD1B4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BAFABA9.9A8DD1B4@zip.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 24, 2001  14:54 -0700, Andrew Morton wrote:
> > Any more progress on my journal_revoke BUG?  Strangely enough, I've been
> > mounting the drives as ext2 to try and avoid the errors, but I *STILL* hit
> > the BUG when untar'ing a large file, or compiling a large file (ie. kernel
> > source), which is somewhat unnerving.
> 
> That should have been fixed in 0.9.9????

If the problem happens under ext2 as well, it is not a journal_revoke BUG
(or at least it shouldn't be...).  Can you post the OOPS output (after
running it through ksymoops of course) WHEN RUNNING WITH EXT2.  It may be
that there is a bug lurking somewhere else also, and you just happen to
be lucky enough to find both.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

