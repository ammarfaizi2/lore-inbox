Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVKKERt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVKKERt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 23:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVKKERt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 23:17:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:46013 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932339AbVKKERs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 23:17:48 -0500
From: Andi Kleen <ak@suse.de>
To: Magnus Damm <magnus@valinux.co.jp>
Subject: Re: [PATCH 01/05] NUMA: Generic code
Date: Fri, 11 Nov 2005 05:16:35 +0100
User-Agent: KMail/1.8
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, pj@sgi.com
References: <20051110090920.8083.54147.sendpatchset@cherry.local> <20051110090925.8083.45887.sendpatchset@cherry.local>
In-Reply-To: <20051110090925.8083.45887.sendpatchset@cherry.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511110516.37980.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 November 2005 10:08, Magnus Damm wrote:
> Generic CONFIG_NUMA_EMU code.
>
> This patch adds generic NUMA emulation code to the kernel. The code
> provides the architectures with functions that calculate the size of
> emulated nodes, together with configuration stuff such as Kconfig and
> kernel command line code.

IMHO making it generic and bloated like this is total overkill
for this simple debugginghack. I think it is better to keep 
it simple and hiden it in a architecture specific dark corners, not expose it 
like this.

I think the patch shouldn't be applied.

-Andi
