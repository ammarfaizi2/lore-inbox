Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268580AbUIBTtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268580AbUIBTtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268657AbUIBTt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:49:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5559 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268580AbUIBTtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:49:11 -0400
Date: Thu, 2 Sep 2004 21:49:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Spam <spam@tnonline.net>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Lee Revell <rlrevell@joe-job.com>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040902194909.GA8653@atrey.karlin.mff.cuni.cz>
References: <rlrevell@joe-job.com> <1094079071.1343.25.camel@krustophenia.net> <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl> <1535878866.20040902214144@tnonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535878866.20040902214144@tnonline.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> FWIW, this is how Windows does it now.  As of XP, 'Find files' has an
> >> option, enabled by default, to look inside archives.  If you tell it to
> >> look for a driver in a given directory it will also look inside .cab
> >> and .zip files.  It's extremely useful, I would imagine someone who uses
> >> XP a lot will come to expect this feature.
> 
> > It is trivial to implement this by looking inside the files. I.e., the way
> > mc has done this for ages.
> 
>   Difference is that you can't do "locate" or "find" or "Search".. You
>   would have to open the files in an archive-supporting application
>   such as mc.

You really need archive support in find. At the very least you need
option "enter archives" vs. "do not enter archives". Entering archives
automagically is seriously wrong.
								Pavel
