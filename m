Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275175AbRJNN0Q>; Sun, 14 Oct 2001 09:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275172AbRJNN0H>; Sun, 14 Oct 2001 09:26:07 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:20491 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275156AbRJNNZt>; Sun, 14 Oct 2001 09:25:49 -0400
X-Apparently-From: <ih8sp4m@yahoo.com>
Content-Type: text/plain; charset=US-ASCII
From: I HATE SPAMMERS!!! <ih8sp4m@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with APM and ACPI in 2.4 series
Date: Sun, 14 Oct 2001 11:27:25 -0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01101411272504.02737@Voyager.myUniverse>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hasn't been able to make my Compaq Presario 12XL410 to work with either APM 
or ACPI. I have compiled 2.4.12 with APM and ACPI support.
With APM I can put it into standby (suspend hangs) and power it off but in no 
way I can monitor battery status.
[root@Voyager /root]# cat /proc/apm
1.14 1.2 0x03 0x01 0xff 0x80 -1% -1 ?

That "-1%" appears even when powered by battery.

As for ACPI, the /proc/sys/acpi doesn't show up even when I answered Y to all 
config questions regarding ACPI (I tried module with identical results).

The notebook is based upon VIA's Apollo chipset:

[root@Voyager /root]# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 05)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 20)
00:09.0 Communication controller: CONEXANT HSP MicroModem 56K (rev 01)
00:0b.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade i1 (rev 6a)


I am running RedHat 7.1. I checked the utilities and compiler versions and 
all ofthem are OK according to Changes.

--

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

