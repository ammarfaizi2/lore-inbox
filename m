Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVK1FeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVK1FeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 00:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVK1FeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 00:34:06 -0500
Received: from ns.suse.de ([195.135.220.2]:8882 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751151AbVK1FeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 00:34:05 -0500
Date: Mon, 28 Nov 2005 06:33:59 +0100
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Raj, Ashok" <ashok.raj@intel.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] i386/x86_64: Don't IPI to offline cpus on shutdown
Message-ID: <20051128053359.GM20775@brahms.suse.de>
References: <Pine.LNX.4.61.0511270115020.20046@montezuma.fsmlabs.com> <20051127135833.GH20775@brahms.suse.de> <m1wtiufa9z.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.61.0511270836120.20046@montezuma.fsmlabs.com> <m1psolfqvt.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psolfqvt.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like the obviously correct fix is to only call
> machine_shutdown when pm_power_off is defined.  Doing
> that will make Andi's assumption about not scheduling
> true and generally simplify what must be supported.

Looks like a reasonable fix. Thanks.

-Andi
