Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbULMPpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbULMPpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 10:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbULMPpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 10:45:09 -0500
Received: from mobileweb04.london.02.net ([193.113.235.170]:15601 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261247AbULMPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 10:45:06 -0500
Subject: Re: dynamic-hz
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41BCD5F3.80401@kolivas.org>
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random>  <41BCD5F3.80401@kolivas.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102939243.2478.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Dec 2004 12:00:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-12-12 at 23:36, Con Kolivas wrote:
> The rest of my users that were setting Hz to 100 for so-called 
> performance gains were doing so under the false impression that cpu 
> usage was lower simply because of the woefully inaccurate cpu usage 
> calcuation at 100Hz.

It makes a difference for some HPC workloads. I run 100Hz because
- It improves battery life
- Laptops tend to lose ticks on battery status queries at 1Khz

