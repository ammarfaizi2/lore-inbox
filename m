Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWFLRLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWFLRLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWFLRLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:11:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40848 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750965AbWFLRLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:11:46 -0400
Date: Mon, 12 Jun 2006 10:11:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: broken local_t on i386
In-Reply-To: <200606121906.28692.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606121008340.19562@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606121848.05438.ak@suse.de>
 <Pine.LNX.4.64.0606120950280.19309@schroedinger.engr.sgi.com>
 <200606121906.28692.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Andi Kleen wrote:

> Also on non preemptive kernels - which are the majority - it's a single
> instruction on x86. I guess preempt users can live with a bit more
> overhead ... 

I hope you will be fixing the cpu_local_* macros for i386 and x86_64 and 
add some appropriate docs? Are there any existing uses in the kernel?

