Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424022AbWKIPVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424022AbWKIPVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424030AbWKIPVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:21:40 -0500
Received: from cantor2.suse.de ([195.135.220.15]:8398 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1424022AbWKIPVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:21:39 -0500
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 0/4] i386, x86_64: fix the irqbalance quirk for E7520/E7320/E7525 - V2
Date: Thu, 9 Nov 2006 14:20:39 +0100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, ashok.raj@intel.com, greg@kroah.com
References: <20061108172017.A10294@unix-os.sc.intel.com>
In-Reply-To: <20061108172017.A10294@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611091420.40282.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 November 2006 02:20, Siddha, Suresh B wrote:
> Mechanism of selecting physical mode in genapic when cpu hotplug is enabled
> on x86_64, broke the quirk(quirk_intel_irqbalance()) introduced for working
> around the transposing interrupt message errata in E7520/E7320/E7525
> (revision ID 0x9 and below. errata #23 in
> http://download.intel.com/design/chipsets/specupdt/30304203.pdf).
>
> This errata requires the mode to be in logical flat, so that interrupts
> can be directed to more than one cpu(and thus use hardware IRQ balancing
> enabled by BIOS on these platforms).

Fine by me. But can you fix the compilation issues Andrew found and resend
please?

-Andi
