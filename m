Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUGOEvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUGOEvj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 00:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUGOEvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 00:51:38 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:50816 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S265971AbUGOEvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 00:51:32 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: momentary sensors failure in gkrellm2
Date: Thu, 15 Jul 2004 00:51:32 -0400
User-Agent: KMail/1.6
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407150051.32215.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.62.14] at Wed, 14 Jul 2004 23:51:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I noticed tonight, while booted to 2.6.8-rc1, that my gkrellm display 
was a little short, all the temps and voltages were on the missing 
list.  So, based on the more eyeballs theory, I rebooted a few times 
testing recent kernels.

Backing up to 2.6.7-mm6, it all worked, so I grabbed Andrews rc1-mm1 
patch and installed that.

I'm happy to note that the sensors stuff is back among the living and 
being displayed properly with 2.6.8-rc1-mm1.

I've no idea which of the patches involving the i2c stuff wasn't right 
for my chipset (via686 & winbond 697hf IIRC), but something broke it 
just for 2.6.8-rc1.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
