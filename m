Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVCIPi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVCIPi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVCIPi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:38:57 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:31199 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261850AbVCIPiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:38:00 -0500
Message-ID: <422F1855.7010808@mesatop.com>
Date: Wed, 09 Mar 2005 08:37:57 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PPPD fails on recent 2.6.11-bk
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last night, I did a bk pull from linux.bkbits.net/linux-2.6,
built and rebooted, and the pppd (version 2.4.2) failed to start
after the modem at the ISP end answered.

I usually keep the kernel fairly up-to-date with bk, and I'm
certain that 2.6.11-vanilla ran pppd just fine a few days earlier.

I rebooted to an older kernel (2.6.6) and pppd ran OK.
I retested with the 2.6.11-plus kernel, and it was still broken.

Due to my slow connection (56k) and slow machine, I wasn't able to
further narrow down when this failure was introduced, but I may
be able to do that tonight on my home machine.  Sorry, I don't
have the time or hardware to work on this during the day.

If anyone can test a recent 2.6.11-bk-current kernel with pppd
on dialup, that would be helpful.

Steven
