Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTI3FSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 01:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTI3FSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 01:18:36 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:33934 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S263128AbTI3FSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 01:18:34 -0400
Date: Mon, 29 Sep 2003 22:18:32 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Danny ter Haar <dth@ncc1701.cistron.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test[56] pcnet32 problems
Message-ID: <20030930051832.GA4331@ip68-4-255-84.oc.oc.cox.net>
References: <blasc7$jfi$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <blasc7$jfi$1@news.cistron.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 03:13:11AM +0000, Danny ter Haar wrote:
> Sometimes (even during low traffic) eth0 simply locks up:
> In dmesg i see:
> kernel: eth0: Bus master arbitration failure, status 88f3.

Hmmm... I'm not seeing this at all.

If going back to an older kernel gets rid of this problem, perhaps it
could be an IRQ routing problem or something like that. That's just a
guess, however. (If it doesn't, I would suspect hardware failure, perhaps
your motherboard; motherboard failures are the only time I've seen this
message happen with pcnet32 cards.)

> rmmod pcnet32 results in kernel-panic.

I never tried that because my primary pcnet32-using machine runs
monolithic kernels...

-Barry K. Nathan <barryn@pobox.com>
