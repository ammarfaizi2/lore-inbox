Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVLPUW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVLPUW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 15:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVLPUW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 15:22:57 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:49618 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751339AbVLPUW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 15:22:56 -0500
Date: Fri, 16 Dec 2005 12:22:37 -0800
From: Paul Jackson <pj@sgi.com>
To: paulmck@us.ibm.com
Cc: akpm@osdl.org, dada1@cosmosbay.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, Simon.Derr@bull.net, ak@suse.de,
       clameter@sgi.com
Subject: Re: [PATCH 02/04] Cpuset: use rcu directly optimization
Message-Id: <20051216122237.e29d3cb0.pj@sgi.com>
In-Reply-To: <20051216175540.GB24876@us.ibm.com>
References: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com>
	<20051214084037.21054.4269.sendpatchset@jackhammer.engr.sgi.com>
	<20051216175540.GB24876@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> Looks good to me from an RCU perspective!

Thanks for looking at it.

> Moving from synchronize_rcu() to call_rcu() would be tricky,

Yes, likely so.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
