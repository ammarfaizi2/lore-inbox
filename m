Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbULSTny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbULSTny (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 14:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbULSTnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 14:43:53 -0500
Received: from gprs215-234.eurotel.cz ([160.218.215.234]:50561 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261332AbULSTnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 14:43:52 -0500
Date: Sun, 19 Dec 2004 20:43:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Todor Todorov <ttodorov@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SWSUSP in 2.6.9 and 2.6.9-ac16 screws up the swap
Message-ID: <20041219194337.GA1432@elf.ucw.cz>
References: <41C498F2.7070603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C498F2.7070603@web.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a Toshiba Satelite M30X laptop for which suspend-to-disk is 
> reported to work. I tested with kernel 2.6.9 vanilla and -ac16 and 
> suspending seemed to work ok, at least the computer shut down. On 
> resuming I appended "resume=/dev/hda3" (my swap partition) to the boot 
> options but saw no message about resuming form suspend image ot 
> anything, it seems to be a normal boot. Later on when adding swap I got 
> the error "Unable to find swap-space signature", `cat /proc/swaps` 
> didn't show anything. I had to recreate the swap.
> 
> Could anyone please look into this? I would provide any additional 
> information requested. Please Cc: me when you answer. Thanks in advance.

Read documentation/power/swsusp.txt; you are probably doing something
wrong. If not add printks into resume code and find out what is wrong.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
