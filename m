Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264555AbTFEJcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 05:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTFEJcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 05:32:04 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:27330 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264555AbTFEJcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 05:32:03 -0400
Subject: Re: Another must-fix: sbp2 and firewire hard disk crashes hard.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1054770509.1198.79.camel@torrey.et.myrio.com>
References: <1054770509.1198.79.camel@torrey.et.myrio.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054800210.700.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Jun 2003 10:03:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 01:48, Torrey Hoffman wrote:
> This must be something about my particular hardware/software
> configuration or more people would be reporting it.   
> 
> I will try to nail down the problem, but as soon as the SBP2 driver in
> 2.5.(recent) sees my firewire drive, either during kernel boot or later
> if I turn on / plug in the drive, the system crashes and dumps a
> seemingly endless stack trace.  It doesn't make it to the system log, so
> I don't have much more than that yet.
> 
> Many more details available on request.  And more information coming
> regardless.   
> 
> Unfortunately for me, 2.4 is extremely flaky for sbp2 as well. (sigh). 
> Red Hat kernels oops a few seconds after the drive is plugged in, but
> the system keeps running so I have some decoded oops for those at
> least.  I'll try to get one from a stock 2.4.recent...

>From experience, sbp2 with a recent ieee1394 linux_2_4 SVN branch
snapshot works quite well. I updated the one in my tree about
3 weeks ago and have been successfull playing with an iPod, burning
CDs, etc...

Ben.

