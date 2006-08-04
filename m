Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWHDGQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWHDGQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 02:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWHDGQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 02:16:37 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:11232 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030280AbWHDGQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 02:16:36 -0400
Date: Thu, 3 Aug 2006 23:16:04 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
Message-Id: <20060803231604.f7920683.pj@sgi.com>
In-Reply-To: <20060803230225.f5bb7860.pj@sgi.com>
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
	<20060803230225.f5bb7860.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
> I haven't read it yet, but I will likely agree that
> this is an abuse of cpusets.

This likely just drove Srivatsa up a wall (sorry), as my comments
in the earlier thread he referenced:

  http://lkml.org/lkml/2005/9/26/58

enthusiastically supported adding a cpu controller interface to cpusets.

We need to think through what are the relations between CKRM
controllers, containers and cpusets.  But I don't think that
people will naturally want to manage CKRM controllers via cpusets.
That sounds odd to me now.  My earlier enthusiasm for it seems
wrong to me now.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
