Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVCIX3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVCIX3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVCIX3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:29:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:43936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262301AbVCIX3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:29:03 -0500
Date: Wed, 9 Mar 2005 15:28:25 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Chris Wright <chrisw@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Daniel Staaf <dst@bostream.nu>, LKML <linux-kernel@vger.kernel.org>,
       Andrei Mikhailovsky <andrei@arhont.com>,
       Ian Campbell <icampbell@arcom.com>,
       Ronald Bultje <rbultje@ronald.bitfreak.net>,
       Gerd Knorr <kraxel@bytesex.org>, stable@kernel.org
Subject: Re: [PATCH 2.6] Fix i2c messsage flags in video drivers
Message-ID: <20050309232825.GH5389@shell0.pdx.osdl.net>
References: <1110024688.5494.2.camel@whale.core.arhont.com> <422A5473.7030306@osdl.org> <1110115990.5611.2.camel@whale.core.arhont.com> <422CCBF4.1060902@osdl.org> <20050308201504.6aee36d5.khali@linux-fr.org> <20050308202530.2fbfae9a.khali@linux-fr.org> <20050309184055.GX28536@shell0.pdx.osdl.net> <20050309225559.061058dd.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309225559.061058dd.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jean Delvare (khali@linux-fr.org) wrote:
> > 
> > Are people reporting this as a problem?
> 
> Not that I know. For adv7175 it couldn't be reported so far anyway
> because people would hit the oops in saa7110 before (same board: DC10+,
> oops fixed in a different patch).

Heh, right.

> It is possible that people are able to get their board to still work
> without my patch, if the chips were properly configured in the first
> place and they don't attempt to reconfigure them (like norm change). I
> don't know the chips well enough to tell how probable this is.

According to offlist mail, it does "fix a bug that bothers people."
So looks like a fine candidate, and is queued up for -stable.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
