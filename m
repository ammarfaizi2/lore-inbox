Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132928AbRDRARL>; Tue, 17 Apr 2001 20:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132932AbRDRARB>; Tue, 17 Apr 2001 20:17:01 -0400
Received: from eschelon.gamesquad.net ([216.115.239.45]:34323 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S132928AbRDRAQs>; Tue, 17 Apr 2001 20:16:48 -0400
From: "Vibol Hou" <vhou@khmer.cc>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Date: Tue, 17 Apr 2001 17:15:34 -0700
Message-ID: <NDBBKKONDOBLNCIOPCGHIEHBGDAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using 2.4.4-pre3 and get this message occasionally when the system is
loaded:

Apr 17 16:10:12 omega kernel: eth0: Too much work in interrupt, status e401.
Apr 17 16:10:12 omega kernel: eth0: Too much work in interrupt, status e401.

The nic is a 3Com 3c905B. Is this a bad thing?

/proc/interrupts:
           CPU0       CPU1
  0:   13167527   12036422    IO-APIC-edge  timer
  1:          0          2    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      22773      19820    IO-APIC-edge
  8:          1          0    IO-APIC-edge  rtc
 15:          1          4    IO-APIC-edge  ide1
 17:   50001929   49606064   IO-APIC-level  eth0
 18:    2459038    2364252   IO-APIC-level  aic7xxx
NMI:          0          0
LOC:   25202946   25202942
ERR:          0

--
Vibol Hou
KhmerConnection
http://khmer.cc

