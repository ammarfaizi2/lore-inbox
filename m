Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVBAMuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVBAMuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 07:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVBAMuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 07:50:44 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:28860 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262008AbVBAMui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 07:50:38 -0500
Message-ID: <41FF8935.6020107@tiscali.de>
Date: Tue, 01 Feb 2005 14:50:45 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [NDISWRAPPER]: Belkin 6001DE: iwconfig: not able to change parameters
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I have a Belkin 6001DE, I tried get it working with ndiswrapper (I tried
4 different drivers), but I wasn't able to change wireless parameters,
e.g. the essid. I followed a instructions from the wiki. Compiling
ndiswrapper with debug=3 didn't give an additional information.

[root@iceowl ~]# lspci -v
02:01.0 Ethernet controller: Belkin: Unknown device 6001 (rev 20)
        Subsystem: Belkin: Unknown device 6001
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at 9000 [size=256]
        Memory at e3003000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2


[root@iceowl ~]# cat /proc/pci
  Bus  2, device   1, function  0:
    Ethernet controller: Belkin Wireless PCI Card - F5D6001 (rev 32).
      IRQ 12.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0x9000 [0x90ff].
      Non-prefetchable 32 bit memory at 0xe3003000 [0xe30030ff].

How can I get it working?

Thanks
Matthias-Christian Ott


