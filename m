Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWHQTSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWHQTSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWHQTSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:18:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52888 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751239AbWHQTSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:18:15 -0400
Date: Thu, 17 Aug 2006 12:18:04 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, mingo@redhat.com, apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
Message-Id: <20060817121804.e140f19e.pj@sgi.com>
In-Reply-To: <20060817110317.A14787@unix-os.sc.intel.com>
References: <20060815175525.A2333@unix-os.sc.intel.com>
	<20060815212455.c9fe1e34.pj@sgi.com>
	<20060815214718.00814767.akpm@osdl.org>
	<20060816110357.B7305@unix-os.sc.intel.com>
	<20060817102030.f8c41330.pj@sgi.com>
	<20060817110317.A14787@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> Let me resist the temptation and not go into the definition of horsepower
> here. You can refer any dictionary.

Good point <grin>.

Horsepower is a measure of power, of energy over time, such as the
rate of providing or using electrical or mechanical energy.

So, with your suggestion of 'horsepower', are you saying that cpu_power
is a metric of such electrical or mechanical energy -- the peak or
average watts of the electricity consumed by the CPUs in a group?

Or is 'cpu_power' a metric of the computational capacity, such as
BogoMIPS provided by the CPUs in a group, such as I had presumed?

Hmmm ... apparently from your latest explanation, it's neither
of these.

Rather it's a metric of how many tasks to place in a group, due to
various capacities and constraints, such as computational power
(BogoMIPS) and electrical power (watts or horsepower).

Should 'cpu_power' be renamed to 'task_load' ?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
