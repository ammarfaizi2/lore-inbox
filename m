Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUEaNfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUEaNfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUEaNfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:35:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47298 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264386AbUEaNfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:35:07 -0400
Date: Thu, 27 May 2004 21:36:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: swsusp fails short on memory
Message-ID: <20040527193641.GE509@openzaurus.ucw.cz>
References: <1085582116.1785.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085582116.1785.6.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm somewhat ignorant on the inner workings of swsusp. I have a 256MB
> laptop machine running 2.6.7-rc1-bk2 + ACPI + swsusp two swap
> partitions, a 256MB swap partition on /dev/hda4 plus another 256MB swap
> on /dev/hda5. When trying to hibernate to disk, swsusp fails with the
> following error message:

You need just one swap partition (256MB
should be enough).
 Try suspending from single user mode.


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

