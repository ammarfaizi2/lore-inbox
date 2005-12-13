Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVLMDIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVLMDIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 22:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVLMDIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 22:08:30 -0500
Received: from mail.suse.de ([195.135.220.2]:21200 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932377AbVLMDI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 22:08:29 -0500
Date: Tue, 13 Dec 2005 04:08:21 +0100
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 0/3]i386,x86-64 (take 2) Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051213030821.GF23384@wotan.suse.de>
References: <20051208181040.C32524@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090003460.26307@montezuma.fsmlabs.com> <20051209044938.A26619@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090933540.26307@montezuma.fsmlabs.com> <20051209095243.A22139@unix-os.sc.intel.com> <20051212174720.A10234@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212174720.A10234@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 05:47:20PM -0800, Pallipadi, Venkatesh wrote:
> 
> I am sending an updated patchset.
> 
> (The original patchset 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0512.1/0300.html)
> 
> The fixes in the updated patchset
> - Typo with ipi_to_APIC_timer call fixed
> - The issues with suspend-resume (offline-online) handled.

Looks all good. I will merge it up into my tree thanks.

Ok your globals are too long :)

-Andi
