Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUHDETt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUHDETt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 00:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUHDETt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 00:19:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:38307 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266691AbUHDETs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 00:19:48 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200408032030.41410.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston>
	 <200408032030.41410.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091593145.5227.86.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 14:19:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Me either.  But renumbering the PM_SUSPEND_* values would let folk
> start discussing what PM should be (and do) without that particular
> pressure.

Agree... I need to clean up my patch as some of the code in
kernel/power/main.c expect the numbers to be contiguous and I did
ugly hacks in there.

Ben.


