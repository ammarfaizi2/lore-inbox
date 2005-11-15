Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbVKOOsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVKOOsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVKOOs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:48:29 -0500
Received: from ns.suse.de ([195.135.220.2]:54419 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751436AbVKOOs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:48:29 -0500
From: Andi Kleen <ak@suse.de>
To: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 01/05] NUMA: Generic code
Date: Tue, 15 Nov 2005 15:15:04 +0100
User-Agent: KMail/1.8.2
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, pj@sgi.com
References: <20051110090920.8083.54147.sendpatchset@cherry.local> <200511110516.37980.ak@suse.de> <aec7e5c30511150034t5ff9e362jb3261e2e23479b31@mail.gmail.com>
In-Reply-To: <aec7e5c30511150034t5ff9e362jb3261e2e23479b31@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511151515.05201.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2005 09:34, Magnus Damm wrote:

> 
> My plan with breaking out the NUMA emulation code was to merge my i386
> stuff with the x86_64 code, but as you say - it might be overkill.
> 
> What do you think about the fact that real NUMA nodes now can be
> divided into several smaller nodes?

Is it really needed? I never needed it.  Normally numa emulation 
is just for basic numa testing, and for that just an independent
split is good enough.

-Andi
