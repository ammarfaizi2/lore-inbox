Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265884AbUFOTcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265884AbUFOTcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUFOTcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:32:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:24961 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265889AbUFOTaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:30:04 -0400
Date: Tue, 15 Jun 2004 12:30:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>, Dean Nelson <dcn@sgi.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: calling kthread_create() from interrupt thread
Message-ID: <20040615123000.Z22989@build.pdx.osdl.net>
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com> <1087321777.2710.43.camel@laptop.fenrus.com> <20040615180525.GA17145@sgi.com> <Pine.LNX.4.53.0406151412350.2353@chaos> <20040615190114.GA6151@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040615190114.GA6151@lnx-holt.americas.sgi.com>; from holt@sgi.com on Tue, Jun 15, 2004 at 02:01:14PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robin Holt (holt@sgi.com) wrote:
> Currently, the interrupt handler wakes a thread sleeping on a
> wait_event_interruptible().  This wakeup is taking approx 35uSec.  Dean
> is looking for a lower latency means of doing the wakeup.

I can't imagine adding thread creation, etc to the mix is going to improve
latency.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
