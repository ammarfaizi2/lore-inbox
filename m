Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269184AbRH0VlX>; Mon, 27 Aug 2001 17:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269223AbRH0VlP>; Mon, 27 Aug 2001 17:41:15 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:13064 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S269184AbRH0VlC>; Mon, 27 Aug 2001 17:41:02 -0400
Message-ID: <3B8ABE71.5FE927D2@namesys.com>
Date: Tue, 28 Aug 2001 01:41:05 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdlab.org>
CC: Andrew Theurer <habanero@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        reiserfs-dev@namesys.com, Nikita Danilov <god@namesys.com>,
        Alexander Zarochentcev <zam@namesys.com>
Subject: Re: [reiserfs-dev] Re: Journal Filesystem Comparison on Netbench
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com> <3B8AA7B9.8EB836FF@namesys.com> <3B8AB96B.A978392E@osdlab.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> Hans-
> 
> Have you consider using OSDL machines for your testing?
> It probably wouldn't replicate Andrew's systems exactly,
> but we do have [2,4,8]-way systems that could be made
> available for your use.
> 
> ~Randy
> 
> Hans Reiser wrote:
> >
> > Please mount with -notails and repeat your results.  ReiserFS can either save
> > you on disk space, or save you on performance, but not both at the same time.
> > That said, it does not surprise me that our locking is coarser than other
> > filesystems, and we will be fixing that in version 4.  Unfortunately we don't
> > have the hardware to replicate your results.
> >
> > Hans
> >
> > Andrew Theurer wrote:
> > >
> > > Hello all,
> > >
> > > I recently starting doing some fs performance comparisons with Netbench
> > > and the journal filesystems available in 2.4:  Reiserfs, JFS, XFS, and
> > > Ext3.  I thought some of you may be interested in the results.  Below
> > > is the README from the http://lse.sourceforge.net.  There is a kernprof
> > > for each test, and I am working on the lockmeter stuff right now.  Let
> > > me
> > > know if you have any comments.
> > >
> > > Andrew Theurer
> > > IBM LTC


Ok, let's take you up on that....

we are having discussions right now of whether ReiserFS is too coarsely grained
(I argue yes based on code inspection not code measurement, others measure no
contention on a two CPU machine and say no, none of us have the hardware to
really know....)

Your hardware might help us quite a bit.

Elena, Zam, and Nikita, please email Randy off-list and make arrangements.

Hans
