Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWHDSjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWHDSjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWHDSjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:39:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:29390 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751419AbWHDSjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:39:49 -0400
Subject: Re: [PATCH 01/10] -mm  clocksource: increase initcall priority
From: john stultz <johnstul@us.ibm.com>
To: dwalker@mvista.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060804032510.405094000@mvista.com>
References: <20060804032414.304636000@mvista.com>
	 <20060804032510.405094000@mvista.com>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 11:39:44 -0700
Message-Id: <1154716784.5327.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, sorry for not reviewing these patches sooner. Its been
sitting in on my todo list for way too long. Thanks for continuing to
push it despite my slowness.

On Thu, 2006-08-03 at 20:24 -0700, dwalker@mvista.com wrote:
> plain text document attachment (clocksource_init_call.patch)
> Since it's likely that this interface would get used during bootup 
> I moved all the clocksource registration into the postcore initcall. 
> This also eliminated some clocksource shuffling during bootup.

This one looks interesting. As long as it works as advertised I'm fine
with it, although I worry it might bring up some initialization ordering
issues. It will need some careful testing in -mm.

thanks
-john

