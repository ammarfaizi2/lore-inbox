Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269468AbUIZBZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269468AbUIZBZX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 21:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269469AbUIZBZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 21:25:23 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:26255 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S269468AbUIZBZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 21:25:19 -0400
Mime-Version: 1.0
Message-Id: <a06100577bd7bc87d92ee@[129.98.90.227]>
In-Reply-To: <40AE4DDC.7050508@pobox.com>
References: <a06100547bcd3f33b5b73@[129.98.90.227]>
 <40AE4DDC.7050508@pobox.com>
Date: Sat, 25 Sep 2004 21:26:07 -0400
To: Jeff Garzik <jgarzik@pobox.com>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: 2.68.rc4 affected by tg3 [Was Re: tg3 module in kernel 2.6.5
 panics ]
Cc: linux-kernel@vger.kernel.org, davem@nuts.davemloft.net, mchan@broadcom.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Maurice Volaski wrote:
>>The tg3 module in (gentoo) kernel 2.6.5 panics on boot on a 
>>dual-opteron 248 box with 4G RAM. I copied the following screen 
>>output...
>
>
>This looks like kobject stuff unrelated to tg3.
>
>Does 2.6.6 fail similarly?
>

I just tested with 2.68.rc4 from gentoo and although it doesn't panic 
and the driver even appears to load, the kernel spews out a crash 
message in the log similar to before. The eth0 interface doesn't show 
up in ifconfig.

The alternate driver doesn't seem to be in menuconfig any longer.

I see that a bug, #3131, has been filed on bugzilla. It looks like I 
am seeing the same problem here.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
