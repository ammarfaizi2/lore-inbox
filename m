Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbULIQrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbULIQrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbULIQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:44:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27523 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261565AbULIQn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:43:59 -0500
Date: Wed, 8 Dec 2004 10:17:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Subject: Re: [RFC] new timeofday core subsystem (v.A1)
Message-ID: <20041208091701.GB983@openzaurus.ucw.cz>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com> <1102470997.1281.30.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102470997.1281.30.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I look forward to your comments and feedback.

> diff -Nru a/drivers/timesource/Makefile b/drivers/timesource/Makefile
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/drivers/timesource/Makefile	2004-12-07 16:47:19 -08:00
> @@ -0,0 +1 @@
> +obj-y += jiffies.o


Perhaps drivers/time would be better name? We do not have
drivers/characterdevices, either...
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

