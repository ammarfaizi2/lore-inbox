Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269181AbUJFJ6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269181AbUJFJ6C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 05:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269182AbUJFJ6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 05:58:01 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:51559 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269181AbUJFJ51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 05:57:27 -0400
Message-ID: <4d8e3fd304100602571d6d9907@mail.gmail.com>
Date: Wed, 6 Oct 2004 11:57:27 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Ingo Molnar <mingo@redhat.com>
Subject: Re: new dev model (was Re: Default cache_hot_time value back to 10ms)
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, kenneth.w.chen@intel.com,
       linux-kernel@vger.kernel.org, judith@osdl.org
In-Reply-To: <Pine.LNX.4.58.0410060512580.14349@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
	 <20041005205511.7746625f.akpm@osdl.org> <416374D5.50200@yahoo.com.au>
	 <20041005215116.3b0bd028.akpm@osdl.org>
	 <41637BD5.7090001@yahoo.com.au>
	 <20041005220954.0602fba8.akpm@osdl.org>
	 <416380D7.9020306@yahoo.com.au>
	 <20041005223307.375597ee.akpm@osdl.org> <41638E61.9000004@pobox.com>
	 <Pine.LNX.4.58.0410060512580.14349@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004 05:23:29 -0400 (EDT), Ingo Molnar <mingo@redhat.com> wrote:
> 
> On Wed, 6 Oct 2004, Jeff Garzik wrote:
> 
> > The _reality_ is that there is _no_ point in time where you and Linus
> > allow for stabilization of the main tree prior to relesae. [...]
> 
> i dont think this is fair to Andrew - there's hundreds of patches in his
> tree that are scheduled for 2.6.10 not 2.6.9.

Andrew is doing an amazing job. He's really an impressive hacker.
 
> you are right that -mm is experimental, but the latency of bugfixes is the
> lowest i've ever seen in any Linux tree, which is quite amazing
> considering the hundreds of patches.

Just my humble opinion,
I think that's because Andrew and Linus are working very well together,
I'm not sure that's because the new dev model.
It seems to me that there is room for improvment.

> it is also correct that the pile of patches in the -mm tree mask the QA
> effects of testing done on -mm, so testing -BK separately is just as
> important at this stage.
> 
> Maybe it would help perception and awareness-of-release a bit if at this
> stage Andrew switched the -mm tree to the -BK tree and truly only kept
> those patches that are destined for BK for 2.6.9. [i.e. if the current
> patch-series would be cut off at patch #3 or so, but the numbering of
> -rc3-mm3 would be keept.] This can only be done if the changes from now to
> 2.6.9-real are small enough in that they dont impact those 700 patches too
> much.
> 
> This switching would immediately expose all -mm users to the current state
> of affairs of the -BK tree. (yes, people could try the -BK tree just as
> much but it seems -mm is used by developers quite often and it would help
> if the two trees would be largely equivalent so close to the release.)

Good idea.

-- 
Paolo
Personal home page: www.ciarrocchi.tk
See my photos: http://paolociarrocchi.fotopic.net/
Buy cool stuff here: http://www.cafepress.com/paoloc
