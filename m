Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271327AbTHCXoi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 19:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271329AbTHCXoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 19:44:38 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:20115 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S271327AbTHCXoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 19:44:37 -0400
Date: Sun, 3 Aug 2003 16:44:19 -0700
From: Larry McVoy <lm@bitmover.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Werner Almesberger <werner@almesberger.net>,
       Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: TOE brain dump
Message-ID: <20030803234419.GA13604@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Lang <david.lang@digitalinsight.com>,
	Larry McVoy <lm@bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Werner Almesberger <werner@almesberger.net>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org, Nivedita Singhvi <niv@us.ibm.com>
References: <20030803203051.GA9057@work.bitmover.com> <Pine.LNX.4.44.0308031405130.24695-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308031405130.24695-100000@dlang.diginsite.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 02:21:12PM -0700, David Lang wrote:
> if your 8-way opteron database box is already the bottleneck for your
> system you will have to spend a LOT of money to get anything that gives
> you more available processing power, getting a card to offload any
> processing from the main CPU's can be a win.

I'd like to see data which supports this.  CPUs have gotten so fast and
disk I/O still sucks.  All the systems I've seen are CPU rich and I/O
starved.  The smartest thing you could do would be to get a cheap box
with a GB of ram as a disk cache and make it be a SAN device.  Make
N of those and you have tons of disk space and tons of cache and your
8 way opteron database box is going to work just fine.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
