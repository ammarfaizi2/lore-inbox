Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVCPTMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVCPTMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVCPTLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:11:06 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:30592 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262733AbVCPTIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:08:32 -0500
In-Reply-To: <20050316190611.GA27945@infradead.org>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <20050316143130.GA21959@infradead.org> <Pine.LNX.4.61.0503160959530.4104@chimarrao.boston.redhat.com> <20050316181042.GA26788@infradead.org> <521a4568db3e955cb245d10aaba2d3ce@cl.cam.ac.uk> <20050316190611.GA27945@infradead.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0d70200856fbba2e3fa027d2a66dd2cb@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, Ian.Pratt@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>, kurt@garloff.de,
       Christian.Limpach@cl.cam.ac.uk
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Date: Wed, 16 Mar 2005 19:11:24 +0000
To: Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Mar 2005, at 19:06, Christoph Hellwig wrote:

>> The AGP driver is only configurable for ppc32, alpha, x86, x86_64 and
>> ia64, all of which have virt_to_bus.
>
> and ppc64 now, which doesn't.

Sounds like the new DMA-mapping interface is the way to go then.

  -- Keir

