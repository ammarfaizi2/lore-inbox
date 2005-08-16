Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbVHPNeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVHPNeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbVHPNeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:34:50 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:6364 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S965217AbVHPNet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:34:49 -0400
Message-ID: <1124199287.4301eb7780623@imp5-q.free.fr>
Date: Tue, 16 Aug 2005 15:34:47 +0200
From: mustang4@free.fr
To: Willy TARREAU <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Hang or stop after uncompressing MPC8245
References: <1124122213.4300be659dc89@imp5-q.free.fr> <20050815155505.GF20363@alpha.home.local> <1124125002.4300c94a31810@imp5-q.free.fr> <20050815165141.GA29660@alpha.home.local> <1124136498.4300f6321bb1b@imp5-q.free.fr> <20050815205418.GA1745@pcw.home.local>
In-Reply-To: <20050815205418.GA1745@pcw.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 57.250.252.246
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot Willy,

I try to find something in this way...

Note, that i test my board with an image with Kernel 2.4 and work well.. but
it's a no-free version (i don't have source or configuration) ... Me, i want to
boot with my own kernel and find correct configuration...
This system use, i thinks, a patch to the kernel, or more simply, a good kernel
configuration options...
There is no reason i can't boot with an "official open linux kernel" and boot
with a "no-free" version which use a free kernel...

Here the log ;

to 0x01000000       1218 kB
Loaded 0x001308b0 bytes
Detected PPCBOOT header
   Verifying image CRC...ok
   Uncompressing Multi-File Image ... ok
   Moving initrd...ok
   Starting Linux Kernel.

MENMON parameter string: MPAR mem0=262144 mem1=0 flash0=2048 cpu=MPC8245 cpuclkO
Using memory size from MENMON 0x10000000
Linux version 2.4.18 (ww@swserver) (gcc version 3.2.3) #2 Tue Aug 9 15:32:12 CE5
---menem04_setup_arch---
menem04_find_bridges:
hose:0xc0167000
i2c-core.o: i2c core module
i2c-core.o: /proc/bus/ does not exist
menem04_i2c.o: i2c MEN EM04 adapter module
i2c-core.o: adapter I2C MEN EM04 registered as adapter 0.
i2c-core.o: driver M41T56 registered.
i2c-core.o: client [M41T56] registered to adapter [I2C MEN EM04](pos. 0).
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: devfs=mount root=ramfs rw console=ttyS0,9600
Using bus clock from MENMON 128000000Hz
MEN Chameleon number modules: 12
Frodo #0: phys.adr:0xbff7e500  irq:5
Frodo channel 0: mode=0x01
Frodo channel 1: mode=0x01
Frodo channel 2: mode=0x01
Frodo channel 3: mode=0x01
BOROMIR: phys.adr:0xbff7e600
OpenPIC Version 1.2 (1 CPUs and 139 IRQ sources) at fcfce000
OpenPIC timer frequency is 128.000000 MHz
Calibrating delay loop... 255.59 BogoMIPS
Memory: 256084k available (748k kernel code, 324k data, 68k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
i2c-core.o: driver AT24Cxx registered.
at24cxx_attach:  adap:0xc00d7b7c  addr:0x50  flags:0x0  kind:0xffffffff
i2c-core.o: client [AT24Cxx] registered to adapter [I2C MEN EM04](pos. 1).
at24cxx_attach:  adap:0xc00d7b7c  addr:0x54  flags:0x0  kind:0xffffffff
i2c-core.o: client [AT24Cxx] registered to adapter [I2C MEN EM04](pos. 2).
at24cxx_attach:  adap:0xc00d7b7c  addr:0x55  flags:0x0  kind:0xffffffff
i2c-core.o: client [AT24Cxx] registered to adapter [I2C MEN EM04](pos. 3).
at24cxx_attach:  adap:0xc00d7b7c  addr:0x56  flags:0x0  kind:0xffffffff
i2c-core.o: client [AT24Cxx] registered to adapter [I2C MEN EM04](pos. 4).
at24cxx_attach:  adap:0xc00d7b7c  addr:0x57  flags:0x0  kind:0xffffffff
i2c-core.o: client [AT24Cxx] registered to adapter [I2C MEN EM04](pos. 5).
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
menem04_i2c.o: i2c MEN EM04 adapter module
i2c-core.o: adapter I2C MEN EM04 registered as adapter 0.
i2c-core.o: driver M41T56 registered.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ed
ttyS00 at 0xfcfcc500 (irq = 137) is a 16550A
ttyS01 at 0xfcfcc600 (irq = 138) is a 16550A
ttyS02 at 0xfcfca500 (irq = 5) is a 16550A
ttyS03 at 0xfcfca510 (irq = 5) is a 16550A
ttyS04 at 0xfcfca520 (irq = 5) is a 16550A
ttyS05 at 0xfcfca530 (irq = 5) is a 16550A
menpci2vme: PCI2VME bridge vendor/device 1172/5056 not exist
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: PQI ATA Rev6.0, ATA DISK drive
ide0 at 0xd3002200-0xd300221c,0xd3002238 on irq 4
hda: 125952 sectors (64 MB) w/0KiB Cache, CHS=984/16/8
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
VFS: Mounted root (ramfs filesystem).
UNTAR: Extracting root archive: done.
Mounted devfs on /dev
Freeing unused kernel memory: 68k init
init started:  BusyBox v1.00-pre8 (2004.05.27-20:35+0000) multi-call binary


BusyBox v1.00-pre8 (2004.05.27-20:35+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.

#


> On Mon, Aug 15, 2005 at 10:08:18PM +0200, mustang4@free.fr wrote:
> > Thanks Willy,
> >
> > So i just compile a new Kernel with options we have talking about...
> > And it's freeze, nothing to the console...
> >
> > So i need to find the way to enable the Level-Triggered Interrupts in the
> kernel
> > to the right IRQ address...
>
> sorry, but I did not find much more info either. I don't know how to change
> those
> IRQs from edge to level. It is from software, on the board itself ? I don't
> know.
> I found interesting pieces of code there :
>
>    # grep -r IRQ_SENSE /usr/src/linux-2.4.31/arch/ppc/kernel
>
> They seem to imply that the interrupt mode (level/edge) is read from
> somewhere at
> boot, but I have no idea where. May be they can be configured from the boot
> loader ?
>
> > I read the thread... but i can't find the thing to change in kernel source
> or
> > kernel configuration.
> >
> > Or perhaps i enable to many option in
> > "Device Drivers  --->" "Character devices-->" "Serial drivers  --->"
> > <*> 8250/16550 and compatible serial support                     x x
> >   x x    [*]   Console on 8250/16550 and compatible serial port           x
> x
> >   x x    (4)   Maximum number of non-legacy 8250/16550 serial ports       x
> x
> >   x x    [*]   Extended 8250/16550 serial driver options                  x
> x
> >   x x    [*]     Support more than 4 legacy serial ports                  x
> x
> >   x x    [*]     Support for sharing serial interrupts                    x
> x
> >   x x    [ ]     Autodetect IRQ on standard ports (unsafe)                x
> x
> >   x x    [*]     Support special multiport boards                         x
> x
> >   x x    [*]     Support RSA serial ports
> >
> > Try autodetect IRQ ?
> > I'll try to learn more about  edge/level irq sharing...
>
> well, I still do not know how the serial driver manages to find those
> specific
> addresses. You should ask one of the people involved in the previous threads,
> he might have more clue.
>
> Regards,
> Willy
>
> >
> > Yann
> >
> > > Hi,
> > >
> > > On Mon, Aug 15, 2005 at 06:56:42PM +0200, mustang4@free.fr wrote:
> > > > Hi,
> > >
> > > > This is what my board say (in console mode) about serial address:
> > > > 0x08 COM1             DUART8245    0xfc004500 0x07a12000 0x00000001
> > > 0x01effc70
> > > > 0x09 COM2             DUART8245    0xfc004600 0x07a12000 0x00000001
> > > 0x01e107d0
> > >
> > > Have you read this thread ?
> > >
> > >   http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019482.html
> > >
> > > It discusses your about your board, on which interrupts must be set to
> LEVEL
> > > and not EDGE. BTW, they also used 8250. I don't know how you have to
> > > configure
> > > the serial ports though.
> > >
> > > This boot log also confirms that you have to use 8250/16550 :
> > >
> > >   http://mhonarc.axis.se/jffs-dev/msg01350.html
> > >
> > > > >   - are you sure that you enabled "console on serial port" in the
> config
> > > ?
> > > > Yes, i enable " Support for console on virtual terminal" but i enable
> > > > "Non-standard serial port support" option too...
> > > > So i recompile without the last one... and i recompile "with Serial
> drivers
> > > > --->" "[*]   Console on 8250/16550 and compatible serial port" perhaps
> it's
> > > > that... And i came back to you.
> > > > But, perhaps i've allready tested... i ll check.. it's not a default
> option
> > > ?
> > >
> > > It's not necessarily a default option. There are many console and serial
> > > ports combination available. BTW, you could also try netconsole which
> will
> > > send you the console data over an ethernet port if you cannot get the
> serial
> > > to work.
> > >
> > > > >   - how can you be certain that the serial will appear on ttyS0 and
> not
> > > ttyS1
> > > > >     or another one (the kernel might detect another serial port which
> it
> > > > >     assigns ttyS0)
> > > > I pass parameter directly to the kernel;
> > >
> > > ok.
> > >
> > > > Another option i set :
> > > >  Default bootloader kernel arguments  x x  x x(console=ttyS0,9600
> > > console=tty0
> > >
> > > ok.
> > >
> > > Regards,
> > > Willy
> > >
> > >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


