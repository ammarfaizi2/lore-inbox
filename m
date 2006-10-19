Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946367AbWJSS5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946367AbWJSS5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946373AbWJSS5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:57:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44213 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946367AbWJSS5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:57:14 -0400
Date: Thu, 19 Oct 2006 11:56:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061019115652.562054ca.pj@sgi.com>
In-Reply-To: <4537BEDA.8030005@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<453750AA.1050803@yahoo.com.au>
	<20061019105515.080675fb.pj@sgi.com>
	<4537BEDA.8030005@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So ... where should it be done?
> 
> sched.c I suppose.

Are we discussing where the implementing code should go,
or where the isolated cpu map special file should be
exposed to user space?

And you didn't answer my other questions, such as:
 1) If your other patch to manipulate sched domains
    has code that belongs in kernel/cpuset.c, and
    special files that belong in /dev/cpuset, why
    shouldn't this one naturally go in the same places?
 2) Why ... why?  What would be better about sched.c
    and what's wrong with where it is (the code and
    the exposed file)?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
