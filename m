Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267756AbTAUVP7>; Tue, 21 Jan 2003 16:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTAUVP7>; Tue, 21 Jan 2003 16:15:59 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:4536 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S267756AbTAUVP6>; Tue, 21 Jan 2003 16:15:58 -0500
Message-ID: <3E2DBAA2.1020401@bogonomicon.net>
Date: Tue, 21 Jan 2003 15:24:50 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NForce Chipset support in which kernels?
References: <3E287188.9030909@hanaden.com> <1043052878.12182.26.camel@dhcp22.swansea.linux.org.uk> <001d01c2c161$90449f40$0100a8c0@pcs686> <20030121161857.GA2139@gtf.org> <000d01c2c16d$20484b40$0100a8c0@pcs686>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using an ASUS A7N8X (nForce2 chipset) with linux-2.4.21-pre3-ac4 + 
the patch for the __free_pages_ok oops, Subject: "[patch] 2.4.21-pre3-ac 
oops".  I also added the latest nForce drivers for both it's nic and 
audio, but they load with symbol mismatches.  I am using the nVidia NIC 
with the nvnet driver.  I haven't used sound yet as something isn't 
configured correctly yet, haven't tracked it down yet as that is low 
priority.  The system just became stable with the oops patch.  I have 
the 3Com NIC recognised, but not used.  Sofar the nVidia NIC is 
transmitting and receiving fine.  I transfered data to the system over 
the network in 100MBit full duplex mode on a switched network and it 
didn't hicup at all.  The transfer saturated the network for a few hours 
so it got a good workout.  The new copy md5sumed identicle to the 
original so there weren't hidden issues in the transfer.  For the long 
term, who knows how it will hold up.  I don't have any IEEE 1394, or 
serial IDE devices so they haven't been tested.  I haven't used USB yet, 
but it is recognised.  As of right now I'm doing testing for stability 
assesment and all looks good.

- Bryan

>>It is also worth noting that many nForce boards come with 8139
>>on-board.  I guess some board makers don't trust the nVidia NIC
>>hardware either...

> Some nForce 2 boards will ship with a 3Com nic chip that is inbeded in the
> system.
> 

