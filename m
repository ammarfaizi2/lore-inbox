Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVHPXr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVHPXr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVHPXr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:47:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35462 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750742AbVHPXr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:47:26 -0400
Date: Wed, 17 Aug 2005 01:47:25 +0200
From: Andi Kleen <ak@suse.de>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwane@arm.linux.org.uk
Subject: Re: [PATCH 8/14] i386 / Add a per cpu gdt accessor
Message-ID: <20050816234725.GI27628@wotan.suse.de>
References: <200508110456.j7B4ue56019587@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508110456.j7B4ue56019587@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 09:56:40PM -0700, zach@vmware.com wrote:
> Add an accessor function for getting the per-CPU gdt.  Callee must already
> have the CPU.

What is the accessor good for? 

It looks just like code obfuscation to me.

-Andi
