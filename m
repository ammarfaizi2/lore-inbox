Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRBLChe>; Sun, 11 Feb 2001 21:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129335AbRBLChY>; Sun, 11 Feb 2001 21:37:24 -0500
Received: from Earth.nistix.com ([209.140.42.210]:28889 "EHLO Earth.nistix.com")
	by vger.kernel.org with ESMTP id <S129267AbRBLChK>;
	Sun, 11 Feb 2001 21:37:10 -0500
Message-ID: <3A874C51.5030207@nistix.com>
Date: Sun, 11 Feb 2001 20:37:05 -0600
From: James Brents <James@nistix.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.8) Gecko/20010110
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: WOL failure after shutdown
In-Reply-To: <Pine.LNX.4.10.10102111831050.30844-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I wrote that in a hurry. Its a 3Com PCI 3c905C Tornado. I can 
successfully use wakeonlan if I power off the machine immeadiatly after 
turning it on. Using the shutdown command, which it will when I need it 
to power back up, it will not work.
Im using a wakeonlan cable to my motherboard as well, not using wake 
through PCI bus.
Kernel is 2.4.1
I appologize for not providing all required the specs in the original 
message.

--
James

Mark Hahn wrote:

>> wakeonlan packets to my other servers to start them back up. Wakeonlan 
>> works if i were to hit the power before Linux starts, so I know I have 
>> it configured properly, and I also have wakeonlan turned on in the BIOS. 
>> However, when I do shutdown -h, it will turn the power off, but 
>> wakeonlan does not work. Ive tried enabling ACPI and tinkering with 
>> options in the BIOS, but i cant power up with WOL after issuing shutdown -h.
> 
> 
> so when can you powerup with WOL?  WOL requires that the driver leave the 
> card in a particular state; obviously, you should mention which NIC.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
