Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbULRRte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbULRRte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 12:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbULRRtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 12:49:33 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:18852 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261205AbULRRtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 12:49:31 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc3-mm1: swsusp
Date: Sat, 18 Dec 2004 18:52:31 +0100
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412181852.31942.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I must say I'm really impressed with the progress that swsusp made since I 
tried it last time (close to 2.6.10-rc1 as I recall).  Now I've been using it 
for a couple of days on 2.6.10-rc3-mm1 and It's never refused to suspend the 
machine because of the lack of (contiguous) memory which happened very often 
before, and it seems to be much faster.  Using it my notebook has reached 
more that 1 day of uptime recently, wich was practically impossible 
previously.  It's a great job and vast improvement for which I thank you very 
much!

Still, unfortunately, today it crashed on suspend and I wasn't able to get any 
useful information related to the crash, because swsusp apparently does not 
send some of its messages to the serial console.  In particular, anything 
from within the critical section is not printed there and that's why I think 
(I'm not sure though) that the crash occured in the critical section.  Could 
you tell me please if it's possible to make all of the swsusp messages appear 
on the serial console and, if so, how to do this (I've already tried "dmesg 
-n 8" and "echo 9 > /proc/sysrq-trigger" but none of them helps)?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
