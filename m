Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVGIV0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVGIV0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 17:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVGIV0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 17:26:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:50860 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261742AbVGIV0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 17:26:00 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: akpm@osdl.org, arjan@infradead.org, azarah@nosferatu.za.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <20050709133036.11e60a3c.rdunlap@xenotime.net>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <1120933916.3176.57.camel@laptopd505.fenrus.org>
	 <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org>
	 <1120936561.6488.84.camel@mindpipe>
	 <20050709133036.11e60a3c.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 17:25:58 -0400
Message-Id: <1120944358.6488.90.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-09 at 13:30 -0700, randy_dunlap wrote:
> | Then the owners of such machines can use HZ=250 and leave the default
> | alone.  Why should everyone have to bear the cost?
> 
> indeed, why should everyone have to have 1000 timer interrupts per second?

So why waste everyone's time with CONFIG_HZ when there are working
dynamic tick solutions out there?  It's just bad release engineering.

Lee

