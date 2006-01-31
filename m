Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWAaQwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWAaQwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWAaQwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:52:03 -0500
Received: from tim.rpsys.net ([194.106.48.114]:23969 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751236AbWAaQwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:52:02 -0500
Subject: Re: [PATCH 0/11] LED Class, Triggers and Drivers
From: Richard Purdie <rpurdie@rpsys.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, dirk@opfer-online.de
In-Reply-To: <43DF8349.9070908@drzeus.cx>
References: <1138714882.6869.123.camel@localhost.localdomain>
	 <43DF8349.9070908@drzeus.cx>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 16:48:28 +0000
Message-Id: <1138726108.6869.211.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 16:33 +0100, Pierre Ossman wrote:
>
> A MMC trigger in the pipeline? My new SDHCI MMC driver can be built as a
> LED device, but it should probably be mapped to MMC activity by default.

Not specifically. I suspect about 5 lines of code in mmc_block.c would
be enough though. Patches welcome :)

Richard

