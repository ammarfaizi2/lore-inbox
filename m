Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276785AbRJCRwP>; Wed, 3 Oct 2001 13:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276765AbRJCRwF>; Wed, 3 Oct 2001 13:52:05 -0400
Received: from quechua.inka.de ([212.227.14.2]:9529 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S276785AbRJCRvs>;
	Wed, 3 Oct 2001 13:51:48 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem uses Linus Torvalds ?
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.10-xfs (i686))
Message-Id: <E15oqBs-00057E-00@calista.inka.de>
Date: Wed, 03 Oct 2001 19:52:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net> you wrote:
> With the availability of XFS,JFS,ext3 and ReiserFS I am a 
> little
> lost and I don't know which one I should use for entreprise 
> class
> servers.

In former versions of ReiserFS you had a weak support for fschk. And since a
lot of bugs and heavy load triggered this problem regularly, it was not
awise idea to use Reiser. Things are reported to have increased, but I do
not have any first hand experineces since then.

Personally I think xfs is a very mature Journaling File System. A bit
annoying is, that the CVS tree is hard to track from SGI. I have reports
from heavyly loaded servers that it performs very well (i.e. newsspool).

ext3 is the alternative, cause of its compatibility to ext2. But I am not
sure, if this is good or bad, since it has not increaesed some of the
performance issues of the ext2 structure, afaik.

I have no experience with JFS, IBM seems to missed a opportunity to have
large community support.

GFS as a general purpose filesystem may need some more tweaking, but it's
cluster properties are great for enterprise systems.

Greetings
Bernd
