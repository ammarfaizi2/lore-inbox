Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131850AbRAEPAL>; Fri, 5 Jan 2001 10:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131855AbRAEPAB>; Fri, 5 Jan 2001 10:00:01 -0500
Received: from sls.lcs.mit.edu ([18.27.0.167]:26867 "EHLO sls.lcs.mit.edu")
	by vger.kernel.org with ESMTP id <S131850AbRAEO7u>;
	Fri, 5 Jan 2001 09:59:50 -0500
Message-ID: <3A55E15B.F39D6B87@sls.lcs.mit.edu>
Date: Fri, 05 Jan 2001 09:59:39 -0500
From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
Organization: MIT Laboratory for Computer Science
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.18-pre25.1.smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Lee Hetherington <ilh@sls.lcs.mit.edu>
Subject: Re: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
In-Reply-To: <3A54E717.11A43B42@sls.lcs.mit.edu> <3A557D12.A5383794@uow.edu.au>
Content-Type: multipart/mixed;
 boundary="------------2C5992B15159738B90781940"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2C5992B15159738B90781940
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

> Please do.  The boot-time messages which come out of the driver
> would be interesting.  It would help if you add `debug=7' to
> the 3c59x modprobe command line also.

OK.  I've included dmesg output due to modprobe with debug=7 followed by ifup
(using pump -- problems persist with static IP as well), cat /proc/interrupts
showing no eth0, and ifconfig eth0.

Please let me know what else I can provide to help out.

--Lee Hetherington


--------------2C5992B15159738B90781940
Content-Type: text/plain; charset=us-ascii;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

3c59x.c 15Sep00 Donald Becker and others http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905C Tornado at 0xe880,  00:b0:d0:14:d2:b4, IRQ 11
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 1, status   24.
  MII transceiver found at address 2, status   24.
  Enabling bus-master transmits and whole-frame receives.
eth0: Initial media type Autonegotiate.
eth0: MII #1 status 0024, link partner capability 41e1, setting full-duplex.
eth0: vortex_open() InternalConfig 01800000.
eth0: vortex_open() irq 11 media status 8080.
eth0:  Filling in the Rx ring.
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: Trying to send a boomerang packet, Tx index 0.
eth0: interrupt, status f201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status f201.
eth0: exiting interrupt, status f000.
eth0: Media selection timer tick happened, Autonegotiate.
eth0: MII transceiver has status 0020.
eth0: Media selection timer finished, Autonegotiate.
eth0: Trying to send a boomerang packet, Tx index 1.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: Trying to send a boomerang packet, Tx index 2.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 3.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 4.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 5.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 6.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 7.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 8.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 9.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 10.
eth0: interrupt, status e201, latency 2, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: vortex_close() status e000, Tx status 00.
eth0: vortex close stats: rx_nocopy 0 rx_copy 0 tx_queued 11 Rx pre-checksummed 0.
eth0: Initial media type Autonegotiate.
eth0: MII #1 status 0020, link partner capability 41e1, setting full-duplex.
eth0: vortex_open() InternalConfig 01800000.
eth0: vortex_open() irq 11 media status 8080.
eth0:  Filling in the Rx ring.
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: Trying to send a boomerang packet, Tx index 0.
eth0: interrupt, status f201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status f201.
eth0: exiting interrupt, status f000.
eth0: Media selection timer tick happened, Autonegotiate.
eth0: MII transceiver has status 0020.
eth0: Media selection timer finished, Autonegotiate.
eth0: Trying to send a boomerang packet, Tx index 1.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: no boomerang interrupt pending
eth0: no boomerang interrupt pending
eth0: Trying to send a boomerang packet, Tx index 2.
eth0: interrupt, status e201, latency 2, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 3.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 4.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 5.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 6.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 7.
eth0: interrupt, status e201, latency 2, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 8.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 9.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: Trying to send a boomerang packet, Tx index 10.
eth0: interrupt, status e201, latency 3, cur_rx 0, dirty_rx 0
eth0: In interrupt loop, status e201.
eth0: exiting interrupt, status e000.
eth0: vortex_close() status e000, Tx status 00.
eth0: vortex close stats: rx_nocopy 0 rx_copy 0 tx_queued 22 Rx pre-checksummed 0.

--------------2C5992B15159738B90781940
Content-Type: text/plain; charset=us-ascii;
 name="interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts"

           CPU0       
  0:      20048          XT-PIC  timer
  1:        314          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 11:       1660          XT-PIC  aic7xxx
 12:          0          XT-PIC  PS/2 Mouse
 13:          1          XT-PIC  fpu
 15:          7          XT-PIC  ide1
NMI:          0

--------------2C5992B15159738B90781940
Content-Type: text/plain; charset=us-ascii;
 name="ifconfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ifconfig"

eth0      Link encap:Ethernet  HWaddr 00:B0:D0:14:D2:B4  
          BROADCAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:1 frame:0
          TX packets:23 errors:0 dropped:0 overruns:0 carrier:1
          collisions:0 txqueuelen:100 
          Interrupt:11 Base address:0xe880 


--------------2C5992B15159738B90781940--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
