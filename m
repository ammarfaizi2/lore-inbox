Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVFBUNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVFBUNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVFBUL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:11:59 -0400
Received: from fsmlabs.com ([168.103.115.128]:35763 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261233AbVFBUHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:07:35 -0400
Date: Thu, 2 Jun 2005 14:10:47 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [patch 5/5] x86_64: Provide ability to choose using shortcuts
 for IPI in flat mode.
In-Reply-To: <20050602130112.159708000@araj-em64t>
Message-ID: <Pine.LNX.4.61.0506021408080.3157@montezuma.fsmlabs.com>
References: <20050602125754.993470000@araj-em64t> <20050602130112.159708000@araj-em64t>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Ashok Raj wrote:

> This patch provides an option to switch broadcast or use mask version 
> for sending IPI's. If CONFIG_HOTPLUG_CPU is defined, we choose not to 
> use broadcast shortcuts by default, otherwise we choose broadcast mode
> as default.
> 
> both cases, one can change this via startup cmd line option, to choose
> no-broadcast mode.
> 
> 	no_ipi_broadcast=1
> 
> This is provided on request from Andi Kleen, since he doesnt agree with 
> replacing IPI shortcuts as a solution for CPU hotplug. Without removing
> broadcast IPI's, it would mean lots of new code for __cpu_up() path, 
> which would acheive the same results.
> 
> I will send the primitive interface next as a separate patch from this
> patch set.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>

Have you already submitted the i386 version? I think it's a sane fix.

Thanks,
	Zwane
