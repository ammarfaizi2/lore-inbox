Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145307AbRA2GDt>; Mon, 29 Jan 2001 01:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145292AbRA2GD3>; Mon, 29 Jan 2001 01:03:29 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:42726 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S145307AbRA2GDV>; Mon, 29 Jan 2001 01:03:21 -0500
Message-ID: <3A750792.2698D108@Home.net>
Date: Mon, 29 Jan 2001 01:02:58 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: [PROBLEM?] PCI Probe failing? 2.4.x kernels
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

snip from dmesg:

PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 00:09.0
  got res[10000000:10ffffff] for resource 0 of ATI Technologies Inc 3D
Rage I/II 215GT [Mach64 GT]
Limiting direct PCI/PCI transfers.

What does this mean?

The video card should be using irq 10 according to the BIOS on bootup.
The video card shares int 10 with other devices as well.

           CPU0
  0:    1614217          XT-PIC  timer
  1:      20928          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:     143613          XT-PIC  serial
  5:     384574          XT-PIC  soundblaster
  8:          1          XT-PIC  rtc
  9:      78029          XT-PIC  eth0
 14:      17015          XT-PIC  ide0
 15:         47          XT-PIC  ide1


Why is it limiting PCI/PCI transfers?

Shawn.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
