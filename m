Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132581AbRDBALg>; Sun, 1 Apr 2001 20:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132589AbRDBAL0>; Sun, 1 Apr 2001 20:11:26 -0400
Received: from imap.digitalme.com ([193.97.97.75]:20069 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S132581AbRDBALO>;
	Sun, 1 Apr 2001 20:11:14 -0400
Message-ID: <3AC7B54C.2010706@bigfoot.com>
Date: Sun, 01 Apr 2001 19:10:04 -0400
From: "Trever L. Adams" <trever_Adams@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
CC: linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial, 115Kbps, 2.2, 2.4
In-Reply-To: <Pine.LNX.4.10.10104011432180.5518-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

>> There may be a possibility this is machine specific, because if it is 
>> meant to forward the packet to the internal net and I slow the machine 
>> down (external cache off) it works fine, turn the cache back on and it 
>> is a problem.
> 
> 
> where's the serial port?  (isa, pci?)  could there be a problem
> with something being overclocked (like >8 MHz ISA, etc)?
> also, is the port's fifo detected and used?


As far as I know the system is not overclocked (standard Digital 
Venturis 6200 GL PPro 200 Mhz machine).  It is an ISA modem.  All info I 
have on the port is as follows:

Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A

cat /proc/ioports
03f8-03ff : serial(auto)

It is a USR 56K Voice/Fax/Modem.  I am unable to find the exact model. 
It was definitely pre v.90 though I believe it has been updated 
(Firmware) to that.  I have another, though I don't remember similar 
problems even though it was at the same baudrate (different machine though).

Trever Adams

