Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVDERne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVDERne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVDERne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:43:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:18095 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261820AbVDERQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:16:20 -0400
Date: Tue, 5 Apr 2005 19:16:15 +0200
From: Andi Kleen <ak@suse.de>
To: Jason Davis <jason@righTThere.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Jason Davis <jason.davis@unisys.com>
Subject: Re: [PATCH] 2.6.12-rc1-mm4 x86_64 genapic update
Message-ID: <20050405171615.GA11088@wotan.suse.de>
References: <20050401173727.GA26638@righTThere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050401173727.GA26638@righTThere.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 12:37:27PM -0500, Jason Davis wrote:
> Hello,
> 
> x86_64 genapic mechanism should be aware of machines that use physical APIC 
> mode regardless of how many clusters/processors are detected. ACPI 3.0 FADT 
> makes this determination very simple by providing a feature flag 
> "force_apic_physical_destination_mode" to state whether the machine 
> unconditionally uses physical APIC mode. Unisys' next generation x86_64 
> ES7000 will need to utilize this FADT feature flag in order to boot the 
> x86_64 kernel in the correct APIC mode. This patch has been tested on both 
> x86_64 commodity and ES7000 boxes.

Patch is ok for me.

-Andi
