Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264692AbRF1WAq>; Thu, 28 Jun 2001 18:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264709AbRF1WAg>; Thu, 28 Jun 2001 18:00:36 -0400
Received: from jalon.able.es ([212.97.163.2]:61922 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264692AbRF1WA2>;
	Thu, 28 Jun 2001 18:00:28 -0400
Date: Fri, 29 Jun 2001 00:04:42 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Message-ID: <20010629000442.A4544@werewolf.able.es>
In-Reply-To: <20010627225421.A23843@vitelus.com> <JKEGJJAJPOLNIFPAEDHLKECBDEAA.laramie.leavitt@btinternet.com> <20010628124738.O8027@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010628124738.O8027@altus.drgw.net>; from hozer@drgw.net on Thu, Jun 28, 2001 at 19:47:38 +0200
X-Mailer: Balsa 1.1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010628 Troy Benjegerdes wrote:
>> >
>> > > usb-uhci.c: v1.251 Georg Acher, Deti Fliegl, Thomas Sailer,
>> > Roman Weissgaerber
>> > > usb-uhci.c: USB Universal Host Controller Interface driver
>> >
>> > How about "usb-uhci.c: USB Universal Host Controller Interface
>> > driver v1.251"
>> > instead?
>> >

Sorry if this has appeared before in the thread...

I like the boot messages (as everyone running linus, I suppose) because you
know what is it doing really. But boot is now a real mesh. If toy want to
find something you have to read all.

Would't it be nice to give a template or a try to standarise the init or
module insertion messages ? Someone that can have a global view of what
kind of info a subsystem or a driver can print (name of driver, version,
devices detected

Say you can change:

Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05b (2001-05-03) with MANY_PORTS SHARE_IRQ SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
block: queued sectors max/low 169645kB/56548kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later

To:

kswapd:
	Version: 1.8
pty: 
	Version: xxxxx
	Devices: 256 Unix98 ptys configured
serial:
	Version: 5.05b (2001-05-03) with 
	Options: MANY_PORTS SHARE_IRQ SERIAL_PCI
	Devices: ttyS00 at 0x03f8 (irq = 4) is a 16550A
		 ttyS01 at 0x02f8 (irq = 3) is a 16550A
rtclock:
	Version: 1.10d
ide:
	Version: 6.31
......

Just an idea....

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac19 #2 SMP Thu Jun 28 00:12:01 CEST 2001 i686
