Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279880AbRJ3HCT>; Tue, 30 Oct 2001 02:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279881AbRJ3HCK>; Tue, 30 Oct 2001 02:02:10 -0500
Received: from wiproecmx1.wipro.com ([164.164.31.5]:57332 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id <S279880AbRJ3HCG>; Tue, 30 Oct 2001 02:02:06 -0500
From: "Rajat Chadda" <rajat.chadda@wipro.com>
To: linux-kernel@vger.kernel.org
Message-ID: <8e0f1910ec.910ec8e0f1@wipro.com>
Date: Tue, 30 Oct 2001 12:01:21 +0500
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Scheduling Philsophy!
X-Accept-Language: en
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
If a I get an error saying
"Kernel Panic ! Problem while Syncing in Interrupt handler" 
what does it suggest.

the objective is to override eth0's hard_start_xmit()
& catch all outgoing packets. Pkts are getting queued
& a timer gets activated every 5 mins (for throwing dequeuing
a pkt & throwing it out -- by calling the original
eth0->hard_start_xmit() ).

I ain't using BHs/Spinlocks/Tasklets/SoftIRQs on Linux-2.4.2

Any guesses as to why it's happening ?

Thanks,
Rajat.


--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

-----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
------------------------------------------------------------------------------------------------------------------------

--------------InterScan_NT_MIME_Boundary--
