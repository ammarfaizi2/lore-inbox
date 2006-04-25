Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWDYOlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWDYOlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWDYOlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:41:07 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:52828 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932236AbWDYOlG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:41:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=P+PyVNEKxkhKX/WzVoOUNYmwt8m1r+z/XoP/g6wQFd824qBdnWmC2X++T8FtSjtGCdNGyBR/q/BIQkZrMg828zzM4OCnDQN7O2tt7DHzkr3HA3KuFKqjC6iilQh7x3bw/nhHbT3WvFMpyfwsoh7p7zymvoXf2g27Rbz9SGhY/1Y=
Message-ID: <8bf247760604250741l5ee1267cg7745ef5934f48497@mail.gmail.com>
Date: Tue, 25 Apr 2006 07:41:04 -0700
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sd cards : OCR busy?
Cc: "Pierre Ossman" <drzeus-list@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I am using Linux 2.6.15.

   I am getting OCR busy Error. The driver works on some sd cards and
does not work
   on some other cards. i really cant figure out what the problem is.

   I have a 4/5 cards with me and i find it that it works with 2 sd cards and
   the following is my boot messages.

   i have included a few prints just to see what's going on.

   My recent error is - the error OCR busy Error. i have appened the
boot messages for your reference.

   Some some cards i get the errors:
   mount: Mounting /dev/mmcblk0 on /mnt/mmc failed: No such device or address

   Please Advice.


Regards,
sriram


Memory policy: ECC disabled, Data cache writeback
OMAP162123 revision 2 handled as 16xx id: c6059089bfd31504
SRAM: Mapped pa 0x20000000 to va 0xd0000000 size: 0x4000
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Built 1 zonelists
Kernel command line: console=ttyS0,115200n8 rw ip=dhcp
Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x3000
Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
Total of 128 interrupts in 4 interrupt banks
OMAP GPIO hardware version 1.0
MUX: initialized M7_1610_GPIO62
PID hash table entries: 256 (order: 8, 4096 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 32MB = 32MB total
Memory: 29728KB available (2092K code, 433K data, 116K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
MUX: initialized MMC_DAT3
OMAP DMA hardware version 1
DMA capabilities: 000c0000:00000000:01ff:003f:007f
Initializing OMAP McBSP system
USB: hmc 16, usb0 2 wires
i2c_omap i2c_omap.1: bus 0 rev2.2 at 100 kHz
tps65010: version 2 May 2005
i2c_omap i2c_omap.1: timeout waiting for bus ready
i2c_omap i2c_omap.1: timeout waiting for bus ready
i2c_omap i2c_omap.1: timeout waiting for bus ready
tps65010: no chip?
MUX: initialized N14_1610_UWIRE_CS0
MUX: initialized P15_1610_UWIRE_CS3
Power Management for TI OMAP.
MUX: initialized T20_1610_LOW_PWR
NetWinder Floating Point Emulator V0.97 (double precision)
OMAP OCPI interconnect driver loaded
NTFS driver 2.1.25 [Flags: R/O].
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel osk
omapfb-lcdc: init
omapfb-lcdc: Pixel clock divider value is obsolete.
omapfb-lcdc: Try to set pixel_clock to 8000 and pcd to 0 in
drivers/video/omap/lcd_osk.c and submit a patch.
MUX: initialized PWL
Console: switching to colour frame buffer device 30x40
omapfb: initialized vram=153600 pixclock 8000 kHz hfreq 20.1 kHz vfreq 63.3
Hz
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c2852300 IRQ 160 [nowait]
eth0: Ethernet addr: 00:0e:99:02:0b:56
i2c /dev entries driver
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x1000000 in 16-bit bank
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00020000 : "bootloader"
0x00020000-0x00040000 : "params"
0x00040000-0x00240000 : "kernel"
0x00240000-0x02000000 : "filesystem"
mice: PS/2 mouse device common for all mice
OMAP Keypad Driver
input: omap-keypad as /class/input/input0
drivers/mmc/mmc_block.c:mmc_blk_init: major - 254
mmc_register_driver: driver_register = 0
mmc_omap_probe:
mmc_alloc_host:
mmc_add_host:
mmc_add_host_sysfs:
mmc_power_off:
MMC1: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0.00
mmc_detect_change:
NET: Registered protocol family 2
mmc_rescan:
__mmc_claim_host:
mmc_setup:
mmc_power_up:
MMC1: set_ios: clock 400000Hz busmode 1 powermode 1 Vdd 0.21
mmc_delay:
MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21
mmc_delay:
mmc_idle_cards:
MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21
mmc_delay:
mmc_wait_for_cmd:
mmc_wait_for_req:
mmc_omap_start_command:MMC1: CMD0, argument 0x00000000
mmc_omap_irq:MMC IRQ 0001 (CMD 0): EOC
MMC1: End request, err 0
mmc_delay:
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Disabling unused clock "usb_dc_ck"... done
FIXME: Clock "tc2_ck" seems unused
Disabling unused clock "tc1_ck"... done
Skipping reset check for DSP domain clock "dsptim_ck"
Skipping reset check for DSP domain clock "dspxor_ck"
Skipping reset check for DSP domain clock "dspper_ck"
MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21
mmc_delay:
mmc_send_app_op_cond:
mmc_wait_for_app_cmd:
mmc_wait_for_req:
mmc_omap_start_command:MMC1: CMD55, argument 0x00000000, 32-bit response,
CRC
mmc_omap_irq:MMC IRQ 1001 (CMD 55): EOC OCRB
MMC1: OCR busy error, CMD55
MMC1: Response 00000000
MMC1: End request, err 0
mmc_setup:No MMC cards found
mmc_send_op_cond:
mmc_wait_for_cmd:
mmc_wait_for_req:
mmc_omap_start_command:MMC1: CMD1, argument 0x00000000, 32-bit response
mmc_omap_irq:MMC IRQ 1001 (CMD 1): EOC OCRB
MMC1: Response 00000000
MMC1: End request, err 0
mmc_select_voltage: ocr - 0
mmc_release_host:
mmc_power_off:
MMC1: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0.00
eth0: link up
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.4.1, my address is 10.0.4.5
IP-Config: Complete:
device=eth0, addr=10.0.4.5, mask=255.255.255.0, gw=10.0.4.1,
host=10.0.4.12, domain=ph.cox.net, nis-domain=(none),
bootserver=10.0.4.1, rootserver=10.0.10.92, rootpath=
VFS: Mounted root (nfs filesystem).
Freeing init memory: 116K
Initializing random number generator... done.
Starting network...
