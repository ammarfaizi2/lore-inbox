Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbTBEXjE>; Wed, 5 Feb 2003 18:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTBEXjE>; Wed, 5 Feb 2003 18:39:04 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57500
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265139AbTBEXjE>; Wed, 5 Feb 2003 18:39:04 -0500
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Matt Reppert <arashi@yomerashi.yi.org>, Andrew Morton <akpm@digeo.com>,
       andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030205233115.GB14131@work.bitmover.com>
References: <20030205174021.GE19678@dualathlon.random>
	 <20030205102308.68899bc3.akpm@digeo.com>
	 <20030205184535.GG19678@dualathlon.random>
	 <20030205114353.6591f4c8.akpm@digeo.com>
	 <20030205141104.6ae9e439.arashi@yomerashi.yi.org>
	 <20030205233115.GB14131@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044492355.15565.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Feb 2003 00:45:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 23:31, Larry McVoy wrote:
> > (BTW, Larry, the bk binaries segfault on my (glibc 2.3.1) i686 system. Any
> > chance we could see binaries linked against 2.3.x? There's NSS badness between
> > 2.2 and 2.3 that causes even static binaries to segfault ... )
> 
> Yes, NSS in glibc is the world's worst garbage.  Glibc segfaults if there
> is no /etc/nsswitch.conf.  Nice.

bugzilla is your friend

