Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUGSNQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUGSNQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 09:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUGSNQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 09:16:39 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:64163 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S265214AbUGSNQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 09:16:24 -0400
Message-ID: <40FBC9BB.70705@eidetix.com>
Date: Mon, 19 Jul 2004 15:16:43 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040708)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6 kernel won't reboot on AMD system
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC replies to me. ]

Before you hit 'reply', no, I'm not talking about the machine not 
getting past the BIOS check complaining that there is no keyboard present.

Kernel 2.6.7

model name      : AMD Athlon(tm) XP 2400+

motherboard: http://www.ecsusa.com/products/km400-m2.html

... not sure what else might be useful... apci=off added to boot 
options.  Preemptive kernel.

In any case, the machine in question does not reboot.  I traced the 
problem down to the mach_reboot but it doesn't get past those assembly 
instructions.  Things do seem to work alright if a keyboard is 
installed.  Otherwise, the machine just sits there, no longer responsive 
to pings or anything else.

This appears to be a somewhat common problem, as I found several other 
posters discussing it:

http://lkml.org/lkml/2004/3/12/248

http://marc.theaimsgroup.com/?l=linux-kernel&m=108868695814658&w=2

any ideas on what parts of the kernel to look at in order to determine 
what is causing this?

Thankyou,
-- 
David N. Welton
davidw@eidetix.com
