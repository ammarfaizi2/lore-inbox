Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131271AbRCNCbh>; Tue, 13 Mar 2001 21:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131272AbRCNCb1>; Tue, 13 Mar 2001 21:31:27 -0500
Received: from clueserver.org ([206.163.47.224]:54279 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S131271AbRCNCbP>;
	Tue, 13 Mar 2001 21:31:15 -0500
Date: Tue, 13 Mar 2001 18:43:40 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: Terje Malmedal <terje.malmedal@usit.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alert on LAN for Linux? 
In-Reply-To: <E14cvTq-0000oH-00@morgoth>
Message-ID: <Pine.LNX.4.10.10103131842110.19423-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alert on LAN makes the system up from power management type sleep when
there are packets to be processed.  Why you would ever have sleep mode on
a server is beyond me.

To get wake on lan to work you will probably need the drivers from Intel.
They are supposed to be freely available on their site.

On Tue, 13 Mar 2001, Terje Malmedal wrote:

> 
> Alert on LAN seems to have some useful functionality, if I understand
> things correctly they have enhanced Wake-on-LAN to allow you to do
> things like reset the machine, update the BIOS and such by sending
> magic packets which are interpreted by the network card. Or maybe I am
> reading too much into this:
> 
> http://www.pc.ibm.com/us/desktop/alertonlan/
> 
> Anyway, my eepro100 cards say they are Alert on LAN capable, it would
> be very useful to be able to use this reboot a Linux box remotely:
> 
> 02:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
> 
> 	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter with Alert On LAN*
> 	Flags: bus master, medium devsel, latency 66, IRQ 11
> 	Memory at 40200000 (32-bit, non-prefetchable) [size=4K]
> 	I/O ports at 1400 [size=64]
> 	Memory at 40100000 (32-bit, non-prefetchable) [size=1M]
> 	Expansion ROM at <unassigned> [disabled] [size=1M]
> 	Capabilities: [dc] Power Management version 2
> 
> Does anybody know anything about Alert on LAN and whether it does what
> I think it does?
> 
> -- 
>  - Terje
> malmedal@usit.uio.no
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

