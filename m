Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292902AbSBVSb7>; Fri, 22 Feb 2002 13:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292904AbSBVSbu>; Fri, 22 Feb 2002 13:31:50 -0500
Received: from ns.guardiandigital.com ([209.11.107.5]:36626 "HELO
	juggernaut.guardiandigital.com") by vger.kernel.org with SMTP
	id <S292902AbSBVSbl>; Fri, 22 Feb 2002 13:31:41 -0500
Message-ID: <3C768E10.B05DDA53@guardiandigital.com>
Date: Fri, 22 Feb 2002 13:29:36 -0500
From: Nick DeClario <nick@guardiandigital.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AMD 760 Dual MP support in 2.2.20
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working with a client trying to get a 2.2.20 kernel to work on a
Asus A7M266-D Revision 1.04 motherboard (Award Bios v6.0, Revision 1004)
with a single Athlon MP 1500.  

The system boots buts recognizes none of the hardware except for a
Promise Fastrack 100 controller and an Intel eepro100.  /proc/pci
displays everything as an Unknown device.

Here is a list of what is unknown and beneath it what it actually is.  I
looked up each unknown device in a newer PCI table:

Host bridge: AMD Unknown device (rev 17). 
Vendor id=1022. Device id=700c.
  AMD-762 CPU to PCI Bridge (SMP chipset)

PCI bridge: AMD Unknown device (rev 0).
Vendor id=1022. Device id=700d
  AMD-762 CPU to PCI Bridge (AGP 4x)

ISA bridge: AMD Unknown device (rev 4). 
Vendor id=1022. Device id=7440.
  AMD-768 LPC Bridge

IDE interface: AMD Unknown device (rev 4). 
Vendor id=1022. Device id=7441
  AMD-768 EIDE Controller

Bridge: AMD Unknown device (rev 3). 
Vendor id=1022. Device id=7443.
  AMD-768 System Management

PCI bridge: AMD Unknown device (rev 4).
Vendor id=1022. Device id=7448
  AMD-768 PCI Bridge

Multimedia audio controller: Unknown vendor Unknown device (rev 16).
Vendor id=1002. Device id=5046
  CMI8738/PCI C3DX PCI Audio Chip

Even though the system recognizes the Promise controller I can't seem to
get it working at all.  Support for this controller was compiled into
the 2.2.20 kernel that is being used.  This hardware setup was tested
under SuSE 7.3 and it worked fine.  

I checked the recent change logs for the 2.2.21 pre 1 and pre 2 kernel
patches and didn't see anything regarding the AMD 760.  Is this a known
problem or am I doing something wrong?  Upgrading to a 2.4.x kernel is
not an option in this situation.  Thanks

Regards,
	Nicholas DeClario
