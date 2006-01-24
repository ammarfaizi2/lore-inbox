Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWAXC7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWAXC7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 21:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWAXC7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 21:59:17 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9676 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030301AbWAXC7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 21:59:17 -0500
Subject: Re: [PATCH -mm] Time: Keep clock=pmtmr functional, but depricated
From: Lee Revell <rlrevell@joe-job.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1138071141.15682.81.camel@cog.beaverton.ibm.com>
References: <1138071141.15682.81.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 21:59:14 -0500
Message-Id: <1138071554.2771.45.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 18:52 -0800, john stultz wrote:
> With the new clocksource code, the ACPI PM timer is now called acpi_pm.
> This has confused users that are familiar w/ using the clock=pmtmr boot
> option.
> 
> This patch insures that the clock=pmtmr boot option will still function,
> but will warn the users to use clocksource=acpi_pm in the future.

What about the other clock= boot options?

I believe that changing their behavior counts as "breaking userspace".

Lee

