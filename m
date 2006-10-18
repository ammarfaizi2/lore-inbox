Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWJRHOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWJRHOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWJRHOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:14:39 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23976 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750716AbWJRHOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:14:38 -0400
Date: Wed, 18 Oct 2006 00:14:24 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: dino@in.ibm.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, mbligh@google.com, rohitseth@google.com,
       dipankar@in.ibm.com, nickpiggin@yahoo.com.au
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061018001424.0c22a64b.pj@sgi.com>
In-Reply-To: <20061017192547.B19901@unix-os.sc.intel.com>
References: <20061017192547.B19901@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyone would like to fix it up?

Hotplug is not high on my priority list.

I do what I can in my spare time to avoid having cpusets or hotplug
break each other.

Besides, I'm not sure I'd be able.  I've gotten to the point where I am
confident I can make simple changes at the edges, such as mimicing the
sched domain side affects of the cpu_exclusive flag with my new
sched_domain flag.  But that's near the current limit of my sched domain
writing skills.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
