Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269300AbUIYKM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269300AbUIYKM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 06:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269301AbUIYKM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 06:12:57 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:51629 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269300AbUIYKM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 06:12:56 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Date: Sat, 25 Sep 2004 12:14:28 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409251214.28743.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

I've just tried to suspend my box and I must admit I've given up after 30 
minutes (sic!) of waiting when there were only 12% of pages written to disk.  
Apparently, swsusp slows down to an unacceptable level after saying "PM: 
Writing image to disk".

The box is an Athlon 64-based notebook.  The .config is available at:
http://www.sisk.pl/kernel/040925/2.6.9-rc2-mm3.config
and the output of dmesg is available at:
http://www.sisk.pl/kernel/040925/2.6.9-rc2-mm3-dmesg.log

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
