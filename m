Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270324AbTG1RI2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 13:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270326AbTG1RI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 13:08:28 -0400
Received: from palrel11.hp.com ([156.153.255.246]:47534 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S270324AbTG1RI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 13:08:27 -0400
Date: Mon, 28 Jul 2003 10:23:42 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: irtty vs. irtty-sir
Message-ID: <20030728172342.GC18257@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote :
> 
> irtty is dabbed as broken in Makefile.
> 
> Question - is it fundamentally broken, sometimes broken or under special 
> conditions broken? :)

	Fundamentally broken, as "I should have get rid of it 6 months
ago, but I'm too lazy".

> I need to decide if I replace default ldisc-11 by irtty-sir in 2.6
> (risking that some dongles stop working for some people) or leave it
> as irtty and tell guys who build kernel to use CONFIG_IRTTY_OLD

	Yes, some dongle drivers will need rewritting.

	Jean
