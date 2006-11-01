Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946745AbWKAJvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946745AbWKAJvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946744AbWKAJvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:51:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22710 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946742AbWKAJvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:51:09 -0500
Date: Wed, 1 Nov 2006 01:50:30 -0800
From: Paul Jackson <pj@sgi.com>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: menage@google.com, dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061101015030.451b7a86.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu>
References: <20061030103356.GA16833@in.ibm.com>
	<6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	<20061030031531.8c671815.pj@sgi.com>
	<6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
	<20061030042714.fa064218.pj@sgi.com>
	<6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
	<20061030123652.d1574176.pj@sgi.com>
	<6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	<Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:
>  - While the process containers are only single-level, the controllers are
>    _inherently_ hierarchial just like a filesystem.  So it appears that

Cpusets certainly enjoys what I would call hierarchical process
containers.  I can't tell if your flat container space is just
a "for instance", or you're recommending we only have a flat
container space.

If the later, I disagree.

> So it appears
>   that the manipulation of containers would most effectively be done from
>   userspace by a syscall approach.

Yup - sure sounds like you're advocating a flat container space
accessed by system calls.

Sure doesn't sound right to me.  I like hierarchical containers,
accessed via like a file system.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
