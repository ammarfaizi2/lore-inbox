Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVFBVEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVFBVEj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFBVC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:02:58 -0400
Received: from fsmlabs.com ([168.103.115.128]:48563 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261306AbVFBULJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:11:09 -0400
Date: Thu, 2 Jun 2005 14:14:28 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [patch 1/5] x86_64: Change init sections for CPU hotplug support
In-Reply-To: <20050602130111.694382000@araj-em64t>
Message-ID: <Pine.LNX.4.61.0506021413330.3157@montezuma.fsmlabs.com>
References: <20050602125754.993470000@araj-em64t> <20050602130111.694382000@araj-em64t>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Ashok Raj wrote:

> This patch adds __cpuinit and __cpuinitdata sections that need to exist
> past boot to support cpu hotplug.
> 
> Caveat: This is done *only* for EM64T CPU Hotplug support, on request from
> Andi Kleen. Much of the generic hotplug code in kernel, and none of the 
> other archs that support CPU hotplug today, i386, ia64, ppc64, s390 and
> parisc dont mark sections with __cpuinit, but only mark them as __devinit, 
> and __devinitdata.
> 
> If someone is motivated to change generic code, we need to make sure all
> existing hotplug code does not break, on other arch's that dont use 
> __cpuinit, and __cpudevinit.

I'll do i386.

Thanks,
	Zwane

