Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751718AbVLGS36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbVLGS36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbVLGS36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:29:58 -0500
Received: from ns.suse.de ([195.135.220.2]:17105 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751715AbVLGS36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:29:58 -0500
Date: Wed, 7 Dec 2005 19:29:55 +0100
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Chris McDermott <lcm@us.ibm.com>, vojtech@suse.cz
Subject: Re: [RFC][PATCH] x86_64:  Fix collision between pmtimer and pit/hpet timekeeping
Message-ID: <20051207182955.GC11190@wotan.suse.de>
References: <1133931639.10613.39.camel@cog.beaverton.ibm.com> <20051207175338.GB11190@wotan.suse.de> <1133978430.18188.3.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133978430.18188.3.camel@leatherman>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 10:00:30AM -0800, john stultz wrote:
> Would you then want to move all systems to use the non-legacy HPET
> interrupt?

You mean all HPET systems? Yes that might be a good idea unless
someone else knows about problems with this. Interrupt 0 seems
to be shakey on many systems so not using it is probably
a good idea.

-Andi

