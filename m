Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131339AbRCNKZN>; Wed, 14 Mar 2001 05:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131340AbRCNKZD>; Wed, 14 Mar 2001 05:25:03 -0500
Received: from pat.uio.no ([129.240.130.16]:8339 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S131339AbRCNKYq>;
	Wed, 14 Mar 2001 05:24:46 -0500
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: alan@clueserver.org
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10103131842110.19423-100000@clueserver.org>
	(message from Alan Olsen on Tue, 13 Mar 2001 18:43:40 -0800 (PST))
Subject: Re: Alert on LAN for Linux?
MIME-Version: 1.0
Message-Id: <E14d8Rh-0007Xr-00@morgoth>
Date: Wed, 14 Mar 2001 11:23:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Alan Olsen]
> Alert on LAN makes the system up from power management type sleep when
> there are packets to be processed.  Why you would ever have sleep mode on
> a server is beyond me.

No, that's Wake on LAN. 

>From the web page. http://www.pc.ibm.com/us/desktop/alertonlan/

----
   Alert on LAN provides notification of the following conditions:

       System unplugged from power source 
       System unplugged from network 
       Chassis intrusion 
       Processor removal 
       System environmental errors 
           High temperature 
           Fan speed 
           Voltage fluctuations 
       Operating system errors 
       System power-on errors 
       System is hung 

   With the latest release, Alert on LAN 2 now extends IT
   capabilities to remotely manage and control their
   networked PCs:

       Remote system reboot upon report of a critical failure 
       Repair Operating System 
       Update BIOS image 
       Perform other diagnostic procedures 

   And Alert on LAN 2 adds the capabilities for the
   administrator to take action to correct a failing
   condition on the IBM PC, increasing IT's flexibility to
   selectively respond to alerts and further reduce
   response times.
   
   Notification of alert is important, but the capability
   to act on the information is more valuable. For
   example, if a machine at a remote location is
   malfunctioning, the system administrator using Alert on
   LAN 2 can simply reset or reboot the machine.
---

The feature I really need is to be able to reset the machine remotely
when Linux is hung.

> To get wake on lan to work you will probably need the drivers from Intel.
> They are supposed to be freely available on their site.

Wake on LAN works fine, you just need to enable it in the BIOS. 

> On Tue, 13 Mar 2001, Terje Malmedal wrote:

>> 
>> Alert on LAN seems to have some useful functionality, if I understand
>> things correctly they have enhanced Wake-on-LAN to allow you to do
>> things like reset the machine, update the BIOS and such by sending
>> magic packets which are interpreted by the network card. Or maybe I am
>> reading too much into this:
>> 
>> http://www.pc.ibm.com/us/desktop/alertonlan/
>> 
>> Anyway, my eepro100 cards say they are Alert on LAN capable, it would
>> be very useful to be able to use this reboot a Linux box remotely:
>> 
>> 02:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
>> 
>> Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter with Alert On LAN*
>> Flags: bus master, medium devsel, latency 66, IRQ 11
>> Memory at 40200000 (32-bit, non-prefetchable) [size=4K]
>> I/O ports at 1400 [size=64]
>> Memory at 40100000 (32-bit, non-prefetchable) [size=1M]
>> Expansion ROM at <unassigned> [disabled] [size=1M]
>> Capabilities: [dc] Power Management version 2
>> 
>> Does anybody know anything about Alert on LAN and whether it does what
>> I think it does?
>> 
>> -- 
>> - Terje
>> malmedal@usit.uio.no
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> 

> alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
> Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
>     "In the future, everything will have its 15 minutes of blame."


