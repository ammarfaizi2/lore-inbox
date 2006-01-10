Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWAJQFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWAJQFd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWAJQFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:05:33 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:60831 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751138AbWAJQFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:05:32 -0500
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net, dpervushin@ru.mvista.com
Subject: Re: [spi-devel-general] [PATCH] spi: add bus methods instead of driver's ones
Date: Tue, 10 Jan 2006 08:05:30 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1136893627.4780.9.camel@diimka-laptop> <200601100705.13313.david-b@pacbell.net> <1136905911.4780.19.camel@diimka-laptop>
In-Reply-To: <1136905911.4780.19.camel@diimka-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100805.30859.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What kernel are you using here?  The one I'm looking at -- GIT snapshot
> > as of a few minutes ago -- doesn't have probe(), remove(), or shutdown()
> > methods in "struct bus_type".  I don't recall that it ever had such...
>
> Could you please look to message from Russell King with subject "[CFT
> 1/29] Add bus_type probe, remove, shutdown methods." ? This patch
> introduces methods named above to bus_type struct. 

Ah, I see what's going on.  It's conventional to mention when patches
rely on stuff that's not merged into mainline yet, since the default
assumption is that patches apply against mainline.

Given that, your patch now makes sense.

- Dave
