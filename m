Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136686AbREJOj1>; Thu, 10 May 2001 10:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136688AbREJOjR>; Thu, 10 May 2001 10:39:17 -0400
Received: from idiom.com ([216.240.32.1]:32523 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S136686AbREJOjJ>;
	Thu, 10 May 2001 10:39:09 -0400
Message-ID: <3AFAA802.B36D538C@namesys.com>
Date: Thu, 10 May 2001 07:38:58 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pekka Pietikainen <pp@evil.netppl.fi>
CC: linux-kernel@vger.kernel.org, yura@namesys.com, elena@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <alan@lxorguk.ukuu.org.uk> <200105092125.f49LPew13300@jen.americas.sgi.com> <20010510131945.B11927@netppl.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would encourage all of you to consider using a fractal fileset generator such as
reiserfs_fract_tree.c such as we use for mongo.pl which we use for internal
benchmarking.  You can get a copy at www.namesys.com in the benchmarking section,
and then tune it as suits your needs.  I think that one needs randomly generated
non-uniform sized files and directories and directory trees to have a good
benchmark.

We gratefully accept enhancements of it.

Now that we are stable we can go back to tuning things like large file performance.

Hans

