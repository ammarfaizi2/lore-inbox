Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268436AbUHaNUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268436AbUHaNUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUHaNUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:20:33 -0400
Received: from gprs214-181.eurotel.cz ([160.218.214.181]:13441 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268436AbUHaNMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:12:15 -0400
Date: Tue, 31 Aug 2004 15:12:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, reiserfs-list@namesys.com
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea of what reiser4 wants to do with metafiles and why
Message-ID: <20040831131201.GA1609@elf.ucw.cz>
References: <41323AD8.7040103@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41323AD8.7040103@namesys.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Answer: choose obscure names
> 
> Problem (all credit to Mr. Demidov for identifying this problem, I
> argued the other viewpoint, and I can only claim the wisdom to know
> that I lost the argument): names like "..metas" are ugly to new users,
> who don't really care for languages that use punctuation in their
> keywords.
> 
> Answer
> 
> don't make them too obscure, experienced namespace developers know
> that the problem of polluting the namespace is not really as big a
> deal as beginners think it is, and Clearcase and the WAFL filesystem
> manage to get by just fine, whereas the problem of putting punctuation
> marks into names and syntax is a big deal for newbies to the system.
> Name it "metas" not "..metas", and users will never experience it as a
> real problem, and newbies will never be annoyed by a-rhythmic
> punctuation.  Note: if Linus disagrees, it is not the most important
> thing in this design, "..metas" isn't the end of the world.

What about choosing just "..." instead of "metas"? "metas" is string
that needs translation etc, while "..." is nicely neutral.

cat /sound_of_silence.mp3/.../author

does not look bad, either...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
