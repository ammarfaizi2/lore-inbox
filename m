Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTKCG3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 01:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTKCG3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 01:29:24 -0500
Received: from gemini.yars.free.net ([193.233.48.66]:42745 "EHLO
	gemini.netis.ru") by vger.kernel.org with ESMTP id S261929AbTKCG3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 01:29:23 -0500
Date: Mon, 3 Nov 2003 09:29:06 +0300
From: "Alexander V. Lukyanov" <lav@netis.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9: success report
Message-ID: <20031103062906.GA5396@swing.yars.free.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact NETIS Telecom for more information (+7 0852 797709)
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.7, required 5,
	AWL 0.00, BAYES_30 -0.93, USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I write to report success of 2.6.0-test9 on a heavy loaded (2m hits a day)
proxy server running squid.

It worked 3 days under load without a glitch.

Some notes:

	1. ATA TCQ does not work here, I had to disable it. Turning it on
	   later leads to instant data corruption.
	2. Nice value seems to be more significant in 2.6 than in 2.4, but
	   I think it is good.

My config:
	P4 1.80GHz, 640MB ram, 2x40MB ibm ide disks (IC35L040AVVN07-0).
	ext3 filesystems.

-- 
   Alexander.                      | http://www.yars.free.net/~lav/  
