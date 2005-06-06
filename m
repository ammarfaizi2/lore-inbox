Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVFFJ3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVFFJ3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 05:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFFJ3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 05:29:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56453 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261248AbVFFJ31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 05:29:27 -0400
Date: Mon, 6 Jun 2005 11:29:26 +0200
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Message-ID: <20050606092925.GA23831@wotan.suse.de>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506041440.09795.kernel-stuff@comcast.net> <20050605112840.GX23831@wotan.suse.de> <200506051015.33723.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506051015.33723.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc list trimmed. John please dont send out mails with such 
a horrible cc list anymore.

On Sun, Jun 05, 2005 at 10:15:33AM -0400, Parag Warudkar wrote:
> On Sunday 05 June 2005 07:28, Andi Kleen wrote:
> > Do you actually use pmtimer? Please send a dmesg log.
> >
> Full dmesg attached - 2.6.12-rc5 seems to use pmtimer.

And does it work with nopmtimer ? 

-Andi

> 
> From 2.6.12-rc5 -
> ---------------------------------------
> Jun  5 10:04:04 tux-gentoo [    0.000000] time.c: Using 3.579545 MHz PM timer.
> Jun  5 10:04:04 tux-gentoo [    0.000000] time.c: Detected 797.956 MHz 
> processor.
> Jun  5 10:04:04 tux-gentoo [   14.020805] time.c: Using PIT/TSC based 
> timekeeping.
