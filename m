Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbTAUHEW>; Tue, 21 Jan 2003 02:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbTAUHEV>; Tue, 21 Jan 2003 02:04:21 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:62607
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266041AbTAUHES>; Tue, 21 Jan 2003 02:04:18 -0500
Date: Tue, 21 Jan 2003 02:12:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andy Grover <andrew.grover@intel.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, <acpi-devel@sourceforge.net>,
       Martin Bligh <mbligh@us.ibm.com>, <mingo@redhat.com>
Subject: Re: [PATCH] SMP parsing rewrite, phase 1
In-Reply-To: <Pine.LNX.4.44.0301201834310.26042-100000@dexter.groveronline.com>
Message-ID: <Pine.LNX.4.44.0301202345130.2653-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003, Andy Grover wrote:

> Hi all,
> 
> The below patch against 2.5.59 is also available from 
> ftp://ftp.kernel.org/pub/linux/kernel/people/grover/ ,
> or bk pull http://linux-acpi.bkbits.net/linux-smp-init .
> 
> Before I spent any more time carving up mpparse.c, I just wanted to have
> the chance for feedback from others.

Booted fine on ghetto SMP, 4way i686, 1 IOAPIC, 1 ISA bus with a BSP APIC 
ID of 2;


===============================================================================

MPTable, version 2.0.15 Linux

-------------------------------------------------------------------------------

MP Floating Pointer Structure:

  location:			BIOS
  physical address:		0x000fd110
  signature:			'_MP_'
  length:			16 bytes
  version:			1.4
  checksum:			0xc1
  mode:				Virtual Wire

-------------------------------------------------------------------------------

MP Config Table Header:

  physical address:		0x0xfd000
  signature:			'PCMP'
  base table length:		268
  version:			1.4
  checksum:			0xdd
  OEM ID:			'BOCHSCPU'
  Product ID:			'0.1         '
  OEM table pointer:		0x00000000
  OEM table size:		0
  entry count:			22
  local APIC address:		0xfee00000
  extended table length:	0
  extended table checksum:	0

-------------------------------------------------------------------------------

MP Config Base Table Entries:

--
Processors:	APIC ID	Version	State		Family	Model	Step	Flags
		 0	 0x11	 AP, usable	 6	 0	 0	 0x0201
		 1	 0x11	 AP, usable	 6	 0	 0	 0x0201
		 2	 0x11	 BSP, usable	 6	 0	 0	 0x0201
		 3	 0x11	 AP, usable	 6	 0	 0	 0x0201
--
Bus:		Bus ID	Type
		 0	 ISA   
--
I/O APICs:	APIC ID	Version	State		Address
		 4	 0x11	 usable		 0xfec00000
--
I/O Ints:	Type	Polarity    Trigger	Bus ID	 IRQ	APIC ID	PIN#
		INT	 conforms    conforms	     0	   0	      4	   0
		INT	 conforms    conforms	     0	   1	      4	   1
		INT	 conforms    conforms	     0	   2	      4	   2
		INT	 conforms    conforms	     0	   3	      4	   3
		INT	 conforms    conforms	     0	   4	      4	   4
		INT	 conforms    conforms	     0	   5	      4	   5
		INT	 conforms    conforms	     0	   6	      4	   6
		INT	 conforms    conforms	     0	   7	      4	   7
		INT	 conforms    conforms	     0	   8	      4	   8
		INT	 conforms    conforms	     0	   9	      4	   9
		INT	 conforms    conforms	     0	  10	      4	  10
		INT	 conforms    conforms	     0	  11	      4	  11
		INT	 conforms    conforms	     0	  12	      4	  12
		INT	 conforms    conforms	     0	  13	      4	  13
		INT	 conforms    conforms	     0	  14	      4	  14
		INT	 conforms    conforms	     0	  15	      4	  15

===============================================================================


-- 
function.linuxpower.ca

