Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbTBFA3E>; Wed, 5 Feb 2003 19:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbTBFA3E>; Wed, 5 Feb 2003 19:29:04 -0500
Received: from mailgate.bridgetrading.com ([62.49.201.178]:64954 "EHLO
	directcommunications.net") by vger.kernel.org with ESMTP
	id <S265222AbTBFA3E>; Wed, 5 Feb 2003 19:29:04 -0500
Message-ID: <3E41AE60.1060106@Funderburg.com>
Date: Thu, 06 Feb 2003 00:37:52 +0000
From: "Chris Funderburg (at home)" <Chris@Funderburg.com>
Organization: DCi (Europe)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Matt Reppert <arashi@yomerashi.yi.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205141104.6ae9e439.arashi@yomerashi.yi.org> <20030205233115.GB14131@work.bitmover.com>
In-Reply-To: <20030205233115.GB14131@work.bitmover.com>
X-Enigmail-Version: 0.72.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2003 11:31 PM, Larry McVoy wrote:
 >>(BTW, Larry, the bk binaries segfault on my (glibc 2.3.1) i686 
system. Any
 >>chance we could see binaries linked against 2.3.x? There's NSS 
badness between
 >>2.2 and 2.3 that causes even static binaries to segfault ... )
 >
 >
 > Yes, NSS in glibc is the world's worst garbage.  Glibc segfaults if there
 > is no /etc/nsswitch.conf.  Nice.
 >
 > We can go buy another machine for glibc2.3, I just need to know what 
redhat
 > release uses that.  If there isn't one, what distro uses that?

Matt,

I _think_ the RedHat glibc2.3 has the NSS patch to avoid this problem.
If you're into rolling your own you can find some info here:

http://www.linuxfromscratch.org/view/cvs/chapter06/glibc.html

I wanted to to run the newest version of glibc on my LFS machine, and
had to start from scratch (again) because of this.


