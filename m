Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTEGVcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTEGVcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:32:17 -0400
Received: from pragmatix.bangor.ac.uk ([147.143.2.14]:22520 "EHLO
	pragmatix.bangor.ac.uk") by vger.kernel.org with ESMTP
	id S264272AbTEGVcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:32:15 -0400
Message-ID: <3EB97E97.6000903@bangor.ac.uk>
Date: Wed, 07 May 2003 22:45:59 +0100
From: =?ISO-8859-15?Q?Christer_B=E4ckstr=F6m?= <chp802@bangor.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc1 freezes caused by rtc driver? 
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: nid sbam/not spam (goddefadwy/whitelisted),
	SpamAssassin (sgor/score=-12.2, yn ofynnol/required 4.5, BAYES_01,
	FROM_ENDS_IN_NUMS, USER_AGENT_MOZILLA_UA)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hangs/freezes that has been reported with 2.4.21-rc1 seems to be due 
to the changes to the rtc driver. At least on my Athlon/Ali Aladdin IV 
Laptop. I haven't backed out the changes to the drivers between 
2.4.21-pre7 and rc1 yet, but I've had no further problems after I 
disabled the rtc. (Or before 2.4.21-rc1). Cheers,

/Chris

