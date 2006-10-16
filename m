Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422891AbWJPWhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWJPWhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422899AbWJPWhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:37:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14536
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422896AbWJPWhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:37:23 -0400
Date: Mon, 16 Oct 2006 15:37:20 -0700 (PDT)
Message-Id: <20061016.153720.115911255.davem@davemloft.net>
To: jengelh@linux01.gwdg.de
Cc: andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Sparc64 kernel message: BUG: soft lockup detected on CPU#3!
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0610162358270.30479@yvahk01.tjqt.qr>
References: <20061016164124.GC9350@pelagius.h-e-r-e-s-y.com>
	<20061016.135400.112621150.davem@davemloft.net>
	<Pine.LNX.4.61.0610162358270.30479@yvahk01.tjqt.qr>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Tue, 17 Oct 2006 00:02:53 +0200 (MEST)

> I have not seen this soft lockup so far, though I run a 2.6.16, most 
> likely using CONFIG_PROM_CONSOLE (redirected to ttya by prom) because
> the machine is not a SUN4V (which SUNHV seems to be for).

You could be using one of the other serial drivers.
Check the boot messages and your kernel config.
