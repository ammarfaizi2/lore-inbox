Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVIGEou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVIGEou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 00:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVIGEou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 00:44:50 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:36807 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id S1751124AbVIGEou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 00:44:50 -0400
Mime-Version: 1.0
Message-Id: <a0623090dbf441d7a72a0@[129.98.90.227]>
In-Reply-To: <1126063875.13159.31.camel@mindpipe>
References: <a06230908bf43b486d98f@[129.98.90.227]>
 <1126063875.13159.31.camel@mindpipe>
Date: Wed, 7 Sep 2005 00:45:16 -0400
To: Lee Revell <rlrevell@joe-job.com>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: Kernel 2.6.13 is hiding devices from /dev [Was Why is the 
 kernel hiding drbd devices?}
Cc: drbd-user@linbit.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What is drbd?  An out of tree driver?  Did it work with 2.6.13-rcX?  If

Yes, it implements RAID 1 across two computers over a network link in 
realtime. Generally, you combine with a program called heartbeat to 
implement high-availabilty failover. It's very neat ;-)

>not, why didn't they tell us sooner?  Does it expect devfs to be present
>in the kernel by any chance?


It's actually working now. Don't ask me to explain it because last 
night and most of Monday I couldn't get it working and I must have 
compiled half a dozen different Gentoo kernel versions of 2.6.12, and 
it worked with some but not others. It worked perfectly with the 
official 2.6.12 but not with official 2.6.13. Then suddenly it just 
started to work again on all the Gentoo 2.6.12s it wouldn't work with 
and also with the official 2.6.13. I have 2.6.13 running right now, 
and drbd devices show up in /dev as if there never had been any 
problem.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
