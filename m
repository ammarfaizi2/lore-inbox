Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287369AbSACVru>; Thu, 3 Jan 2002 16:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287366AbSACVrl>; Thu, 3 Jan 2002 16:47:41 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:60643 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S287312AbSACVr3>;
	Thu, 3 Jan 2002 16:47:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "APIC error on CPUx" - what does this mean?
Date: Thu, 3 Jan 2002 13:47:24 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020103195551.BEHH23959.femail47.sdc1.sfba.home.com@there>
In-Reply-To: <20020103195551.BEHH23959.femail47.sdc1.sfba.home.com@there>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MFhs-00046N-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 3, 2002 11:55, Steve Snyder wrote:
> I just noticed the following events in my system log:
>
>   Jan  3 14:03:39 mercury kernel: APIC error on CPU1: 00(02)
>   Jan  3 14:03:39 mercury kernel: APIC error on CPU0: 00(02)
>
> Below I've listed the CPU/APIC-related parts of my system start-up.

I occasionaly get the same errors on my UP XP1800+ on a KT133A MB, except 
they look like this:
APIC error on CPU0: 08(02)
APIC error on CPU0: 02(08)

uname -a:
Linux phalynx 2.4.17 #8 Wed Dec 26 20:41:16 PST 2001 i686 unknown

/proc/interrupts:
           CPU0
  0:   66440674    IO-APIC-edge  timer
  1:     378128    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:   13768184   IO-APIC-level  eth0
 10:        131   IO-APIC-level  usb-uhci, usb-uhci
 11:   22007511   IO-APIC-level  EMU10K1
 12:   10497666    IO-APIC-edge  PS/2 Mouse
 14:    3717339    IO-APIC-edge  ide0
 15:      18254    IO-APIC-edge  ide1
NMI:          0
LOC:   66439861
ERR:         45
MIS:          0
