Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266317AbUFZAap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266317AbUFZAap (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 20:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266765AbUFZAap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 20:30:45 -0400
Received: from lucidpixels.com ([66.45.37.187]:61924 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S266317AbUFZAaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 20:30:05 -0400
Date: Fri, 25 Jun 2004 20:29:57 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
cc: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       linux-kernel@vger.kernel.org
Subject: RE: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
 Allocation Failures
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E018FD85C@orsmsx408>
Message-ID: <Pine.LNX.4.60.0406252029300.25838@p500>
References: <468F3FDA28AA87429AD807992E22D07E018FD85C@orsmsx408>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is:

     description: Computer
     capabilities: smbios-2.2 dmi-2.2
     configuration: boot=normal uuid=00000000-0000-0000-0000-00508DF10738
   *-core
        description: Motherboard
        product: IC7/IC7-G(Intel i875P-ICH5)
        vendor: http://www.abit.com.tw/
        physical id: 0
        version: 1.0/1.1
      *-firmware
           description: BIOS
           vendor: Phoenix Technologies, LTD
           physical id: 0
           version: 6.00 PG (04/27/2004)
           size: 128KB
           capacity: 448KB
           capabilities: isa pci pnp apm upgrade shadowing cdboot bootselect socketedrom edd int13floppy360 int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer int10video acpi usb agp ls120boot zipboot
      *-cpu:0
           description: CPU
           product: Intel(R) Pentium(R) 4 CPU 2.60GHz
           vendor: Intel Corp.
           physical id: 4
           version: 15.2.9
           slot: Socket 478
           size: 2600MHz
           capacity: 4GHz
           clock: 200MHz
           capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
         *-cache:0
              description: L1 cache
              physical id: a
              slot: Internal Cache
              size: 8KB
              capacity: 20KB
              capabilities: synchronous internal write-back
         *-cache:1
              description: L2 cache
              physical id: b
              slot: External Cache
              size: 512KB
              capacity: 512KB
              capabilities: synchronous external write-back
      *-memory
           description: System Memory
           physical id: 1d
           slot: System board or motherboard
           size: 2GB
         *-bank:0
              description: DIMM SDRAM Synchronous
              physical id: 0
              slot: A0
              size: 512MB
              configuration: width=64
         *-bank:1
              description: DIMM SDRAM Synchronous
              physical id: 1
              slot: A1
              size: 512MB
              configuration: width=64
         *-bank:2
              description: DIMM SDRAM Synchronous
              physical id: 2
              slot: A2
              size: 512MB
              configuration: width=64
         *-bank:3
              description: DIMM SDRAM Synchronous
              physical id: 3
              slot: A3
              size: 512MB
              configuration: width=64
      *-cpu:1
           product: Intel(R) Pentium(R) 4 CPU 2.60GHz
           vendor: Intel Corp.
           physical id: 1
           version: 15.2.9
           size: 2606MHz
           capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
         *-cache:0
              description: L1 cache
              physical id: 0
              size: 8KB
         *-cache:1
              description: L2 cache
              physical id: 1
              size: 512KB
      *-pci
           physical id: e8000000
           bus info: pci@00:00.0
           version: 02
           clock: 33MHz
           resources: iomemory:e8000000-efffffff
         *-pci:0
              physical id: 1
              bus info: pci@00:01.0
              version: 02
              clock: 66MHz
              capabilities: pci bus_master
            *-display UNCLAIMED
                 physical id: 0
                 bus info: pci@01:00.0
                 version: a1
                 size: 128MB
                 clock: 66MHz
                 capabilities: bus_master cap_list
                 resources: iomemory:f8000000-f8ffffff iomemory:f0000000-f7ffffff irq:16
         *-pci:1
              physical id: 3
              bus info: pci@00:03.0
              version: 02
              clock: 66MHz
              capabilities: pci bus_master
            *-network
                 description: Ethernet interface
                 physical id: 1
                 bus info: pci@02:01.0
                 logical name: eth0
                 version: 00
                 serial: 00:50:8d:f1:07:38
                 size: 100Mbps
                 clock: 66MHz
                 capabilities: bus_master cap_list mii autonegotiation 100bt-fd 100bt 10bt-fd 10bt ethernet physical
                 configuration: autonegociated=100bt broadcast=yes driver=e1000 driverversion=5.2.52-k4 duplex=full firmware=N/A ip=192.168.168.12 link=yes multicast=yes
                 resources: iomemory:fc000000-fc01ffff ioport:b000-b01f irq:18
         *-pci:2
              physical id: 1e
              bus info: pci@00:1e.0
              version: c2
              clock: 33MHz
              capabilities: pci bus_master
            *-storage
                 physical id: 4
                 bus info: pci@03:04.0
                 version: 02
                 clock: 66MHz
                 capabilities: storage bus_master cap_list
                 configuration: driver=Promise IDE
                 resources: ioport:9000-9007 ioport:9400-9403 ioport:9800-9807 ioport:9c00-9c03 ioport:a000-a00f iomemory:fb000000-fb003fff irq:20
               *-ide
                    description: IDE Channel 0
                    physical id: 2
                    bus info: ide@2
                    logical name: ide2
                    clock: 66MHz
                  *-disk
                       description: ATA Disk
                       product: ST380021A
                       vendor: Seagate
                       physical id: 0
                       bus info: ide@2.0
                       logical name: /dev/hde
                       version: 3.10
                       serial: 3HV0CD7W
                       size: 74GB
                       capacity: 74GB
                       capabilities: ata dma lba iordy smart security pm
                       configuration: mode=udma5 smart=on
            *-multimedia
                 physical id: 5
                 bus info: pci@03:05.0
                 version: 07
                 clock: 33MHz
                 capabilities: bus_master cap_list
                 configuration: driver=emu10k1
                 resources: ioport:a400-a41f irq:21
            *-input UNCLAIMED
                 physical id: 5.1
                 bus info: pci@03:05.1
                 version: 07
                 clock: 33MHz
                 capabilities: bus_master cap_list
                 resources: ioport:a800-a807
            *-scsi UNCLAIMED
                 physical id: 7
                 bus info: pci@03:07.0
                 version: 03
                 clock: 33MHz
                 capabilities: scsi bus_master cap_list
                 resources: ioport:ac00-acff iomemory:fb004000-fb004fff irq:23
         *-isa UNCLAIMED
              physical id: 1f
              bus info: pci@00:1f.0
              version: 02
              clock: 33MHz
              capabilities: isa bus_master
         *-ide
              physical id: 1f.1
              bus info: pci@00:1f.1
              version: 02
              clock: 33MHz
              capabilities: ide bus_master
              configuration: driver=PIIX IDE
              resources: ioport:f000-f00f iomemory:80000000-800003ff irq:18
            *-ide:0
                 description: IDE Channel 0
                 physical id: 0
                 bus info: ide@0
                 logical name: ide0
                 clock: 33MHz
               *-cdrom
                    description: CD-R/CD-RW writer
                    product: PLEXTOR CD-R PX-W1210A
                    physical id: 0
                    bus info: ide@0.0
                    logical name: /dev/hda
                    version: 1.10
                    capabilities: packet atapi cdrom removable nonmagnetic dma lba iordy audio cd-r cd-rw
            *-ide:1
                 description: IDE Channel 1
                 physical id: 1
                 bus info: ide@1
                 logical name: ide1
                 clock: 33MHz
               *-cdrom:0
                    description: CD-R/CD-RW writer
                    product: PLEXTOR CD-R PX-W1210A
                    physical id: 0
                    bus info: ide@1.0
                    logical name: /dev/hdc
                    version: 1.10
                    capabilities: packet atapi cdrom removable nonmagnetic dma lba iordy audio cd-r cd-rw
               *-cdrom:1
                    description: DVD reader
                    product: TOSHIBA DVD-ROM SD-M1712
                    vendor: Toshiba
                    physical id: 1
                    bus info: ide@1.1
                    logical name: /dev/hdd
                    version: 1004
                    capabilities: packet atapi cdrom removable nonmagnetic dma lba iordy audio dvd
                    configuration: mode=udma2
         *-serial
              physical id: 1f.3
              bus info: pci@00:1f.3
              version: 02
              clock: 33MHz
              configuration: driver=i801 smbus
              resources: ioport:500-51f irq:17
   *-network DISABLED
        description: Ethernet interface
        physical id: 1
        logical name: dummy0
        serial: 1a:60:19:07:1a:f0
        capabilities: ethernet physical
        configuration: broadcast=yes

On Fri, 25 Jun 2004, Venkatesan, Ganesh wrote:

> Could you send me details on your machine (processor, motherboard,
> memory size, etc.)?
>
> Thanks,
> ganesh
>
> -------------------------------------------------
> Ganesh Venkatesan
> Network/Storage Division, Hillsboro, OR
>
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Piszcz, Justin
> Michael
> Sent: Monday, June 14, 2004 5:03 AM
> To: Justin Piszcz; linux-kernel@vger.kernel.org
> Subject: RE: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
> Allocation Failures
>
> Anyone have any suggestions on how to fix this?
>
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Justin Piszcz
> Sent: Saturday, June 12, 2004 4:44 AM
> To: linux-kernel@vger.kernel.org
> Subject: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
> Allocation Failures
>
> When I run: ifconfig eth0 mtu 9000
>
> Also, I tried to copy a file from 2.6.5 -> 2.4.26 (over NFS) and it did
> not copy, although I saw my hard disk reading @ 35-40MB/s until it was
> "ready to copy?" but it never sent any packets over the network.
>
> On kernel: 2.4.26 I get no errors.
> On kernel: 2.6.5 I get a lot of errors, they are:
>
> Kernel 2.4.26 Intel Card:
>
> 00:0d.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet
> Controller
>         Subsystem: Intel Corp.: Unknown device 1113
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>> TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (63750ns min), cache line size 08
>         Interrupt: pin A routed to IRQ 10
>         Region 0: Memory at ff040000 (32-bit, non-prefetchable)
> [size=128K]
>         Region 1: Memory at ff020000 (32-bit, non-prefetchable)
> [size=128K]
>         Region 2: I/O ports at cc80 [size=64]
>         Expansion ROM at f9000000 [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [e4] PCI-X non-bridge device.
>                 Command: DPERE- ERO+ RBC=0 OST=0
>                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0]
> Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
>                 Address: 0000000000000000  Data: 0000
>
>  Kernel 2.6.5 Intel Card:
>
> 02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet
> Controller (LOM)
>         Subsystem: ABIT Computer Corp.: Unknown device 1014
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>> TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0 (63750ns min), cache line size 08
>         Interrupt: pin A routed to IRQ 18
>         Region 0: Memory at fc000000 (32-bit, non-prefetchable)
> [size=128K]
>         Region 2: I/O ports at a000 [size=32]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>
> $ dmesg
> ages+0x1b/0x31
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<c011a906>] recalc_task_prio+0xdf/0x1c9
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> printk: 53 messages suppressed.
> swapper: page allocation failure. order:3, mode:0x20
> Call Trace:
>  [<c01401b5>] __alloc_pages+0x30d/0x311
>  [<c01401d4>] __get_free_pages+0x1b/0x31
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> printk: 165 messages suppressed.
> swapper: page allocation failure. order:3, mode:0x20
> Call Trace:
>  [<c01401b5>] __alloc_pages+0x30d/0x311
>  [<c01401d4>] __get_free_pages+0x1b/0x31
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<c011a906>] recalc_task_prio+0xdf/0x1c9
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> printk: 94 messages suppressed.
> swapper: page allocation failure. order:3, mode:0x20
> Call Trace:
>  [<c01401b5>] __alloc_pages+0x30d/0x311
>  [<c01401d4>] __get_free_pages+0x1b/0x31
>  [<c011c8c6>] __wake_up_common+0x38/0x57
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> printk: 95 messages suppressed.
> swapper: page allocation failure. order:3, mode:0x20
> Call Trace:
>  [<c01401b5>] __alloc_pages+0x30d/0x311
>  [<c01401d4>] __get_free_pages+0x1b/0x31
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<f8e34b00>] nv_unlock_rm+0x45/0x46 [nvidia]
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> printk: 68 messages suppressed.
> swapper: page allocation failure. order:3, mode:0x20
> Call Trace:
>  [<c01401b5>] __alloc_pages+0x30d/0x311
>  [<c01401d4>] __get_free_pages+0x1b/0x31
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> printk: 41 messages suppressed.
> swapper: page allocation failure. order:3, mode:0x20
> Call Trace:
>  [<c01401b5>] __alloc_pages+0x30d/0x311
>  [<c01401d4>] __get_free_pages+0x1b/0x31
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> printk: 30 messages suppressed.
> swapper: page allocation failure. order:3, mode:0x20
> Call Trace:
>  [<c01401b5>] __alloc_pages+0x30d/0x311
>  [<c01401d4>] __get_free_pages+0x1b/0x31
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> printk: 46 messages suppressed.
> swapper: page allocation failure. order:3, mode:0x20
> Call Trace:
>  [<c01401b5>] __alloc_pages+0x30d/0x311
>  [<c01401d4>] __get_free_pages+0x1b/0x31
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<c011a906>] recalc_task_prio+0xdf/0x1c9
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> printk: 33 messages suppressed.
> swapper: page allocation failure. order:3, mode:0x20
> Call Trace:
>  [<c01401b5>] __alloc_pages+0x30d/0x311
>  [<c01401d4>] __get_free_pages+0x1b/0x31
>  [<c011c8c6>] __wake_up_common+0x38/0x57
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> printk: 136 messages suppressed.
> swapper: page allocation failure. order:3, mode:0x20
> Call Trace:
>  [<c01401b5>] __alloc_pages+0x30d/0x311
>  [<c01401d4>] __get_free_pages+0x1b/0x31
>  [<c011c8c6>] __wake_up_common+0x38/0x57
>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>  [<c014265b>] __kmalloc+0x6a/0x6c
>  [<c0303291>] alloc_skb+0x53/0xfc
>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
>  [<c02d9cb1>] serio_interrupt+0x7c/0xaf
>  [<c030843e>] net_rx_action+0x77/0xf9
>  [<c0125536>] do_softirq+0x6e/0xcd
>  [<c0108da1>] do_IRQ+0x19a/0x206
>  [<c01070b8>] common_interrupt+0x18/0x20
>  [<c0104581>] default_idle+0x0/0x2c
>  [<c01045aa>] default_idle+0x29/0x2c
>  [<c010460e>] cpu_idle+0x2e/0x3c
>  [<c04726c9>] start_kernel+0x371/0x3fb
>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
