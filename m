Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279408AbRJ2TvT>; Mon, 29 Oct 2001 14:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279414AbRJ2TvK>; Mon, 29 Oct 2001 14:51:10 -0500
Received: from hamachi.synopsys.com ([204.176.20.26]:20722 "EHLO
	hamachi.synopsys.com") by vger.kernel.org with ESMTP
	id <S279408AbRJ2Tuw>; Mon, 29 Oct 2001 14:50:52 -0500
Message-ID: <3BDDB312.589D2E04@Synopsys.COM>
Date: Mon, 29 Oct 2001 20:50:43 +0100
From: Harald Dunkel <harri@synopsys.COM>
Reply-To: harri@synopsys.COM
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x:command 0x3002 did not complete! Status=0xffff
In-Reply-To: <3BDD9FF4.D54DC0C9@Synopsys.COM> <3BDDA4C0.F4391EC@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PS: The message about '0x3002 did not complete' is gone. I haven't seen
it anymore since I added the 'options 3c59x enable_wol=1'. 

But now I get this in my syslog:

Oct 29 20:41:19 bilbo pppd[522]: pppd 2.4.1 started by root, uid 0
Oct 29 20:41:20 bilbo pppd[522]: Sending PADI
Oct 29 20:41:20 bilbo kernel: eth0: Transmit error, Tx status register 90.
Oct 29 20:41:20 bilbo kernel:   Flags; bus-master 1, dirty 0(0) current 1(1)
Oct 29 20:41:20 bilbo kernel:   Transmit list 00000000 vs. df230200.
Oct 29 20:41:20 bilbo kernel:   0: @df230200  length 80000020 status 80000020
Oct 29 20:41:20 bilbo kernel:   1: @df230240  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   2: @df230280  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   3: @df2302c0  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   4: @df230300  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   5: @df230340  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   6: @df230380  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   7: @df2303c0  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   8: @df230400  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   9: @df230440  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   10: @df230480  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   11: @df2304c0  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   12: @df230500  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   13: @df230540  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   14: @df230580  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel:   15: @df2305c0  length 00000000 status 00000000
Oct 29 20:41:20 bilbo kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Oct 29 20:41:20 bilbo kernel: scsi0: Data Parity Error Detected during address or write data phase
Oct 29 20:41:20 bilbo kernel: scsi1: PCI error Interrupt at seqaddr = 0x9
Oct 29 20:41:20 bilbo kernel: scsi1: Data Parity Error Detected during address or write data phase


Especially interesting is the message about the SCSI. How is this
related to the 3c59x?


Regards

Harri
