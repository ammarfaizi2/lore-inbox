Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUIGGcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUIGGcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 02:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267628AbUIGGcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 02:32:09 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:54469 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267625AbUIGGcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 02:32:00 -0400
Message-ID: <413D55E5.1090103@namesys.com>
Date: Mon, 06 Sep 2004 23:32:05 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>,
       Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200409061814.i86IEcPJ005086@laptop11.inf.utfsm.cl> <413CB219.5030800@slaphack.com>
In-Reply-To: <413CB219.5030800@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>
> There are some things which can't be solved without patching.  Version
> control is one such thing.

You can do most of the version control stuff without patching, for 
instance selecting a version by name is easy (see Clearcase).  Clearcase 
users mostly do not patch user space binaries.  But your point is 
generally true that there are features that knowing about them allows 
you to better employ them.

> But then there can be more generic patches
> -- as soon as the transaction API is done, you only have to patch apps
> to use that, and have a version control reiser4 plugin.
>
> | I'd go the other way around: Get userspace to agree on a common 
> framework,
> | make it work in userspace; if (extensive, hopefully) experience 
> shows that
> | a pure userspace solution has issues that can't be solved except by 
> kernel
> | assistance, so be it.
>
> We already have such a framework -- it's called "VFS".

If doing it in the kernel is so hard, why hasn't it stopped us yet? ;-)

I am not asking other people to contibute their labor to making this 
thing they view as infeasible work, I am just asking them to get out of 
the way please, and let the users decide whether they like it.

Nothing significant about the reiserfs project was thought likely to 
work by sensible people before it worked.  I am a bit used to that.  
After all, Oracle's IFS and several similar projects proved filesystems 
on top of balanced trees cannot  perform well....;-)

Anyone who complains about kernel bloat should first consider that 
reiser4 is not by any means the largest filesystem in the kernel.

Hans
