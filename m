Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752297AbWCPJmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbWCPJmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 04:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbWCPJmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 04:42:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752299AbWCPJmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 04:42:00 -0500
Date: Thu, 16 Mar 2006 01:39:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rdreier@cisco.com, bos@pathscale.com, Hugh@veritas.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
Message-Id: <20060316013914.430a2542.akpm@osdl.org>
In-Reply-To: <44190934.7040207@yahoo.com.au>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org>
	<ada8xrbszmx.fsf@cisco.com>
	<20060315221716.19a92762.akpm@osdl.org>
	<44190934.7040207@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> 
>  > vm_insert_page() mucks around with rmap-named functions which don't
>  > actually do rmap
> 
>  What functions are those? I don't see.
> 
>  > and sports apparently-incorrect comments wrt
>  > PageReserved().
> 
>  What's the comment? Are we looking at the same vm_insert_page?

vm_insert_page() calls insert_page().
