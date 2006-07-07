Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWGGA6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWGGA6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWGGA6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:58:20 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:7366 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751112AbWGGA6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:58:20 -0400
Subject: Re: Linux v2.6.18-rc1: printk delays
From: john stultz <johnstul@us.ibm.com>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44ADA84A.9000603@imap.cc>
References: <6vtF8-99-7@gated-at.bofh.it>  <44AD9605.6000601@imap.cc>
	 <1152229599.24656.175.camel@cog.beaverton.ibm.com>
	 <44ADA84A.9000603@imap.cc>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 17:58:17 -0700
Message-Id: <1152233897.24656.179.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 02:18 +0200, Tilman Schmidt wrote:
> On 07.07.2006 01:46, john stultz wrote:
> 
> > On Fri, 2006-07-07 at 01:00 +0200, Tilman Schmidt wrote:
> > 
> >>With kernel 2.6.18-rc1 [t]he last couple of printk
> >>lines only appear if I hit a key on the system keyboard. [...]
> > 
> > Hmmm. I'm assuming this is i386?
> 
> Yes, indeed. Sorry I didn't mention that.
> 
> > Could you send me a full dmesg?
> 
> Attached.

Thanks!

> > Also does booting w/ clocksource=jiffies change the behavior?
> 
> Nope. That didn't produce any discernible change.

Hmmm. Just to make sure I understand the situation: If you log in via
ssh, and run dmesg, you do see your driver's output, but that output
just doesn't get to syslog until you press a key on your keyboard?


thanks again,
-john

