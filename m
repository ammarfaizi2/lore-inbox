Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUEXAcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUEXAcF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 20:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUEXAcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 20:32:05 -0400
Received: from web90007.mail.scd.yahoo.com ([66.218.94.65]:64154 "HELO
	web90007.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S263776AbUEXAcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 20:32:01 -0400
Message-ID: <20040524003200.14639.qmail@web90007.mail.scd.yahoo.com>
Date: Sun, 23 May 2004 17:32:00 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Help understanding slow down
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need some help understanding what is at issue with
the extreme lsow down in build times for a custom
executable on different kernel versions.  The
difference is pretty huge:

RH 2.4.20-13-7 : ~1m.10s
2.4.22         : ~1m.40s
2.4.26         : ~2m.15s
2.6.1          : ~3m.40s
2.6.2          : ~4m.00s
2.6.3          : ~4m.00s
2.6.6          : ~3m.15s
2.6.6-mm4      : ~2m.10s
2.6.6-mm5      : ~2m.50s
2.6.7-p1       : ~2m.80s
(ran five times on every kernel to get approximate
time listed)

The question is, how can I get the newer kernels to
scream like the older kernels?

I have moved all files in question to the local disk
to rule out network issues (though the 2.6.x kernels
are faster at net access).  I have run the make
command in debug mode and find no differnce betHz w/8G
RAM.

Thank you for your assistance.
Phy



	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
