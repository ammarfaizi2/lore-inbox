Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313993AbSDQA53>; Tue, 16 Apr 2002 20:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313992AbSDQA4C>; Tue, 16 Apr 2002 20:56:02 -0400
Received: from mail.mesatop.com ([208.164.122.9]:2053 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S313991AbSDQAzv>;
	Tue, 16 Apr 2002 20:55:51 -0400
Subject: [PATCH] 2.5.8-dj1, add 22 help texts to arch/arm/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: rmk@arm.linux.org.uk
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1019004148.16110.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0.2-5mdk 
Date: 16 Apr 2002 18:54:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 22 help texts to arch/arm/Config.help.
The help texts were obtained from ESR's v2.97 Configure.help.

Steven

--- linux-2.5.8-dj1/arch/arm/Config.help.orig   Tue Apr 16 12:01:20 2002
+++ linux-2.5.8-dj1/arch/arm/Config.help        Tue Apr 16 12:13:21 2002
@@ -836,3 +836,140 @@
   of the BUG call as well as the EIP and oops trace.  This aids
   debugging but costs about 70-100K of memory.
 
+CONFIG_CPU_FREQ
+  CPU clock scaling allows you to change the clock speed of the
+  running CPU on the fly. This is a nice method to save battery power,
+  because the lower the clock speed, the less power the CPU
+  consumes. Note that this driver doesn't automatically change the CPU
+  clock speed, you need some userland tools (which still have to be
+  written) to implement the policy. If you don't understand what this
+  is all about, it's safe to say 'N'.
+
+CONFIG_ARCH_EDB7211
+  Say Y here if you intend to run this kernel on a Cirrus Logic
EDB-7211
+  evaluation board.
+
+CONFIG_SA1100_H3100
+  Say Y here if you intend to run this kernel on the Compaq iPAQ
+  H3100 handheld computer.  Information about this machine and the
+  Linux port to this machine can be found at:
+
+  <http://www.handhelds.org/Compaq/index.html#iPAQ_H3100>
+  <http://www.compaq.com/products/handhelds/pocketpc/>
+
+CONFIG_SA1100_H3800
+  Say Y here if you intend to run this kernel on the Compaq iPAQ H3800
+  series handheld computer.  Information about this machine and the
+  Linux port to this machine can be found at:
+
+  <http://www.handhelds.org/Compaq/index.html#iPAQ_H3800>
+  <http://www.compaq.com/products/handhelds/pocketpc/>
+
+CONFIG_H3600_SLEEVE
+  Choose this option to enable support for extension packs (sleeves)
+  for the Compaq iPAQ H3XXX series of handheld computers.  This option
+  is required for the CF, PCMCIA, Bluetooth and GSM/GPRS extension
+  packs.
+
+CONFIG_SA1100_GRAPHICSMASTER
+  Say Y here if you are using an Applied Data Systems Intel(R)
+  StrongARM(R) SA-1100 based Graphics Master SBC with SA-1111
+  StrongARM companion chip.  See
+  <http://www.applieddata.net/products_masterSpec.asp> for information
+  on this system.
+
+CONFIG_SA1100_ADSBITSY
+  Say Y here if you are using Applied Data Systems Intel(R)
+  StrongARM(R) 1110 based Bitsy, 3 x 5 inches in size, Compaq - IPAQ -
+  like platform. See
+  <http://www.applieddata.net/products_bitsySpec.asp> for more
+  information.
+
+CONFIG_SA1100_ITSY
+  Say Y here if you are using the Compaq Itsy experimental pocket
+  computer. See <http://research.compaq.com/wrl/projects/itsy/> for
+  more information.
+
+CONFIG_SA1100_HUW_WEBPANEL
+  Say Y here to support the HuW Webpanel produced by Hoeft & Wessel
+  AG.  English-language website is at
+  <http://www.hoeft-wessel.de/en.htm>; credits and build instructions
+  at Documentation/arm/SA1100/HUW_WEBPANEL.
+
+CONFIG_SA1100_PLEB
+  Say Y here if you are using a Portable Linux Embedded Board
+  (also known as PLEB). See <http://www.cse.unsw.edu.au/~pleb/>
+  for more information.
+
+CONFIG_SA1100_SHERMAN
+  Say Y here to support the Blazie Engineering `Sherman' StrongARM
+  1110-based SBC, used primarily in assistance products for the
+  visually impaired.  The company is now Freedom Scientific, with
+  a website at <http://www.freedomscientific.com/index.html>. The
+  Sherman product, however, appears to have been discontinued.
+
+CONFIG_SA1100_YOPY
+  Say Y here to support the Yopy PDA.  Product information at
+  <http://www.yopy.com/>.  See Documentation/arm/SA110/Yopy
+  for more.
+
+CONFIG_SA1100_CERF_CPLD
+  Say Y here to support the Linux CerfPDA development kit from
+  Intrinsyc. This is a StrongARM-1110-based reference platform for
+  designing custom PDAs.  Product info is at
+  <http://www.intrinsyc.com/products/referencedesigns/cerfpda.asp>.
+
+CONFIG_SA1100_FREEBIRD
+  Support the FreeBird board used in Coventive embedded products.  See
+  Documentation/arm/SA1100/Freebird for more.
+
+CONFIG_SA1100_PT_SYSTEM3
+   Say Y here if you intend to build a kernel suitable to run on
+   a Pruftechnik Digital Board. For more information see
+   <http://www.pruftechnik.com>
+
+CONFIG_CPU_ARM926T
+  This is a variant of the ARM920.  It has slightly different
+  instruction sequences for cache and TLB operations.  Curiously,
+  there is no documentation on it at the ARM corporate website.
+
+  Say Y if you want support for the ARM926T processor.
+  Otherwise, say N.
+
+CONFIG_SA1100_JORNADA720
+  Say Y here if you want to build a kernel for the HP Jornada 720
+  handheld computer.  See <http://www.hp.com/jornada/products/720>
+  for details.
+
+CONFIG_SA1100_OMNIMETER
+  Say Y here if you are using the inhand electronics OmniMeter.  See
+  <http://www.inhandelectronics.com/html/omni1.html> for details.
+
+CONFIG_SA1100_SIMPAD
+  The SIEMENS webpad SIMpad is based on the StrongARM 1110. There
+  are two different versions CL4 and SL4. CL4 has 32MB RAM and 16MB
+  FLASH. The SL4 version got 64 MB RAM and 32 MB FLASH and a
+  PCMCIA-Slot. The version for the Germany Telecom (DTAG) is the same
+  like CL4 in additional it has a PCMCIA-Slot. For more information
+  visit <http://www.my-siemens.com or www.siemens.ch>.
+
+CONFIG_ARCH_CDB89712
+  This is an evaluation board from Cirrus for the CS89712 processor.
+  The board includes 2 serial ports, Ethernet, IRDA, and expansion
+  headers.  It comes with 16 MB SDRAM and 8 MB flash ROM.
+
+CONFIG_ARCH_AUTCPU12
+  Say Y if you intend to run the kernel on the autronix autcpu12
+  board. This board is based on a Cirrus Logic CS89712.
+
+CONFIG_EP72XX_ROM_BOOT
+  If you say Y here, your CLPS711x-based kernel will use the bootstrap
+  mode memory map instead of the normal memory map.
+
+  Processors derived from the Cirrus CLPS-711X core support two boot
+  modes.  Normal mode boots from the external memory device at CS0.
+  Bootstrap mode rearranges parts of the memory map, placing an
+  internal 128 byte bootstrap ROM at CS0.  This option performs the
+  address map changes required to support booting in this mode.
+
+  You almost surely want to say N here.





