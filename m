Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUEVDta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUEVDta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 23:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUEVDta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 23:49:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:45479 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265195AbUEVDtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 23:49:25 -0400
Date: Fri, 21 May 2004 20:46:18 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Vadim Lobanov <vadim@cs.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Starting project.
Message-Id: <20040521204618.6a89ddf9.rddunlap@osdl.org>
In-Reply-To: <20040521201011.D8524-100000@attu4.cs.washington.edu>
References: <20040521201011.D8524-100000@attu4.cs.washington.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2004 20:22:15 -0700 (PDT) Vadim Lobanov <vadim@cs.washington.edu> wrote:

| Hello,
| 
| Up to now, I've been reading up on various outside sources about the 
| structure of the Linux kernel, as well as following the discussions on 
| this list. Though so far I've only had experience at writing userland 
| programs on *nixes, I've acquired a curiosity for the overall structure of 
| the kernel, the algorithms it uses, and its evolution over time. Though I 
| know the theory behind operating systems in general, I'd like to get some 
| hands-on practice. For this reason, I am curious if a list of pending 
| TODOs/projects relating to the kernel or drivers is maintained anywhere,
| such that I could pick a simple one to try to work on, for starters. After 
| all, the best way to learn is to dive right in. :)

It depends.  on your interest level, project goals(s)/size, etc.
BTW, please use 2.6.x for anything new that you do.

There are current iSCSI and Infiniband driver projects underway.
These are attempts to add fairly large, new drivers to the kernel.

For a list of smaller, get-your-feet-wet projects, you could consider
some of these:

- the current must-fix list, which is kept in the latest
	-mm tree patch; current file is here (but there is
	no permanent URL for it):
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm4/broken-out/must-fix.patch

the current kernel-janitors project TODO list:
http://janitor.kernelnewbies.org/TODO
(but check on their mailing list before taking one of these on)

Bug reports from the Stanford Checker project, but these are mostly
email postings*, not web postings:
http://metacomp.stanford.edu/

Bug reports from the Coverity people (like Checker):
http://www.coverity.com/main.html
but mostly email postings*

Bug reports from the OPERA project (similar to Checker, but from
UIUC):	http://carmen.cs.uiuc.edu/
but mostly email postings*

Current bugs in the kernel bugzilla database:
http://bugzilla.kernel.org/

Some projects maintain their own TODO list.  If there are some areas
that you are particularly interested in, check with them to see if
they have a TODO list.

--
~Randy
