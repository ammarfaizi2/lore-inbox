Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129473AbQJ2VPz>; Sun, 29 Oct 2000 16:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129556AbQJ2VPp>; Sun, 29 Oct 2000 16:15:45 -0500
Received: from pop08-1-ras1-p24.barak.net.il ([212.150.109.24]:32260 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129473AbQJ2VP1>; Sun, 29 Oct 2000 16:15:27 -0500
Message-ID: <39FC93AB.8020400@xpert.com>
Date: Sun, 29 Oct 2000 23:16:27 +0200
From: Constantine Gavrilov <const-g@xpert.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18-pre15custom i686; en-US; m18) Gecko/20001010
X-Accept-Language: en
MIME-Version: 1.0
To: babina@pex.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP System 2.2.15 #2 locking 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could be a hardware problem. Check the errata/bios updates for your 
board or system. I had a similar problem and it turned out to be a 
hardware BUG with an Intel server board. It is funny the way they 
describe the bug -- it is a manufacturer problem that affects only one 
of 5 (or 6, I do not remember)  PCI slots. If you have a card in that 
slot, the system locks up under loads randomly. They solve it with a 
BIOS upgrade by degrading PCI clocks on all of the slots!

The BIOS upgrade did solve my problem and the system uptime has been 
above 4 months now. Before the upgrade, the system crashed once each 
24-48 hours.

-- 
----------------------------------------
Constantine Gavrilov
Unix System Administrator and Programmer
Xpert Integrated Systems
1 Shenkar St, Herzliya 46725, Israel
Phone: (972-8)-952-2361
Fax:   (972-9)-952-2366
----------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
