Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVKPHs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVKPHs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbVKPHs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:48:57 -0500
Received: from mx1.suse.de ([195.135.220.2]:51174 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030206AbVKPHs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:48:56 -0500
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, pj@sgi.com, werner@almesberger.net
Subject: Re: [PATCH 01/05] NUMA: Generic code
References: <20051110090920.8083.54147.sendpatchset@cherry.local>
	<200511110516.37980.ak@suse.de>
	<aec7e5c30511150034t5ff9e362jb3261e2e23479b31@mail.gmail.com>
	<200511151515.05201.ak@suse.de>
	<aec7e5c30511152122w70703fbfl98bd377fb6fb9af4@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 16 Nov 2005 08:48:39 +0100
In-Reply-To: <aec7e5c30511152122w70703fbfl98bd377fb6fb9af4@mail.gmail.com>
Message-ID: <p73sltxowx4.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> writes:
> 
> For testing, your NUMA emulation code is perfect IMO. But for memory
> resource control your NUMA emulation code may be too simple.
> 
> With my patch, CONFIG_NUMA_EMU provides a way to partition a machine
> into several smaller nodes, regardless if the machine is using NUMA or
> not.
> 
> This NUMA emulation code together with CPUSETS could be seen as a
> simple alternative to the memory resource control provided by CKRM.

I believe Werner tried to use it at some point for that and it just
didn't work very well. So it doesn't seem to be very useful for
that usecase.

-Andi
