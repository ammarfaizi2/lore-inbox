Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbRGUPMY>; Sat, 21 Jul 2001 11:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267664AbRGUPMP>; Sat, 21 Jul 2001 11:12:15 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:27110 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267662AbRGUPMF>; Sat, 21 Jul 2001 11:12:05 -0400
Message-ID: <3B599DB7.7050602@Wipro.com>
Date: Sat, 21 Jul 2001 20:50:23 +0530
From: "Parag Warudkar" <parag.warudkar@Wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010701
X-Accept-Language: en-us
MIME-Version: 1.0
To: andrewm@uow.edu.au, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: 3c59x Problems
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
            I have a 3c905C and get following errors under medium 
network loads.
The hub, network, and all other stuff is quite good. Also on same 
machine Win2K gave
no problems. When the error occurs, I get transfer speeds of 0.43 Kbps. 
I never experienced the
same with Win2K.

DMESG OUTPUT

3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. 
http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
01:0c.0: 3Com PCI 3c905C Tornado at 0xec80,  00:b0:d0:69:77:71, IRQ 5
  product code 0000 rev 00.14 date 07-16-104
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
01:0c.0: scatter/gather disabled. h/w checksums enabled
eth0: using NWAY device table, not 8

eth0: Transmit error, Tx status register 82.
Probably a duplex mismatch.  See Documentation/networking/vortex.txt
  Flags; bus-master 1, dirty 343441(1) current 343441(1)
  Transmit list 00000000 vs. dedfe240.
  0: @dedfe200  length 800002f2 status 800102f2
  1: @dedfe240  length 80000042 status 00010042
  2: @dedfe280  length 80000042 status 00010042
  3: @dedfe2c0  length 80000042 status 00010042
  4: @dedfe300  length 80000042 status 00010042
  5: @dedfe340  length 80000042 status 00010042
  6: @dedfe380  length 80000042 status 00010042
  7: @dedfe3c0  length 8000004a status 0001004a
  8: @dedfe400  length 80000042 status 00010042
  9: @dedfe440  length 800002d0 status 000102d0
  10: @dedfe480  length 80000042 status 00010042
  11: @dedfe4c0  length 80000042 status 00010042
  12: @dedfe500  length 80000042 status 00010042
  13: @dedfe540  length 80000042 status 00010042
  14: @dedfe580  length 8000004a status 0001004a
  15: @dedfe5c0  length 80000042 status 00010042

*******************Keeps repeating..

After some time the network becomes unusable. The problem is always 
reproducible.
I run Kernel-2.4.6-2 on RH7.1 (From Rawhide). Is there any update for 
the 3c59x driver for 2.4.x kernels?

Parag


--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

The Information contained and transmitted by this E-MAIL is proprietary to 
Wipro Limited and is intended for  use only by the individual or entity to which 
it is addressed, and may contain information that is privileged, confidential or 
exempt from disclosure under applicable law. If this is a forwarded message, 
the content of this E-MAIL may not have been sent with the authority of the 
Company. If you are not the intended recipient, an agent of the intended 
recipient or a  person responsible for delivering the information to the named 
recipient,  you are notified that any use, distribution, transmission, printing, 
copying or dissemination of this information in any way or in any manner is 
strictly prohibited. If you have received this communication in error, please 
delete this mail & notify us immediately at mailadmin@wipro.com 


--------------InterScan_NT_MIME_Boundary--
