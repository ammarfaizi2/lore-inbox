Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422989AbWJQAlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422989AbWJQAlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 20:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422990AbWJQAlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 20:41:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58796
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422989AbWJQAlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 20:41:44 -0400
Date: Mon, 16 Oct 2006 17:41:00 -0700 (PDT)
Message-Id: <20061016.174100.48529083.davem@davemloft.net>
To: jengelh@linux01.gwdg.de
Cc: andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Sparc64 kernel message: BUG: soft lockup detected on CPU#3!
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0610170053280.30479@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610162358270.30479@yvahk01.tjqt.qr>
	<20061016.153720.115911255.davem@davemloft.net>
	<Pine.LNX.4.61.0610170053280.30479@yvahk01.tjqt.qr>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Tue, 17 Oct 2006 00:56:26 +0200 (MEST)

> 
> >> I have not seen this soft lockup so far, though I run a 2.6.16, most 
> >> likely using CONFIG_PROM_CONSOLE (redirected to ttya by prom) because
> >> the machine is not a SUN4V (which SUNHV seems to be for).
> >
> >You could be using one of the other serial drivers.
> >Check the boot messages and your kernel config.
> 
> Thanks for the hint. I am still a bit puzzled why there are so many 
> serial ports detected even though there is only ttya and ttyb on the 
> back:

What kind of system is this?

The two SU serial ports are usually for keyboard and mouse.

If you have 4 SAB ports, I'm guessing this is an Ultra250.
The 3rd and 4th SAB port are usually used for RSC on the
Ultra250 machines, the 1st and 2nd for normal ttya and ttyb
serial.
