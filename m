Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264759AbSJVV2y>; Tue, 22 Oct 2002 17:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264813AbSJVV2y>; Tue, 22 Oct 2002 17:28:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:42938 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264759AbSJVV2y>; Tue, 22 Oct 2002 17:28:54 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch 
In-reply-to: Your message of 22 Oct 2002 21:23:59 BST.
             <1035318239.329.141.camel@irongate.swansea.linux.org.uk> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10176.1035322404.1@us.ibm.com>
Date: Tue, 22 Oct 2002 14:33:24 -0700
Message-Id: <E1846eS-0002eC-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1035318239.329.141.camel@irongate.swansea.linux.org.uk>, > : Alan C
ox writes:
> On Tue, 2002-10-22 at 20:03, Martin J. Bligh wrote:
> 
> > > Can we delete the specialty syscalls now?
> > 
> > I was lead to believe that Linus designed them, so he may be emotionally attatched 
> > to them, but I think there would be few others that would cry over the loss ...
> 
> You mean like the wonderfully pointless sys_readahead. The sooner these
> calls go the better.

No, the other icky syscalls - the {alloc,free}_hugepages.

gerrit
