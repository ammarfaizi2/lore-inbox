Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753751AbWKHE27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbWKHE27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 23:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbWKHE27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 23:28:59 -0500
Received: from mga07.intel.com ([143.182.124.22]:19367 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1753751AbWKHE26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 23:28:58 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,399,1157353200"; 
   d="scan'208"; a="142812666:sNHT17811815"
Date: Tue, 7 Nov 2006 20:06:34 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, ak@suse.de,
       shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com
Subject: Re: [patch 0/4] i386, x86_64: fix the irqbalance quirk for E7520/E7320/E7525
Message-ID: <20061107200634.B5933@unix-os.sc.intel.com>
References: <20061107173306.C3262@unix-os.sc.intel.com> <20061107200702.8abac851.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061107200702.8abac851.akpm@osdl.org>; from akpm@osdl.org on Tue, Nov 07, 2006 at 08:07:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 08:07:02PM -0800, Andrew Morton wrote:
> arch/i386/kernel/built-in.o: In function `verify_quirk_intel_irqbalance':
> arch/i386/kernel/quirks.c:19: undefined reference to `genapic'
> arch/i386/kernel/quirks.c:19: undefined reference to `apic_default'
> arch/i386/kernel/built-in.o: In function `__cpu_up':
> arch/i386/kernel/smpboot.c:1487: undefined reference to `genapic'
> arch/i386/kernel/smpboot.c:1487: undefined reference to `apic_default'
> 
> The dependencies in the code which you're touching here are really really
> complex and fragile.  One needs to review the change very carefully and
> test it exhaustively.

oops. I did compile and boot with 6 x86/x86_64 configs.. Seems something
is broken in my git test tree. Let me fix and getback to you.

thanks,
suresh
