Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273303AbRIYTrc>; Tue, 25 Sep 2001 15:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273309AbRIYTrX>; Tue, 25 Sep 2001 15:47:23 -0400
Received: from mons.uio.no ([129.240.130.14]:1233 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S273303AbRIYTrJ>;
	Tue, 25 Sep 2001 15:47:09 -0400
MIME-Version: 1.0
Message-ID: <15280.57166.621818.388973@charged.uio.no>
Date: Tue, 25 Sep 2001 21:47:26 +0200
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.GSO.4.21.0109251521030.24321-100000@weyl.math.psu.edu>
In-Reply-To: <shshetr3xgv.fsf@charged.uio.no>
	<Pine.GSO.4.21.0109251521030.24321-100000@weyl.math.psu.edu>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alexander Viro <viro@math.psu.edu> writes:

     > On 25 Sep 2001, Trond Myklebust wrote:

    >> Yes *please*! Finally we could introduce proper support for
    >> 64-bit inode numbers too!

     > Right.  As soon as userland is audited for places where it uses
     > int for storing inode numbers - just a couple of months after
     > MS fixes all security holes in their software.  By then we'll
     > need 128bit time_t, though...

Anybody using the fstat64() interface has of course already done this,
and MS are known to be releasing the highly secure Windoze-XP any day
now...

I think I could find a use for the larger time_t too...

Cheers,
  Trond
