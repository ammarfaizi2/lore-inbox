Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264293AbUCPRpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUCPRpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:45:13 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:3932 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264293AbUCPRoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:44:37 -0500
Date: Tue, 16 Mar 2004 09:43:29 -0800
To: Robert Picco <Robert.Picco@hp.com>, linux-kernel@vger.kernel.org
Cc: colpatch@us.ibm.com, mbligh@aracnet.com
Subject: Re: boot time node and memory limit options
Message-ID: <20040316174329.GA29992@sgi.com>
Mail-Followup-To: Robert Picco <Robert.Picco@hp.com>,
	linux-kernel@vger.kernel.org, colpatch@us.ibm.com, mbligh@aracnet.com
References: <4057392A.8000602@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4057392A.8000602@hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 12:28:10PM -0500, Robert Picco wrote:
> This patch supports three boot line options.  mem_limit limits the
> amount of physical memory.  node_mem_limit limits the amount of
> physical memory per node on a NUMA machine.  nodes_limit reduces the
> number of NUMA nodes to the value specified.  On a NUMA machine an
> eliminated node's CPU(s) are removed from the cpu_possible_map.  
> 
> The patch has been tested on an IA64 NUMA machine and uniprocessor X86
> machine.

I think this patch will be really useful.  Matt and Martin, does it look
ok to you?  Given that discontiguous support is pretty platform specific
right now, I thought it might be less code if it was done in arch/, but
a platform independent version is awfully nice...

Thanks,
Jesse
