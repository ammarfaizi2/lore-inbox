Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbTBEXVo>; Wed, 5 Feb 2003 18:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTBEXVn>; Wed, 5 Feb 2003 18:21:43 -0500
Received: from bitmover.com ([192.132.92.2]:38840 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261624AbTBEXVn>;
	Wed, 5 Feb 2003 18:21:43 -0500
Date: Wed, 5 Feb 2003 15:31:15 -0800
From: Larry McVoy <lm@bitmover.com>
To: Matt Reppert <arashi@yomerashi.yi.org>
Cc: Andrew Morton <akpm@digeo.com>, andrea@suse.de, lm@bitmover.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205233115.GB14131@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Matt Reppert <arashi@yomerashi.yi.org>,
	Andrew Morton <akpm@digeo.com>, andrea@suse.de, lm@bitmover.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205141104.6ae9e439.arashi@yomerashi.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205141104.6ae9e439.arashi@yomerashi.yi.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (BTW, Larry, the bk binaries segfault on my (glibc 2.3.1) i686 system. Any
> chance we could see binaries linked against 2.3.x? There's NSS badness between
> 2.2 and 2.3 that causes even static binaries to segfault ... )

Yes, NSS in glibc is the world's worst garbage.  Glibc segfaults if there
is no /etc/nsswitch.conf.  Nice.

We can go buy another machine for glibc2.3, I just need to know what redhat
release uses that.  If there isn't one, what distro uses that?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
