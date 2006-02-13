Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWBMOQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWBMOQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWBMOQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:16:39 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:32486 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751791AbWBMOQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:16:38 -0500
Date: Mon, 13 Feb 2006 23:16:36 +0900 (JST)
Message-Id: <20060213.231636.103125334.toriatama@inter7.jp>
To: linux-kernel@vger.kernel.org
Subject: PPP with PCMCIA modem stalls on 2.6.10 or later
From: Kouji Toriatama <toriatama@inter7.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to run pppd with high speed PCMCIA modem on an
IBM Thinkpad T41 laptop.  My Linux system is Debian (sarge)
with vanilla kernel such as 2.6.15.4.

The problem is PPP connection through the modem stalls at
frequent intervals.  (To be exact, the PPP connection means
TCP traffic such as SSH, HTTP.)

I have tested some of older kernels.  Followings are the
results of the test.

   Work fine: 2.6.8, 2.6.8.1, 2.6.9
   Stall:     2.6.10, 2.6.11, 2.6.15.2, 2.6.15.3, 2.6.15.4
                   (2.6.11.1 ~ 2.6.15.1 have not been tested)

I guess kernel 2.6.10 or later have the problem.  So, I have
checked ChangeLog-2.6.10, but I could not find out any couse
of the issue.  I have also checkd patch-2.6.10. But there are
may fixes related to PPP, PCMCIA, and serial.  Now, I have
lost where to search.

Does anyone have any idea to fix the problem or ideas for
more tests that I can run to pin down the problem?
Any sugestions are welcome.

Thanks for your attention,
Kouji Toriatama
