Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266718AbUBETXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUBETXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:23:43 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:9210 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S266755AbUBETXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:23:34 -0500
Date: Thu, 5 Feb 2004 12:23:28 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, greg@kroah.com
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Message-ID: <20040205192328.GA25331@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040205014405.5a2cf529.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205014405.5a2cf529.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05 2004, at 01:44, Andrew Morton was caught saying:
> 
> +dmapool-needs-pci.patch
> 
>  The dmapool code doesn't build with CONFIG_PCI=n.  But it should.  Needs
>  work.

Hmm..that defeats the purpose of making it generic. :(

I was able to build w/o PCI for an SA1100 platform, so I'm assuming 
this is an x86 issue.  I'll dig into it when I get some free time.
I only have x86 and arm toolchains, so can folks on other non-PCI
architectures remove the dmapool-needs-pci.patch and try building 
w/o PCI.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
