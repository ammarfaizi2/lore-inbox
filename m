Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWHYGa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWHYGa3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWHYGa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:30:29 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:22711 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964849AbWHYGa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:30:28 -0400
Date: Fri, 25 Aug 2006 11:59:41 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ego@in.ibm.com, Ingo Molnar <mingo@elte.hu>, rusty@rustcorp.com.au,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@linux.intel.com, davej@redhat.com, dipankar@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 3/4] (Refcount + Waitqueue) implementation for cpu_hotplug "locking"
Message-ID: <20060825062941.GA21940@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060824103233.GD2395@in.ibm.com> <20060824111440.GA19248@elte.hu> <20060824122808.GH2395@in.ibm.com> <20060824122527.GA28275@elte.hu> <20060824125813.GE25452@in.ibm.com> <20060825060425.GB6322@in.ibm.com> <44EE9671.7010804@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EE9671.7010804@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 04:19:29PM +1000, Nick Piggin wrote:
> Well you would just have a depth count in the task_struct... 

That (if can have) would make life so easy :)

-- 
Regards,
vatsa
