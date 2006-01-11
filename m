Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932787AbWAKGfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbWAKGfY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbWAKGfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:35:23 -0500
Received: from main.gmane.org ([80.91.229.2]:58846 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932787AbWAKGfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:35:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: 2.6.15 and CONFIG_PRINTK_TIME
Date: Wed, 11 Jan 2006 15:34:58 +0900
Message-ID: <dq28uj$96q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s185160.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060110)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember there was some talk about resetting the time on printk during the
boot to zero... Is that gone for 2.6.15?

I recently turned CONFIG_PRINTK_TIME on two machines and they identically
print things like this:

[17179569.184000] Linux version 2.6.15-K01_PIII_laptop (kalin@ss) (gcc
version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #2 PREEMPT Wed
Jan 11 09:56:21 JST 2006
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[17179569.184000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
[17179569.184000]  BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)

...

[17179591.768000] ReiserFS: hda5: checking transaction log (hda5)
[17179591.836000] ReiserFS: hda5: Using r5 hash to sort names
[17179605.172000] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex

That is about t0 + 200 days :-) No, the box is not THAT slow :-D

Now, on two different boxen, the initial time is the same: 17179569.184000

What is this number?

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

