Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUAVNGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 08:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266251AbUAVNGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 08:06:54 -0500
Received: from dmz01.zas.gwz-berlin.de ([195.37.93.3]:62222 "HELO
	dmz01.zas.gwz-berlin.de") by vger.kernel.org with SMTP
	id S265971AbUAVNGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 08:06:52 -0500
Message-ID: <400FCAEA.8030300@zas.gwz-berlin.de>
Date: Thu, 22 Jan 2004 14:06:50 +0100
From: Axel Beier <axel@zas.gwz-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-DE; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.2-rc1 and 3c59x driver freeze at transfer
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
my system freezes on heavy traffic over a 3c59x.ko driver. This happens 
with kernels 2.6.0 upto 2.6.2-rc1.
I have an Asus A7N8X-deluxe motherboard with the 3C920-EMB chip activ.
The system freezes after 4-6 secs or ~60MB transfered over nfs or scp
regardless of acpi or preemtive, all tested...
My older 2.4.21-155 (from SuSE 9.0) loads the 3x59x.o but the syslog 
reports a 3c905C Tornado at ...
Windows on the same machine finds a 3c920-EMB too.

I had debug activated for the 3c59x. Level 1-4 freezes again, Level 5 
and up gives a lot of info in the syslog and the kernel does not freeze!
Transfers are ok with debug level 5 and 6....

Now i have inserted a card with a realtek 8139D chip and the 8139too 
drivers (for tests only - all my slots are needed otherway).
With the realtek drivers i had just transfer over 4GB without problems.
So it seems a problem of the 3x59x driver and 2.6.x kernel.

Regards,
Axel
