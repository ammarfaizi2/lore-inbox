Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264921AbSJVSo6>; Tue, 22 Oct 2002 14:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264917AbSJVSng>; Tue, 22 Oct 2002 14:43:36 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38602 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262126AbSJVSnA>; Tue, 22 Oct 2002 14:43:00 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin LaHaise <bcrl@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch 
In-reply-to: Your message of 22 Oct 2002 19:22:14 BST.
             <1035310934.31917.124.camel@irongate.swansea.linux.org.uk> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7648.1035312457.1@us.ibm.com>
Date: Tue, 22 Oct 2002 11:47:37 -0700
Message-Id: <E184442-0001zQ-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1035310934.31917.124.camel@irongate.swansea.linux.org.uk>, > : Alan
 Cox writes:
> > I think the fact that large page support doesn't support mmap for users 
> > that need it is utterly appauling; there are numerous places where it is 
> > needed.  The requirement for root-only access makes it useless for most 
> > people, especially in HPC environments where it is most needed as such 
> > machines are usually shared and accounts are non-priveledged.
> 
> I was very suprised the large page crap went in, in the form it
> currently exists. Merging pages makes sense, spotting and doing 4Mb page
> allocations kernel side makes sense. The rest is very questionable

Hmm.  Isn't it great that 2.6/3.0 will be stable soon and we can
start working on this for 2.7/3.1?

gerrit
