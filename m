Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWCXHNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWCXHNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWCXHNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:13:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:51937 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751392AbWCXHNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:13:12 -0500
Date: Fri, 24 Mar 2006 12:42:55 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Question on build_sched_domains
Message-ID: <20060324071255.GB22150@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060324025834.GD8903@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324025834.GD8903@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 08:28:34AM +0530, Srivatsa Vaddagiri wrote:
> Taking the example of 4 node system which are in the same
> sched_domain_node_span(), I see that we end up allocating 16
> times (when 4 would have sufficed?).

Maybe this is it to avoid touching same memory from different nodes?

-- 
Regards,
vatsa
