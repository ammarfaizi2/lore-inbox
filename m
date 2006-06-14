Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWFNVeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWFNVeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 17:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWFNVeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 17:34:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3345 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S932362AbWFNVet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 17:34:49 -0400
Date: Wed, 14 Jun 2006 21:34:31 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Jeff Garzik <jeff@garzik.org>, Matthew Frost <artusemrys@sbcglobal.net>,
       Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060614213431.GF4950@ucw.cz>
References: <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org> <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <20060612220605.GD4950@ucw.cz> <986ed62e0606140731u4c42a2adv42c072bf270e4874@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606140731u4c42a2adv42c072bf270e4874@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Please don't. AFAIK, ext2/3 is only filesystem with 
> >working fsck
> >(because that fsck was actually needed in the old 
> >days). Starting from
> >xfs/jfs/reiser/??? means we no longer have working 
> >fsck...
> 
> Er, what do you mean by "working fsck"?

Passes 8 hours of me trying to intentionally break it with weird,
artifical disk corruption.

I even have script somewhere.

> Unless I'm misunderstanding something, JFS also has a 
> working fsck
> (which has actually performed successful repair of 
> real-world
> filesystem corruption for me, although I haven't used it 
> as much as
> e2fsck or xfs_repair).

...like, if it repaired 100 different, non-trivial corruptions, that
would be argument.

fsck.ext2 survives my torture (in some versions). fsck.vfat never
worked for me (likes to segfault), fsck.reiser never worked for me.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
