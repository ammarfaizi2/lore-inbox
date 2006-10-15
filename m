Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWJOObo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWJOObo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 10:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWJOObo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 10:31:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:51643 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750793AbWJOObn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 10:31:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=SJYpgwfMAfKv5+xPJ/k2NpCUfuuPZWjSGsyqcfzmtsZSRk9742TMjeWxnFBSbIXd1hCNXVJ/3eOGDHn0L927K6FfvLExwnoYtoBbOkxAzUircEk/7f2bgzdSTwfbQbaurUKtonSEQej7M0um0BHDEDDwZx6vLHBc6MBPx/19e04=
Message-ID: <45324658.1000203@gmail.com>
Date: Sun, 15 Oct 2006 16:31:29 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>, Christoph Hellwig <hch@lst.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: feature-removal-schedule obsoletes
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I figured out these requests for removal with past dates. What's the state of
them now, could you reschedule or delete (or just confirm here to post one patch
correcting this file)?

[Why:s were removed in this mail]

---------------------------

What:   RAW driver (CONFIG_RAW_DRIVER)
When:   December 2005
Who:    Adrian Bunk <bunk@stusta.de>

---------------------------

What:   PCMCIA control ioctl (needed for pcmcia-cs [cardmgr, cardctl])
When:   November 2005
Who:    Dominik Brodowski <linux@brodo.de>

---------------------------

What:   ip_queue and ip6_queue (old ipv4-only and ipv6-only netfilter queue)
When:   December 2005
Who:    Harald Welte <laforge@netfilter.org>

---------------------------

What:   remove EXPORT_SYMBOL(kernel_thread)
When:   August 2006
Who:    Christoph Hellwig <hch@lst.de>

---------------------------

What:   CONFIG_FORCED_INLINING
When:   June 2006
Who:    Arjan van de Ven

---------------------------

What:   Unused EXPORT_SYMBOL/EXPORT_SYMBOL_GPL exports
        (temporary transition config option provided until then)
        The transition config option will also be removed at the same time.
When:   before 2.6.19
Who:    Arjan van de Ven <arjan@linux.intel.com>

---------------------------

What:   i2c-ite and i2c-algo-ite drivers
When:   September 2006
Who:    Jean Delvare <khali@linux-fr.org>

---------------------------

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
