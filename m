Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277738AbRKNVTM>; Wed, 14 Nov 2001 16:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277918AbRKNVTC>; Wed, 14 Nov 2001 16:19:02 -0500
Received: from [216.80.8.1] ([216.80.8.1]:47120 "HELO mercury.prairiegroup.com")
	by vger.kernel.org with SMTP id <S277738AbRKNVSp>;
	Wed, 14 Nov 2001 16:18:45 -0500
Message-ID: <3BF2DFBF.6090502@prairiegroup.com>
Date: Wed, 14 Nov 2001 15:18:55 -0600
From: Martin McWhorter <m_mcwhorter@prairiegroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible Bug: 2.4.14 USB Keyboard
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wanted to try the new preemptive kernel patch so I downloaded the 
2.4.14 sources from kernel.org and the preemptive patch for 2.4.14, 
configured the kernel, built it, mkinitrded and liloed.

Everything came up fine, though my usb keyboard does not respond. The 
currios thing is that when the kernel is boooting and sysinit starts the 
USB devices they all report that they start ok:

Nov 14 09:42:01 m_mcwhorter rc.sysinit: Mounting USB filesystem:  succeeded
Nov 14 09:42:01 m_mcwhorter rc.sysinit: Initializing USB controller 
(usb-uhci):  succeeded
Nov 14 09:42:01 m_mcwhorter rc.sysinit: Initializing USB HID interface: 
  succeeded
Nov 14 09:42:01 m_mcwhorter rc.sysinit: Initializing USB keyboard: 
succeeded
Nov 14 09:42:01 m_mcwhorter rc.sysinit: Initializing USB mouse:  succeeded

But the USB keyboard does not repond, though the mouse connected through 
the keyboard hub works.

Is this a possible bug?

Linux 2.4.14 with preemptive patch
Redhat 7.1
HP Pavillion 9690C with supplied USB keyboard USB mouse
Intel Pentium III 800

Thanks,
Martin

