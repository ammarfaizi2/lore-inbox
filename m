Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUG1RvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUG1RvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUG1RvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:51:09 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:17370 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267360AbUG1RvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:51:06 -0400
Message-ID: <4107E788.8030903@eidetix.com>
Date: Wed, 28 Jul 2004 19:51:04 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Sascha Wilde <wilde@sha-bang.de>
Subject: 2.6 kernel won't reboot on AMD system (no, not the BIOS...)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC replies to me. ]

[ Sorry for the rerun, but I guess everyone was away at the OLS, so I'll 
try again, operating on the squeaky wheel principle. ]

Before you hit reply or erase, no, I'm not talking about the machine not
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
what is causing this?  I need to fix it, and I don't know where to start 
looking.

Thankyou,
-- 
David N. Welton
davidw@eidetix.com

