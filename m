Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVGYVL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVGYVL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVGYVL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:11:29 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:20230 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261454AbVGYVL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:11:28 -0400
Message-ID: <42E5567A.80501@tmr.com>
Date: Mon, 25 Jul 2005 17:15:38 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ACPI oddity
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a HT system, why does ACPI recognize CPU0 and CPU1, refer to them as 
such in dmesg, and then call them CPU1 and CPU2 in /proc/acpi/processor?

In uni kernels the single processor is CPU0.

This is a 2.6.10 kernel, the machine has been up since then. I have 
other 2.6 machines and other SMP and/or HT machines, but all of the HT 
machines running 2.6 are behind a hard firewall except one.

It's running the ASUS P4P800 board which is why I looked, BIOS 1086.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
