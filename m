Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268592AbUIGU7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268592AbUIGU7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268602AbUIGU7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:59:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55219 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268592AbUIGU7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:59:12 -0400
Date: Tue, 7 Sep 2004 22:59:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, reiserfs-list@namesys.com
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea of what reiser4 wants to do with metafiles and why
Message-ID: <20040907205911.GA17555@atrey.karlin.mff.cuni.cz>
References: <41323AD8.7040103@namesys.com> <20040831131201.GA1609@elf.ucw.cz> <413E170F.9000204@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413E170F.9000204@namesys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >What about choosing just "..." instead of "metas"? "metas" is string
> >that needs translation etc, while "..." is nicely neutral.
> >
> >cat /sound_of_silence.mp3/.../author
> >
> >does not look bad, either...

> "..." is pretty good, but I think it has been used by others, but I 
> really forget who.  I could live with "...", but I think "metas" and 
> "..metas" will collide less often.  Apparently Meta is a finnish name or 
> something, so Linus does not like it.  The exact string is really not 
> very important to me.  I agree that "..." is elegant.

Well, "..." is mostly used by script kiddies -- they usually have
their rootkit collection there :-).

It would be nice to decide on one escape into "meta" namespace,
uservfs and similar projects probably should be converted to use same
escape.

[Uservfs currently uses things like cat /tmp/foo.tgz#utar/bar.gz#ugz
... essentially using # as another separator. It should probably be
converted to use same meta escape].

								Pavel


