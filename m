Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVENRvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVENRvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 13:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVENRvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 13:51:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7395 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262813AbVENRvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 13:51:06 -0400
Date: Sat, 14 May 2005 10:50:25 -0700
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: dipankar@in.ibm.com, dino@in.ibm.com, ntl@pobox.com, akpm@osdl.org,
       lse-tech@lists.sourceforge.net, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050514105025.5e6160ee.pj@sgi.com>
In-Reply-To: <20050514160945.GA32720@in.ibm.com>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
	<20050513123216.GB3968@in.ibm.com>
	<20050513172540.GA28018@in.ibm.com>
	<20050513125953.66a59436.pj@sgi.com>
	<20050513202058.GE5044@in.ibm.com>
	<20050513135233.6eba49df.pj@sgi.com>
	<20050513210251.GI5044@in.ibm.com>
	<20050513195851.5d6665d0.pj@sgi.com>
	<20050514160945.GA32720@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa wrote:
> In fact, some of these and other set_cpus_allowed woes were discussed here

So indeed, there are issues with lock_cpu_hotplug, sched_setaffinity,
set_cpus_allowed() and tsk->cpus_allowed and cpu_online_map and such.

Indeed, the tar pit is deeper than I imagined.

Ok ... I will quietly sneak out the back door and leave this to the experts.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
