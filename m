Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWIZUPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWIZUPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWIZUPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:15:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:63382 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964778AbWIZUPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:15:54 -0400
Subject: Re: 2.6.18 Nasty Lockup
From: john stultz <johnstul@us.ibm.com>
To: Greg Schafer <gschafer@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060926123640.GA7826@tigers.local>
References: <20060926123640.GA7826@tigers.local>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 13:15:51 -0700
Message-Id: <1159301752.17071.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 22:36 +1000, Greg Schafer wrote:
> Hi
> 
> This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> completely dead machine with only option the reset button. Usually happens
> within a couple of minutes of desktop use but is 100% reproducible. Problem
> is still there in a fresh checkout of current Linus git tree (post 2.6.18).
> 
> Dual Athlon-MP 2200's on a Tyan S2466 Tiger MPX. Config attached.
> 
> I used git-bisect and arrived at the apparent culprit below. Anything else I
> should do to gather more info?

Quick test: Does enabling CONFIG_ACPI change the behavior?

thanks
-john


