Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268763AbTBZM30>; Wed, 26 Feb 2003 07:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268765AbTBZM30>; Wed, 26 Feb 2003 07:29:26 -0500
Received: from web14707.mail.yahoo.com ([216.136.224.124]:31749 "HELO
	web14707.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268763AbTBZM3Y>; Wed, 26 Feb 2003 07:29:24 -0500
Message-ID: <20030226123939.61607.qmail@web14707.mail.yahoo.com>
Date: Wed, 26 Feb 2003 04:39:39 -0800 (PST)
From: Electroniks New <elektr_new@yahoo.com>
Subject: Patch swsusp problem
To: linux-kernel@vger.kernel.org
Cc: seasons@falcon.sch.bme.hu, pavel@atrey.karlin.mff.cuni.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   The 2.4 patch i tried out just does the suspend
part and returns to bash prompt again. I did the
susped by echo "1 0  0" . If shows suspending progress
after the progress compeletes it returns.
The sysrq doesn't work.
Also in 2.5.59 the sysrq doesn't work.I looked into
code i couldn't find a  sysrq-d function in the kernel
code. It's been a while since i downloaded the code.
Has it been updated.

In 2.5.59 i did the sleep by /proc/apic/sleep or
/proc/acpi/sleep 
It suspended but got into a while loop (1) it was
saying refrigration and some other messages .

I didn't apply any sysint or other patches.

Only 2.4 patch was applied to 2.4 kernel and 2.5.59 
was not changed.

Also i have only one swap partition. 
After suspending if i hard reset (after 2 min not much
of data  running) will the kernel be able to restore .
i passed resume = /dev/hdb2 which is the swap
partition.

Pavel and Gabor help me out.

Also can it restore the vim state and other X session
states.

Or does it only save the kernel states and process.



Thank you .
 

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
