Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVEMMEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVEMMEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 08:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVEMME1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 08:04:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3998 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262343AbVEMMEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 08:04:23 -0400
Date: Fri, 13 May 2005 17:45:20 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Nathan Lynch <ntl@pobox.com>, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, nickpiggin@yahoo.com.au,
       vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050513121520.GA3968@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050511134235.5cecf85c.pj@sgi.com> <20050512151048.GA3901@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512151048.GA3901@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 08:40:48PM +0530, Dinakar Guniguntala wrote:
> 
> I really havent had a chance to investigate whats going on, should be 
> able to > do that tomorrow. Here is the patch I tried, my .config and 
> scripts

Ok I confirmed that this is a hotplug bug. This problem is hit by turning 
off cpusets with only hotplug and preempt on. It happens in the latest mm 
as well (2.6.12-rc4-mm1)

I will not be looking into this right now, I can provide details to
anyone interested

	-Dinakar
