Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269099AbRH0V0M>; Mon, 27 Aug 2001 17:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269197AbRH0V0C>; Mon, 27 Aug 2001 17:26:02 -0400
Received: from archive.osdlab.org ([65.201.151.11]:31713 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S269099AbRH0VZt>;
	Mon, 27 Aug 2001 17:25:49 -0400
Message-ID: <3B8AB96B.A978392E@osdlab.org>
Date: Mon, 27 Aug 2001 14:19:39 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Andrew Theurer <habanero@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        reiserfs-dev@namesys.com
Subject: Re: Journal Filesystem Comparison on Netbench
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com> <3B8AA7B9.8EB836FF@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-

Have you consider using OSDL machines for your testing?
It probably wouldn't replicate Andrew's systems exactly,
but we do have [2,4,8]-way systems that could be made
available for your use.

~Randy

Hans Reiser wrote:
> 
> Please mount with -notails and repeat your results.  ReiserFS can either save
> you on disk space, or save you on performance, but not both at the same time.
> That said, it does not surprise me that our locking is coarser than other
> filesystems, and we will be fixing that in version 4.  Unfortunately we don't
> have the hardware to replicate your results.
> 
> Hans
> 
> Andrew Theurer wrote:
> >
> > Hello all,
> >
> > I recently starting doing some fs performance comparisons with Netbench
> > and the journal filesystems available in 2.4:  Reiserfs, JFS, XFS, and
> > Ext3.  I thought some of you may be interested in the results.  Below
> > is the README from the http://lse.sourceforge.net.  There is a kernprof
> > for each test, and I am working on the lockmeter stuff right now.  Let
> > me
> > know if you have any comments.
> >
> > Andrew Theurer
> > IBM LTC
