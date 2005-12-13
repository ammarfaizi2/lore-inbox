Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVLMBru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVLMBru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 20:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVLMBru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 20:47:50 -0500
Received: from fmr24.intel.com ([143.183.121.16]:52922 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932332AbVLMBrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 20:47:49 -0500
Date: Mon, 12 Dec 2005 17:47:20 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: [PATCH 0/3]i386,x86-64 (take 2) Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051212174720.A10234@unix-os.sc.intel.com>
References: <20051208181040.C32524@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090003460.26307@montezuma.fsmlabs.com> <20051209044938.A26619@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090933540.26307@montezuma.fsmlabs.com> <20051209095243.A22139@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051209095243.A22139@unix-os.sc.intel.com>; from venkatesh.pallipadi@intel.com on Fri, Dec 09, 2005 at 09:52:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am sending an updated patchset.

(The original patchset 
http://www.ussg.iu.edu/hypermail/linux/kernel/0512.1/0300.html)

The fixes in the updated patchset
- Typo with ipi_to_APIC_timer call fixed
- The issues with suspend-resume (offline-online) handled.

Thanks,
Venki
