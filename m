Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVKLAH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVKLAH0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 19:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKLAH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 19:07:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20962 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750792AbVKLAHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 19:07:25 -0500
Date: Fri, 11 Nov 2005 16:06:19 -0800
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: ashok.raj@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ak@muc.de, zwane@arm.linux.org.uk, rusty@rustycorp.com.au,
       vatsa@in.ibm.com, jschopp@austin.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: Documentation for CPU hotplug support
Message-Id: <20051111160619.13e0ccc8.pj@sgi.com>
In-Reply-To: <20051111072300.GY8977@localhost.localdomain>
References: <20051110075932.A16271@unix-os.sc.intel.com>
	<20051111072300.GY8977@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> It think it would be appropriate to stress that cpu_possible_map must
> not change after boot.

This and some other aspects of cpu_online_map, cpu_possible_map and
cpu_present_map are documented in a long comment in cpumask.h.

You are welcome to steal from or reference that comment.

You are also welcome to fix up any lies you find in that comment ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
