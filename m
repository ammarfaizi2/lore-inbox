Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVEBV22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVEBV22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVEBV22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:28:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:57292 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261151AbVEBV2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:28:24 -0400
Subject: Re: [RFC][PATCH (2/4)] new timeofday arch specific hooks (v A4)
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, albert@users.sourceforge.net,
       paulus@samba.org, schwidefsky@de.ibm.com, mahuja@us.ibm.com,
       donf@us.ibm.com, mpm@selenic.com, benh@kernel.crashing.org
In-Reply-To: <20050502211334.GA2390@openzaurus.ucw.cz>
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com>
	 <1114814811.28231.4.camel@cog.beaverton.ibm.com>
	 <20050502211334.GA2390@openzaurus.ucw.cz>
Content-Type: text/plain
Date: Mon, 02 May 2005 14:28:20 -0700
Message-Id: <1115069300.13738.13.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-02 at 23:13 +0200, Pavel Machek wrote:
> Hi!
> 
> > ppc64 and s390. It applies on top of my linux-2.6.12-rc2_timeofday-
> > core_A4 patch and with this patch applied, you can test the new time of
> > day subsystem. 
> ....
> > device_power_down(PMSG_SUSPEND);
> >  
> > +	timeofday_suspend_hook();
> >  	/* serialize with the timer interrupt */
> 
> You should not add hooks like this. Just add your own [sys]_device.

Agreed. Sorry I didn't get to it the last time you mentioned it.

thanks
-john




