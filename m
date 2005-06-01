Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVFAXu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVFAXu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVFAXq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:46:56 -0400
Received: from fsmlabs.com ([168.103.115.128]:17546 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261509AbVFAXqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:46:25 -0400
Date: Wed, 1 Jun 2005 17:49:52 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Gregor Jasny <gjasny@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cyrix 6x86L does not get identified by Linux 2.6
In-Reply-To: <200506010036.27957.gjasny@web.de>
Message-ID: <Pine.LNX.4.61.0506011749220.8323@montezuma.fsmlabs.com>
References: <200506010036.27957.gjasny@web.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Gregor Jasny wrote:

> on my Cyrix 6x86L (notice the L) I've got the problem that it doesn't get 
> identified as a Cyrix processor. Instead it is treated as a common 486.
> 
> I think the problem is that the cpuid feature is not enabled after booting. So 
> init_cyrix which enables the cpuid feature is never called.
> 
> As a bad hack I've set the this_cpu pointer to cyrix in 
> common.c:identify_cpu():
> 
> this_cpu = cpu_devs[X86_VENDOR_CYRIX];
> 
> Who is responsible for x86 CPU detection?

Can you identify which kernel version broke this for you?

Thanks,
	Zwane

