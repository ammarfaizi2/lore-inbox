Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTHaQYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTHaQYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:24:25 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:6857 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S262347AbTHaQXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:23:47 -0400
Date: Sun, 31 Aug 2003 09:23:37 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831162337.GD18767@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random> <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 04:31:32PM +0100, Alan Cox wrote:
> > what's the difference of rejecting packets in software, or because the
> > link can't handle them? Assume the guaranteed bandwidth is much lower
> 
> It doesn't work when you dont control incoming. As a simple extreme
> example if I pingflood you from a fast site then no amount of shaping
> your end of the link will help, it has to be shaped at the ISP end.

HTTP traffic is enough to simulate this, the connections are all small,
short lived, and there are a lot of them.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
