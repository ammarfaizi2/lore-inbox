Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVCJSQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVCJSQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVCJSQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:16:41 -0500
Received: from inutil.org ([193.22.164.111]:45451 "EHLO
	vserver151.vserver151.serverflex.de") by vger.kernel.org with ESMTP
	id S262810AbVCJSIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:08:36 -0500
Date: Thu, 10 Mar 2005 19:08:26 +0100
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Moritz Muehlenhoff <jmm@inutil.org>, linux-kernel@vger.kernel.org
Subject: Re: Average power consumption in S3?
Message-ID: <20050310180826.GA6795@informatik.uni-bremen.de>
References: <20050309142612.GA6049@informatik.uni-bremen.de> <1110388970.1076.48.camel@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110388970.1076.48.camel@tux.rsn.bth.se>
User-Agent: Mutt/1.5.6+20040907i
From: Moritz Muehlenhoff <jmm@inutil.org>
X-SA-Exim-Connect-IP: 84.137.120.245
X-SA-Exim-Mail-From: jmm@inutil.org
X-SA-Exim-Scanned: No (on vserver151.vserver151.serverflex.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson wrote:
> I also have an X31 and I noticed that the e1000 has Wake-On-Lan enabled
> by default and the S3 code doesn't disable that (kind of defeats the
> purpose :)
> Disabling that will make the e1000 driver power down the chip during S3.
> 
> I've had mine suspended for 2-3 days at most, actually havn't left it
> alone for longer than that in S3 so I'm not really sure how much power
> it consumes, but I'd say it's 1-2 percent of the total capacity per
> hour, so somewhere below 1000mW.

I've got the e100 and with WOL disabled and Matthew's hacked radeontool
power consumption decreases to 970 mWh.

Cheers,
        Moritz
