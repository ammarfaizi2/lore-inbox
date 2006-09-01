Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWIAEq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWIAEq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWIAEq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:46:59 -0400
Received: from xenotime.net ([66.160.160.81]:17796 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932129AbWIAEq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:46:58 -0400
Date: Thu, 31 Aug 2006 21:50:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Query: DMA Engine support in make oldconfig
Message-Id: <20060831215022.4f2cb9c7.rdunlap@xenotime.net>
In-Reply-To: <7vcff2l2q7s1mqjlb3g35dodgrcmlba57q@4ax.com>
References: <7vcff2l2q7s1mqjlb3g35dodgrcmlba57q@4ax.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 14:18:23 +1000 Grant Coady wrote:

> Hi there,
> 
> make oldconfig from 2.6.17.11 to 2.6.18-rc5: This help text doesn't say 
> what the right choice should be?  Unclear to me anyway, so I take the 
> default, is that bad for an x86 32-bit box?
> "
> * DMA Engine support
> *
> Support for DMA engines (DMA_ENGINE) [N/y/?] (NEW) ?
> 
> DMA engines offload copy operations from the CPU to dedicated
> hardware, allowing the copies to happen asynchronously.
> "

I would guess that you don't have any hardware that is
supported, so enabling it will just use a little memory
(or at least that's all it should do -- not hurt anything
else).

---
~Randy
