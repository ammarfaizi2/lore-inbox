Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbULaAod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbULaAod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 19:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbULaAod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 19:44:33 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:44455 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261799AbULaAob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 19:44:31 -0500
Subject: Re: Linux 2.6.10-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: gene.heskett@verizon.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200412300005.31211.gene.heskett@verizon.net>
References: <1104103881.16545.2.camel@localhost.localdomain>
	 <200412300005.31211.gene.heskett@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104430176.2446.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 30 Dec 2004 23:38:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-30 at 05:05, Gene Heskett wrote:
> some sort of an error message that looks like it may be memory
> related.  There's a pair of half giggers in here, running at 333 fsb,
> but they are supposedly rated for a 400 mhz fsb. Thats presumably
> because I have turned on the MCE stuffs.

MCE's generally come from the processor. To decode it you need to know
what CPU and then get the manuals out and decode the bits. 

> Dec 29 23:44:09 coyote kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
> Dec 29 23:44:09 coyote kernel: Bank 2: d40040000000017a
> 
> And I've not seen that before.  Does it have a simple and correct answer?

Its unhappy about something, but whatever is causing it isn't fatal.
Previously its been unhappy but not telling you ..

