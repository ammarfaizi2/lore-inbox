Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275684AbTHOFhN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 01:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275686AbTHOFhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 01:37:13 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:34530 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S275684AbTHOFhM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 01:37:12 -0400
Date: Thu, 14 Aug 2003 22:32:21 -0700
From: "Martin J. Bligh" <fletch@aracnet.com>
To: Gabor MICSKO <gmicsko@szintezis.hu>
cc: linux-kernel@vger.kernel.org, mcao@us.ibm.com
Subject: Re: 2.6.0-test3-mjb1
Message-ID: <26250000.1060925541@[10.10.2.4]>
In-Reply-To: <1060888449.581.5.camel@sunshine>
References: <1880000.1060840776@[10.10.2.4]> <1060888449.581.5.camel@sunshine>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Gabor MICSKO <gmicsko@szintezis.hu> wrote (on Thursday, August 14, 2003 21:14:04 +0200):

> 2003-08-14, cs keltezéssel Martin J. Bligh ezt írta:
>> 
>> I'd be very interested in feedback from anyone willing to test on any 
>> platform, however large or small.
> 
> Hi!
> 
> compile error in fs/reiserfs/inode.c
> 
> [...]
> inode.c: In function `reiserfs_direct_IO':
> inode.c:2373: error: too few arguments to function `blockdev_direct_IO'
> /bin/sh: line 1: fs/reiserfs/.inode.o.tmp: Nincs ilyen fájl vagy
> könyvtár
> make[2]: *** [fs/reiserfs/inode.o] Error 1
> make[1]: *** [fs/reiserfs] Error 2
> make: *** [fs] Error 2

Oops, sorry about that.

wget ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.0-test3/2.6.0-test3-mjb1/400-reiserfs_dio
patch -p1 -R < 400-reiserfs_dio 

Should fix it for now ...

Ming Ming, could you do a new patch?

Thanks,

M.

