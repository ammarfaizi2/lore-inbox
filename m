Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTEND7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 23:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbTEND7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 23:59:41 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:58808 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261753AbTEND7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 23:59:40 -0400
Date: Wed, 14 May 2003 00:12:27 -0400
From: David Caplan <david@david.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: ALi M5451/Trident sound module -> video corruption
Message-ID: <20030514041227.GB2925@euphoria>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Sharp Actius MM10 "sub-notebook", on which I'm running kernel
2.4.21-rc1.
When I load the trident.o sound module, the lcd begins flashing blue
stripes continuously. I am not up to date on the current issues with
this driver, am I doing something wrong? could there be some sort of
hardware
conflict? or is it a kernel problem?

I have included the output of lspci... 
Please CC me any responses.

Thanks,
 -David



-lspci--output
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge     (rev 03)
00:00.1 RAM memory: Transmeta Corporation SDRAM controller 
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad 
00:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 81) 
00:06.0 Multimedia audio controller: ALi
    Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] 
00:09.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev c1)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
00:0b.0 Network controller: Harris Semiconductor Prism 2.5
        Wavelan chipset (rev 01) 
00:0c.0 USB Controller: NEC Corporation USB
00:0c.1 USB Controller: NEC Corporation USB (rev 41) 
00:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 02) 
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) 
00:11.0 Bridge: ALi Corporation M7101 PMU
-- 


--
David Caplan {david@david.ath.cx|dcaplan@polycode.net}
gpg fingerprint:: B586 07D3 6EC0 EB36 6866  18C8 79B3 3A94 5898 39A0	  
