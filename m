Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUIAFAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUIAFAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 01:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUIAFAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 01:00:35 -0400
Received: from gprs212-176.eurotel.cz ([160.218.212.176]:6784 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267538AbUIAFAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 01:00:31 -0400
Date: Wed, 1 Sep 2004 06:59:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Masover <ninja@slaphack.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901045922.GA512@elf.ucw.cz>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41352279.7020307@slaphack.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> | You do need extra tools anyway, placing them in the kernel is cheating
> (and
> | absolutely pointless, IMHO).
> 
> Repeat after me:  plugins in kernel does NOT equal tools in kernel.
> 
> It's not hard to, for instance, imagine a generic plugin for archive
> manipulation which talks to a userspace daemon/library.  The kernel
> doesn't know anything other than (maybe) a list of extensions that are
> archives.  All else is handled in userspace -- the idea that "this is a
> zipfile" and "zipfiles can be extracted with the 'zip' command" are all
> in userspace.
> 
> It's not about the kernel, it's about the interface.  And see my other mail:
> 	cat foo.zip/README
> 	less foo.zip/contents/bar.c
> is a lot easier than
> 	lynx http://google.com/search?q=zip
> 	emerge zip
> 	man zip
> 	unzip foo.zip
> 	cat bar.c
> which already assumes quite a lot of expertise.

If you only want nice user interface, you can have that today. Its
done using coda, and hosted at uservfs.sf.net.
								Pavel
-- 
When do you have heart between your knees?
