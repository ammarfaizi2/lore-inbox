Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUHaIXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUHaIXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUHaIXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:23:23 -0400
Received: from gprs214-181.eurotel.cz ([160.218.214.181]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267431AbUHaIWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:22:25 -0400
Date: Tue, 31 Aug 2004 10:21:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Masover <ninja@slaphack.com>
Cc: Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040831082144.GA535@elf.ucw.cz>
References: <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <20040826100530.GA20805@taniwha.stupidest.org> <20040826110258.GC30449@mail.shareable.org> <20040827210638.GE709@openzaurus.ucw.cz> <4133CDA6.4060105@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4133CDA6.4060105@slaphack.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> | uservfs does
> |
> | cd foo.deb#uar
> cd foo.deb/ar
> | vs.
> | cd foo.deb#udeb
> cd foo.deb/deb
> 
> and why would you want that, instead of just:
> cd foo.deb	# for the ar
> dpkg -i foo.deb	# for the deb

Because I want to see contents of that .deb package, nicely parsed?

> Just want to extract the tar file?  Maybe something like
> cat foo.tgz/gunzip
> In which case (of course) foo.tgz/gunzip has exactly the same directory
> contents as foo.tgz

Yes, that would work.

> In fact, for just about any syntax anyone could suggest, I can't really
> see why you can't just replace all weird symbols with a slash and a
> symbol.  Instead of
> 	foo.tgz#utar
> you have
> 	foo.tgz/#/utar
> Only difference is, some things which used to require special tools can
> now be serviced by less than what's in busybox.

That would work, too. I do not get your comment about busybox.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
