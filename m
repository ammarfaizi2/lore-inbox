Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280228AbRKEF0W>; Mon, 5 Nov 2001 00:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280229AbRKEF0M>; Mon, 5 Nov 2001 00:26:12 -0500
Received: from cogent.ecohler.net ([216.135.202.106]:43907 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S280228AbRKEF0H>; Mon, 5 Nov 2001 00:26:07 -0500
Date: Mon, 5 Nov 2001 00:26:06 -0500
From: lists@sapience.com
To: linux-kernel@vger.kernel.org
Subject: Re: P4 xeon 2.4.13-ac5: WARNING: unexpected IO-APIC and Unknown CPU
Message-ID: <20011105002606.B28408@sapience.com>
In-Reply-To: <20011104234350.A28124@sapience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011104234350.A28124@sapience.com>
User-Agent: Mutt/1.3.23-current-20011027i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, I recall some discussion a while back regrding interrupts -  
this is what I see here:

 Does this look ok?

---------------------------------------------------------
# cat /proc/interrupts 
           CPU0       CPU1       
  0:     418251          0    IO-APIC-edge  timer
  1:      12131          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:      85539          0    IO-APIC-edge  PS/2 Mouse
 15:      34755          0    IO-APIC-edge  ide1
 17:         16          0   IO-APIC-level  aic7xxx
 18:          0          0   IO-APIC-level  EMU10K1
 19:          0          0   IO-APIC-level  usb-uhci
 22:      14158          0   IO-APIC-level  aic7xxx
 23:      62950          0   IO-APIC-level  usb-uhci, eth0
NMI:          0          0 
LOC:     418171     418211 
ERR:          0
MIS:          0
---------------------------------------------------------

  regards,

  gene/
  


