Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965311AbVIPTjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965311AbVIPTjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbVIPTjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:39:45 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:3777 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S965311AbVIPTjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:39:44 -0400
Message-ID: <432B1F84.3000902@namesys.com>
Date: Fri, 16 Sep 2005 12:39:48 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com> <20050916174028.GA32745@infradead.org>
In-Reply-To: <20050916174028.GA32745@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>additinoal comment is that the code is very messy, very different
>from normal kernel style, full of indirections and thus hard to read.
>

Most of my customers remark that Namesys code is head and shoulders
above the rest of the kernel code.  So yes, it is different.  In
particular, they cite the XFS code as being so incredibly hard to read
that its unreadability is worth hundreds of thousands of dollars in
license fees for me.  That's cash received, from persons who read it
all, not commentary made idly.

May I suggest that you work on the XFS code instead?  Surely with all of
this energy you have, you could improve XFS a lot before it gets
accepted into the kernel. 

As for the indirections, if you figure out how to make VFS indirections
easy to follow, the same technique should be applicable to Reiser4, and
I will be happy to fix it. 

Hans

(Note for the record: I actually think XFS acceptance was delayed too
long, and I think that XFS is a great filesystem, but a rhetorical point
needed to be made......)
