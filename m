Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbRH0Uaa>; Mon, 27 Aug 2001 16:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268867AbRH0UaK>; Mon, 27 Aug 2001 16:30:10 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:34497 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S268856AbRH0UaC>; Mon, 27 Aug 2001 16:30:02 -0400
Message-ID: <3B8AADA5.FBB2DAF8@us.ibm.com>
Date: Mon, 27 Aug 2001 15:29:25 -0500
From: Andrew Theurer <habanero@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        reiserfs-dev@namesys.com
Subject: Re: Journal Filesystem Comparison on Netbench
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com> <3B8AA7B9.8EB836FF@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will test -notail as soon as possible and let you know the results. 
Thanks,

Andrew Theurer

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
> >
[snip]
