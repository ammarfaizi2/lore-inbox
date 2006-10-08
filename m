Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWJHJyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWJHJyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 05:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWJHJyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 05:54:07 -0400
Received: from www.osadl.org ([213.239.205.134]:10935 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750984AbWJHJyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 05:54:03 -0400
Subject: Re: + clocksource-update-kernel-parameters.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: dwalker@mvista.com, johnstul@us.ibm.com, mingo@elte.hu,
       zippel@linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200610070153.k971rw7S020875@shell0.pdx.osdl.net>
References: <200610070153.k971rw7S020875@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 11:59:10 +0200
Message-Id: <1160301551.22911.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> Documents two new kernel parameters,
> 
> timeofday_clocksource
> sched_clocksource
>
> Removed old ones,
> 
> clocksource
> clock

NAK.

clocksource has just replaced clock. This hit mainline in 2.6.18.

1. we can not remove "clock" without a grace perdiod
2. we can not change the just created new parameter clocksource again.

	tglx




