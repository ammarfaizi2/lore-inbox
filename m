Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264026AbUE1Vuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbUE1Vuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUE1VsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:48:06 -0400
Received: from zero.aec.at ([193.170.194.10]:27910 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262431AbUE1VpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:45:22 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org, jun.nakajima@intel.com
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <20Uhn-7bP-11@gated-at.bofh.it> <20UqZ-7i7-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 28 May 2004 23:45:11 +0200
In-Reply-To: <20UqZ-7i7-5@gated-at.bofh.it> (Martin J. Bligh's message of
 "Fri, 28 May 2004 20:40:09 +0200")
Message-ID: <m3hdu08bvc.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> Whatever we do ... all arches are going to need to provide a way to direct
> interrupts to a certain CPU, or group thereof. Can they all do that already?
> I'll confess to not having looked at non-i386 arches. And are others as
> brain damaged as the P4? or do they do something round-robin by default?

I wouldn't really blame the the P4, it's the IO-APICs in the chipsets
that balance or not balance.

At least the AMD chipsets found in most Opteron boxes need software 
balancing too.

-Andi

