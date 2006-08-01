Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWHAKh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWHAKh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 06:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWHAKh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 06:37:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21973 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932109AbWHAKh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 06:37:26 -0400
Date: Tue, 1 Aug 2006 12:37:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Denis Vlasenko <vda.linux@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
Message-ID: <20060801103714.GA2310@elf.ucw.cz>
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com> <44CEBCBC.9070707@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CEBCBC.9070707@namesys.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * Are there plans for making reiserfsck interface compatible with fsck?
> >  I mean, making it so that reiserfsck can be symlinked to fsck.reiser
> >  and it will work? Currently, there seems to be some incompatibility
> >  in command-line switches. (I will dig out details and send separately
> >  when I'll get back to my Linux box.)
> 
> Not sure what you mean.  Forgive me, I have not supervised fsck as
> closely as other things.

fsck.ext2/fsck.vfat/... follow some convention including naming,
command line switches, and behaviour.

Like fsck.ext2 /dev/something is enough to check the fielsystem.

reiserfsck is missnamed (should be fsck.reiser), and it likes to chat
with you -- which is unexpected for tools.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
