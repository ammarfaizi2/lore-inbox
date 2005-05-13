Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVEMVR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVEMVR7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVEMVFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:05:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:2778 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262551AbVEMVEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:04:24 -0400
Date: Sat, 14 May 2005 02:32:51 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: vatsa@in.ibm.com, dino@in.ibm.com, ntl@pobox.com, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050513210251.GI5044@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050513123216.GB3968@in.ibm.com> <20050513172540.GA28018@in.ibm.com> <20050513125953.66a59436.pj@sgi.com> <20050513202058.GE5044@in.ibm.com> <20050513135233.6eba49df.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513135233.6eba49df.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 01:52:33PM -0700, Paul Jackson wrote:
> > No. 
> 
> What part of what I wrote are you saying "No" to?

The question right above "No" :)

> 
> And what does that have to do with the two different
> locking mechanisms for hotplug?

Because lock_cpu_hotplug() isn't a lock just for cpu_online_map.

I think we need better in-tree documentation of cpu hotplug locking.
For now most of the descriptions are in conversations between
Rusty and Vatsa in linux hotplug cpu support mailing list
while they were designing it.

Thanks
Dipankar
