Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263711AbUEPRS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUEPRS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUEPRS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:18:58 -0400
Received: from mail.ccdaust.com.au ([203.29.88.42]:1326 "EHLO
	gateway.ccdaust.com.au") by vger.kernel.org with ESMTP
	id S263711AbUEPRSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:18:55 -0400
Message-ID: <40A7A278.7010405@wasp.net.au>
Date: Sun, 16 May 2004 21:18:48 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: libata Promise driver regression 2.6.5->2.6.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,

I have been using 2.6.5 happily for a while now on this machine.
It's an Asus A7V600 with 3 Promise SATA150-TX4 SATA cards.

With 2.6.6 (and 2.6.6-bk3) it hangs with a dma timeout on boot detecting the 9th sata drive (there 
are 10). I left it for about 10 minutes to see if anything else transpired but it just sat there.
I'm on a serial console to this machine at the moment and I could not get it to respond to the magic 
sysrq key over serial either.

I have placed all relevant info including a capture of 2.6.5 boot and 2.6.6 boot, plus all requested 
info from linux/REPORTING-BUGS on my webpage

Normal working dmesg
http://www.wasp.net.au/~brad/2.6.5.log

Hung up dmesg
http://www.wasp.net.au/~brad/2.6.6.log

.config and all other info I could gather.
http://www.wasp.net.au/~brad/2.6.6.config
Much as I'd love to be subscribed, I just can't keep up with the volume so please cc: me.
Willing to try patches/hacks/suggestions

Actually, while I'm here I just connected 2 sata drives to the onboard via sata ports and 2.6.5 
won't detect them. All relevant info is in the logs.
insmod sata_via just silently loads and nothing occurs. The onboard raid bios detects the drives 
fine and I have no raid created or enabled.

Regards,
Brad
