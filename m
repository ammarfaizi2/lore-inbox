Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVBBDzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVBBDzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 22:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVBBDw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:52:28 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:61394 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262255AbVBBDvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:51:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SKJks5BRN3g487SVyPc+SGZbekPosJpkWnN2QouBOc9c5OQICTBK3bC4T/Et1aa3IdB77THT3/VX5w5dChEN9x6KW1E+3VPcf+bFJUr3ZS6ny59BA1kNXQgc2wZN4iOvOYB5pIri+srIN4qquZtv30YuDiHEV4IY+WV96X4m18s=
Message-ID: <9871ee5f0502011950757d6803@mail.gmail.com>
Date: Tue, 1 Feb 2005 22:50:55 -0500
From: Timothy Miller <theosib@gmail.com>
Reply-To: Timothy Miller <theosib@gmail.com>
To: Lincoln Dale <ltd@cisco.com>
Subject: Re: ALSA HELP: Crackling and popping noises with via82xx
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20050202134106.041be8f8@171.71.163.14>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9871ee5f05020118343effed7@mail.gmail.com>
	 <5.1.0.14.2.20050202134106.041be8f8@171.71.163.14>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2005 13:55:23 +1100, Lincoln Dale <ltd@cisco.com> wrote:
> At 01:34 PM 2/02/2005, Timothy Miller wrote:
> >I've mentioned this problem before.  It seemed to go away around the
> >2.6.8 timeframe, but when I started using 2.6.9, it came back.   I'm
> >using 2.6.10, and it's still happening.
> 
> almost identical system here, other than i'm using an ASUS A7V600
> motherboard but otherwise have identical chipset, graphics card.
> (although the ASUS board has a rev60 version of the sound driver).

Thanks for responding.  I may have neglected to mention that I'm not
subscribed, in case anyone else wants to respond.

> 
> no problems with audio crackling at all, using 2.6.10 and 2.6.1-rc2-mm2
> with audio compiled into the kernel (not using modules for OSS/ALSA).
> 
> perhaps the interrupt is shared with some other device?
> perhaps your speakers are dying?

Definitely not.  I can use this same box for days on end in Windows,
and everything works great (well, sound anyway).  I boot Linux and it
makes noises.

> 
> this is my mythtv box so i'd certainly notice if the audio was bung.
> 
> [root@spam root]# uname -a
> Linux spam 2.6.10ltd1 #1 Sun Jan 30 21:06:01 EST 2005 i686 athlon i386
> GNU/Linux
> 
> [root@spam root]# lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host 
> Bridge (rev 80)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
> 00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video
> Capture (rev 11)
> 00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
> (rev 11)
> 00:0e.0 Multimedia video controller: Conexant Winfast TV2000 XP (rev 05)
> 00:0e.2 Multimedia controller: Conexant: Unknown device 8802 (rev 05)
> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
> Controller (rev 80)
> 00:0f.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (rev 81)
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (rev 81)
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
> Controller (rev 81)
> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81)
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
> VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
> 00:13.0 Multimedia video controller: Brooktree Corporation Bt848 Video
> Capture (rev 12)
> 01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200
> SE] (rev 01)
> 01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE]
> (Secondary) (rev 01)
> 
> [root@spam root]# cat /proc/interrupts
>             CPU0
>    0:  160440190    IO-APIC-edge  timer
>    1:       6157    IO-APIC-edge  i8042
>    7:     118047    IO-APIC-edge  parport0
>    9:          0   IO-APIC-level  acpi
>   12:     165567    IO-APIC-edge  i8042
>   14:     403308    IO-APIC-edge  ide0
>   15:    1685009    IO-APIC-edge  ide1
>   16:   59442009   IO-APIC-level  bttv0, bt878
>   17:          0   IO-APIC-level  cx88[0], cx88[0]
>   18:          3   IO-APIC-level  bttv1
>   21:         37   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd,
> uhci_hcd
>   22:      48672   IO-APIC-level  VIA8237
>   23:     139365   IO-APIC-level  eth0
> 
> cheers,
> 
> lincoln.
> 

Here's my /proc/interrupts:

           CPU0
  0:    9862457    IO-APIC-edge  timer
  1:      17739    IO-APIC-edge  i8042
  7:          0    IO-APIC-edge  parport0
  9:          0   IO-APIC-level  acpi
 12:     259939    IO-APIC-edge  i8042
 14:          7    IO-APIC-edge  ide0
 15:         22    IO-APIC-edge  ide1
169:     369851   IO-APIC-level  radeon@pci:0000:01:00.0
177:      51422   IO-APIC-level  3w-xxxx, eth0
193:       3165   IO-APIC-level  VIA8233
NMI:          0
LOC:    9862333
ERR:          0
MIS:          0
