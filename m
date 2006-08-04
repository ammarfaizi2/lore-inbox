Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWHDLhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWHDLhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 07:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWHDLhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 07:37:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39637 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932463AbWHDLhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 07:37:07 -0400
Date: Fri, 4 Aug 2006 17:11:09 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu controller
Message-ID: <20060804114109.GA28988@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154684950.23655.178.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 10:49:10AM +0100, Alan Cox wrote:
> I think the risk is that OpenVZ has all the controls and resource
> managers we need, while CKRM is still more research-ish. I find the
> OpenVZ code much clearer, cleaner and complete at the moment, although
> also much more conservative in its approach to solving problems.

I think it would be nice to compare first the features provided by ckrm and 
openvz at some point and agree upon the minimum common features we need to have 
as we go forward. For instance I think Openvz assumes that tasks do
not need to move between containers (task-groups), whereas ckrm provides this
flexibility for workload management. This may have some effect on the 
controller/interface design, no?

-- 
Regards,
vatsa
