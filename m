Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130679AbRBKX31>; Sun, 11 Feb 2001 18:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130703AbRBKX3R>; Sun, 11 Feb 2001 18:29:17 -0500
Received: from Earth.nistix.com ([209.140.42.210]:7385 "EHLO Earth.nistix.com")
	by vger.kernel.org with ESMTP id <S130679AbRBKX27>;
	Sun, 11 Feb 2001 18:28:59 -0500
Message-ID: <3A872038.1010200@nistix.com>
Date: Sun, 11 Feb 2001 17:28:56 -0600
From: James Brents <James@nistix.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.8) Gecko/20010110
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: WOL failure after shutdown
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
In the event of a power outtage, my servers all shutdown -h when the 
backup UPS gets low, and I have them configured to start back up with a 
router (that uses an AT mobo, so it will start automatically) to send 
wakeonlan packets to my other servers to start them back up. Wakeonlan 
works if i were to hit the power before Linux starts, so I know I have 
it configured properly, and I also have wakeonlan turned on in the BIOS. 
However, when I do shutdown -h, it will turn the power off, but 
wakeonlan does not work. Ive tried enabling ACPI and tinkering with 
options in the BIOS, but i cant power up with WOL after issuing shutdown -h.
Im using an Abit KT7 motherboard, which uses the Via Apollo KT133 chipset.
Any ideas/suggestions will be greatly appreciated.

--
James Brents
James@nistix.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
