Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTJ0VdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTJ0VdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:33:08 -0500
Received: from bay7-f23.bay7.hotmail.com ([64.4.11.23]:30225 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S263579AbTJ0VdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:33:00 -0500
X-Originating-IP: [192.189.172.32]
X-Originating-Email: [ear22@hotmail.com]
From: "Hakona Spect" <ear22@hotmail.com>
To: zwane@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4Gb memory?
Date: Mon, 27 Oct 2003 16:32:59 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F23ko57PJ66ZMA0000af93@hotmail.com>
X-OriginalArrivalTime: 27 Oct 2003 21:33:00.0133 (UTC) FILETIME=[E50B5950:01C39CD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


$/sbin/lspci
00:00.0 Host bridge: Intel Corp. 82860 860 (Wombat) Chipset Host Bridge 
(MCH) (rev 04)
00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev 
04)
00:02.0 PCI bridge: Intel Corp. 82860 860 (Wombat) Chipset AGP Bridge (rev 
04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 04)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio 
(rev 04)
01:00.0 VGA compatible controller: nVidia Corporation NV25GL [Quadro4 700 
XGL] (rev a3)
02:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge (rev 03)
03:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable Interrupt 
Controller (rev 01)
04:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
78)
04:0c.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 
Controller (Link)


>From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
>To: Hakona Spect <ear22@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: 4Gb memory?
>Date: Mon, 27 Oct 2003 16:10:18 -0500 (EST)
>
>On Mon, 27 Oct 2003, Hakona Spect wrote:
>
> > Hi, I just installed 4GB memory to my system. In BIOS it shows up all 
>8x512M
> > chips. But after boot it shows:
> >
> > $ free
> >              total       used       free     shared    buffers     
>cached
> > Mem:       3753328     566800    3186528          0      96040     
>189960
> > -/+ buffers/cache:     280800    3472528
> > Swap:      2096440          0    2096440
> >
> > $dmesg
> > Linux version 2.4.22 (root) (gcc version 3.2.2 20030222 (Red Hat Linux
> > 3.2.2-5)) #1 SMP Mon Oct 27 12:44:16 EST 2003
> > BIOS-provided physical RAM map:
> > BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> > BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> > BIOS-e820: 0000000000100000 - 000000007ff77000 (usable)
> > BIOS-e820: 000000007ff77000 - 000000007ff79000 (ACPI NVS)
> > BIOS-e820: 000000007ff79000 - 00000000e7f77000 (usable)
> > BIOS-e820: 00000000e7f79000 - 00000000e8000000 (reserved)
> > BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> > BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
> > BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> > user-defined physical RAM map:
> > user: 0000000000000000 - 00000000000a0000 (usable)
> > user: 00000000000f0000 - 0000000000100000 (reserved)
> > user: 0000000000100000 - 000000007ff77000 (usable)
> > user: 000000007ff77000 - 000000007ff79000 (ACPI NVS)
> > user: 000000007ff79000 - 00000000e7f77000 (usable)
> > user: 00000000e7f79000 - 00000000e8000000 (reserved)
> > user: 00000000fec00000 - 00000000fec10000 (reserved)
> > user: 00000000fee00000 - 00000000fee10000 (reserved)
> > user: 00000000ffb00000 - 0000000100000000 (reserved)
> > 2815MB HIGHMEM available.
> > 896MB LOWMEM available.
>
>Which motherboard? Some boards will reserve some of the area between ~3.7
>and 4G for various option roms and other devices present in the system.
>Resulting in "lost" physical RAM.
>

_________________________________________________________________
Surf and talk on the phone at the same time with broadband Internet access. 
Get high-speed for as low as $29.95/month (depending on the local service 
providers in your area).  https://broadband.msn.com

