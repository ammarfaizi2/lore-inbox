Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSA0RdP>; Sun, 27 Jan 2002 12:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSA0RdF>; Sun, 27 Jan 2002 12:33:05 -0500
Received: from [195.63.194.11] ([195.63.194.11]:22800 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S288248AbSA0Rcx>; Sun, 27 Jan 2002 12:32:53 -0500
Message-ID: <3C5439C1.6000305@evision-ventures.com>
Date: Sun, 27 Jan 2002 18:32:49 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CRAP in 2.4.18-pre7
In-Reply-To: <20020126171545.GB11344@fefe.de> <3C52E671.605FA2F3@mandrakesoft.com> <3C540A90.5020904@evision-ventures.com> <3C542FE6.7C56D6BD@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>Martin Dalecki wrote:
>
>>I would like to notice that the changes in 2.4.18-pre7 to the
>>tulip eth driver are apparently causing absymal performance drops
>>on my version of this card. Apparently the performance is dropping
>>from the expected 10MB/s to about 10kB/s. The only special
>>thing about the configuration in question is the fact that it's
>>a direct connection between two hosts. Well, more precisely it's
>>a cross-over link between my notebook and desktop.
>>
>
>Are you seeing collisions?
>
NO not at all! The transfer is one with scp over a corssover direct link 
between two hosts.
No hub between involved.

>What is the other side configured as?
>
00:00.0 Host bridge: Intel Corp. 82440MX I/O Controller (rev 01)
00:00.2 Modem: Intel Corp.: Unknown device 7196
00:02.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM 
(rev b1)
00:06.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 
(rev 12)
00:07.0 ISA bridge: Intel Corp. 82440MX PCI to ISA Bridge (rev 01)
00:07.1 IDE interface: Intel Corp. 82440MX EIDE Controller
00:07.2 USB Controller: Intel Corp. 82440MX USB Universal Host Controller
00:07.3 Bridge: Intel Corp. 82440MX Power Management Controller
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
00:0c.0 CardBus bridge: Texas Instruments PCI1451 PC card Cardbus Controller
00:0c.1 CardBus bridge: Texas Instruments PCI1451 PC card Cardbus Controller

And works otherwise fine everywhere.

>What type of cabling?
>

CAT5 crossover nothing unusual. It's a direct link between two hosts.
Most wiredly the transfer doesn't abort or therelike. It's just getting 
absymally sloooooow.

>>Here is an excerpt from the lspci command:
>>
>>00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21041
>>
>
>This is interesting considering that for most people, 21041 did not work
>at all until 2.4.18-preXX tulip patches.
>
Well maybe it helps this is version 17 of the chip.


