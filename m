Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933336AbWKWJGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbWKWJGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933301AbWKWJGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:06:50 -0500
Received: from ns.suse.de ([195.135.220.2]:38544 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933340AbWKWJGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:06:49 -0500
Date: Thu, 23 Nov 2006 10:06:45 +0100
From: Andi Kleen <ak@suse.de>
To: Rohit Seth <rohitseth@google.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch4/4]: fake numa for x86_64 patches
Message-ID: <20061123090645.GE29738@bingen.suse.de>
References: <1164245696.29844.155.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164245696.29844.155.camel@galaxy.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_NUMA_EMU
> +char fake_numa[32] __initdata;

Where does that 32 come from? 
And why are you making a temporary global anyways?

-Andi
