Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbTLaE7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 23:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266119AbTLaE7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 23:59:24 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:50097 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266116AbTLaE7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 23:59:21 -0500
Message-ID: <3FF257A0.8070906@blue-labs.org>
Date: Tue, 30 Dec 2003 23:59:12 -0500
From: David Ford <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: APCUPSD and HID spam
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after starting apcupsd, my system is deluged with over three thousand of 
these messages per second; the control queue full messages.  doesn't 
stop until apcupsd is stopped.  i can't say if this is new or longtime, 
i just hooked it up after several months.

# uname -a
Linux Huntington-Beach.Blue-Labs.org 2.6.0 #1 Fri Dec 26 20:07:52 EST 
2003 i686 Unknown CPU Type AuthenticAMD GNU/Linux

# lsusb
Bus 003 Device 004: ID 051d:0002 American Power Conversion Back-UPS Pro 500
Bus 003 Device 003: ID 046d:0870 Logitech, Inc. QuickCam Express
Bus 003 Device 002: ID 05a9:0511 OmniVision Technologies, Inc. OV511 WebCam
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 004: ID 0451:1446 Texas Instruments, Inc. TUSB2040/2070 Hub
Bus 002 Device 003: ID 046d:c001 Logitech, Inc. N48/M-BB48 [FirstMouse Plus]
Bus 002 Device 002: ID 046d:c50d Logitech, Inc.
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

# lspci
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) 
(rev a2)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev a2)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev a2)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev a2)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev a2)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev a2)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
00:05.0 Multimedia audio controller: nVidia Corporation nForce 
MultiMedia audio [Via VT82C686B] (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 
1394) Controller (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2)
01:08.0 Ethernet controller: Unknown device 168c:0013 (rev 01)
01:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
01:09.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
01:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 
[FasterNet] (rev 22)
03:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 
5200] (rev a1)


Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: NIS server startup 
succeeded
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: apcupsd 3.10.5 (04 
February 2003) gentoo startup succeeded
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: APC      : 001,033,0852
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: DATE     : Tue Dec 30 
23:42:09 EST 2003
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: HOSTNAME : 
Huntington-Beach.Blue-Labs.org
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: RELEASE  : 3.10.5
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: VERSION  : 3.10.5 (04 
February 2003) gentoo
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: UPSNAME  : HB-powerpack
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: CABLE    : USB Cable
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: MODEL    : Back-UPS ES 350
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: UPSMODE  : Stand Alone
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: STARTTIME: Tue Dec 30 
23:42:09 EST 2003
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: STATUS   : ONLINE LOWBATT
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: LINEV    : 119.0 Volts
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: LOADPCT  :  80.0 
Percent Load Capacity
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: BCHARGE  : 100.0 Percent
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: TIMELEFT :   1.0 Minutes
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: MBATTCHG : 5 Percent
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: MINTIMEL : 3 Minutes
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: MAXTIME  : 0 Seconds
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: LOTRANS  : 088.0 Volts
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: HITRANS  : 138.0 Volts
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: ALARMDEL : Always
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: BATTV    : 13.6 Volts
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: NUMXFERS : 0
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: TONBATT  : 0 seconds
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: CUMONBATT: 0 seconds
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: XOFFBATT : N/A
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: STATFLAG : 0x02010048 
Status Flag
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: MANDATE  : 2003-01-18
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: SERIALNO : AB0303246275
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: BATTDATE : 2000-00-00
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: NOMBATTV :  12.0
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: FIRMWARE : .e2.D USB FW:e2
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: APCMODEL : Back-UPS ES 350
Dec 30 23:42:09 Huntington-Beach apcupsd[31071]: END APC  : Tue Dec 30 
23:42:09 EST 2003
Dec 30 23:42:09 Huntington-Beach drivers/usb/input/hid-core.c: control 
queue full
Dec 30 23:42:09 Huntington-Beach drivers/usb/input/hid-core.c: control 
queue full
Dec 30 23:42:09 Huntington-Beach drivers/usb/input/hid-core.c: control 
queue full
Dec 30 23:42:09 Huntington-Beach drivers/usb/input/hid-core.c: control 
queue full


