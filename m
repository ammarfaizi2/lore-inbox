Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVAMNmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVAMNmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 08:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVAMNkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 08:40:53 -0500
Received: from outbound-mail.lax.untd.com ([64.136.28.164]:20894 "HELO
	outbound-mail.lax.untd.com") by vger.kernel.org with SMTP
	id S261624AbVAMNjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 08:39:55 -0500
X-UNTD-OriginStamp: shnglaIgDAhVwDO3x7gA1RpBVbflEDCmHvnyspDeogCQTwe7gNQNyg==
X-Originating-IP: [169.144.118.138]
Mime-Version: 1.0
From: "pevnev@juno.com" <pevnev@juno.com>
Date: Thu, 13 Jan 2005 13:36:17 GMT
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6 8xx kernel booting vs watchdog 
X-Mailer: WebMail Version 2.0
Content-Type: text/plain
Message-Id: <20050113.053842.7519.128097@webmail25.lax.untd.com>
X-ContentStamp: 5:2:1894444010
X-MAIL-INFO: 5517eea3ae3e8b6e27670f1bebd79b8efeb3376f0223d74b5ef79fafaa1aafab9aaadf1adfdfba5a834e7e73b763cbc3f3cb93c7c34ff34f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I managed to get through kernel decompression by putting enough watchdog resets calls in zlib functions (the watchdog can not be shut off ).
- now I am stuck at booting the kernel ...
- cursor "blinks" quite for a long time after I see the last printout in load_kernel(), that is: "Now booting the kernel"  - 
I suspect it is watchdog issue again ...

How watchdog resetting is handled for 82xx (I think 8xx will be similar ?) in Linux 2.6 on the kernel level ?
Does one need to add code for it or is it supported "off the shelf" ?

Is "early printk" supported for 82xx on 2.6 (I think 8xx will be similar ?)?
If yes - how and where it could be enabled?

Thanks,
Alex


___________________________________________________________________
Speed up your surfing with Juno SpeedBand.
Now includes pop-up blocker!
Only $14.95/month -visit http://www.juno.com/surf to sign up today!

