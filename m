Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSFESEp>; Wed, 5 Jun 2002 14:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSFESEo>; Wed, 5 Jun 2002 14:04:44 -0400
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:16915 "EHLO
	crawl.var.cx") by vger.kernel.org with ESMTP id <S315779AbSFESEn>;
	Wed, 5 Jun 2002 14:04:43 -0400
Date: Wed, 5 Jun 2002 20:04:38 +0200
From: Frank v Waveren <fvw@var.cx>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <1023300046KSS.fvw@yendor.var.cx>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <200206050341.g553fvi09850@saturn.cs.uml.edu> <20020605170735.GA18036@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 01:07:35PM -0400, Andrew Pimlott wrote:
> > Also write out everything just before stopping the disk.
> > Don't let the disk stop if there is any dirty data.
> The kernel doesn't currently do spin-down at all, does it?  Andrew,

People interested in this should also have a look at noflushd
(http://noflushd.sourceforge.net/), which does something quite
similar. Only problem atm is it doesn't play nice with journalling
filesystems.. The bugs only list reiserfs, but I didn't have any luck with
it on ext3 either a while back.

-- 
Frank v Waveren                                      Fingerprint: 0EDB 8787
fvw@[var.cx|stack.nl|dse.nl|chello.nl] ICQ#10074100     09B9 6EF5 6425 B855
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7179 3036 E136 B85D
