Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUKOWsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUKOWsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUKOWpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:45:55 -0500
Received: from news.suse.de ([195.135.220.2]:4589 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261493AbUKOWoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:44:44 -0500
Date: Mon, 15 Nov 2004 23:35:09 +0100
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2: strange behavior on dual Opteron w/ NUMA
Message-ID: <20041115223509.GE3062@wotan.suse.de>
References: <200411152306.15606.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411152306.15606.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect that this has been intorduced in 2.6.10-rc1-mm5, so if you have any 
> ideas, please let me know.  If you need more information, please let me know 
> too.

Could be the recent futex change. It seems to cause all kinds of problems.
I would try reverting that.

-Andi
