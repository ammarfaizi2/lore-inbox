Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbTI0UZq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 16:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTI0UZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 16:25:46 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:20184 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S262158AbTI0UZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 16:25:41 -0400
Date: Sat, 27 Sep 2003 22:21:48 +0200
From: Roger Luethi <rl@hellgate.ch>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with 48mb ram under moderate load
Message-ID: <20030927202148.GA31080@k3.hellgate.ch>
Mail-Followup-To: Ihar 'Philips' Filipau <filia@softhome.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ArQ0.821.23@gated-at.bofh.it> <ArQ0.821.25@gated-at.bofh.it> <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it> <3F75EC3B.4030305@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F75EC3B.4030305@softhome.net>
X-Operating-System: Linux 2.6.0-test5 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003 21:59:55 +0200, Ihar 'Philips' Filipau wrote:
>   Better than with swap. This is production workstation - I cannot test 
> something on it :-(

I don't think there's much risk involved in running 2.[56]. If it doesn't
boot, you can go back to 2.4. If it does boot, it won't eat your data.
YMMV, of course.

>    <rant>'Paging like crazy' became for me a synonym of Linux. It 
> doesn't matter how much memory you have. Less == worse. Developers 

Oh, it does matter. My workstation has 1 GB RAM and 2 GB swap and I hardly
see any problems with paging <g>.

> stopped testing VMM regression on low-memory computers long time ago. 

Many of the best Linux devs these days work for companies and organizations
that are in the business of selling or using big iron. They have people on
staff who test the kernel and whine if it fails to run well with a ton of
memory and a gazillion CPUs (plus people who actually fix it); it's not
their job to care about low end systems. However, you don't have to be a VM
hacker to run a bunch of benchmarks to compare performance and point out
regressions. People tend to listen if you offer some hard numbers instead
of a rant about how nobody cares about the low end.

Roger
