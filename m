Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268693AbUIXLj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268693AbUIXLj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268695AbUIXLj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:39:29 -0400
Received: from holomorphy.com ([207.189.100.168]:16863 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268693AbUIXLj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:39:28 -0400
Date: Fri, 24 Sep 2004 04:39:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com
Subject: Re: [Patch 1/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
Message-ID: <20040924113910.GE9106@holomorphy.com>
References: <2HSdY-7dr-3@gated-at.bofh.it> <m3mzzf99vz.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3mzzf99vz.fsf@averell.firstfloor.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh Siddha <suresh.b.siddha@intel.com> writes:
>> Set TARGET_CPUS on x86_64 to cpu_online_map. This brings the code inline
>> with x86 mach-default

On Fri, Sep 24, 2004 at 01:36:16PM +0200, Andi Kleen wrote:
> And breaks compilation with MSI on. Here's a hackish workaround
> that will probably fail with >64 CPUs.
> Proper fix would be to fix MSI to deal with cpumasks properly

I'll sweep this shortly (I must have forgotten to push the results from
last time), sorry for the delay.


-- wli
