Return-Path: <linux-kernel-owner+w=401wt.eu-S932614AbXARUeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbXARUeV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 15:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbXARUeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 15:34:20 -0500
Received: from shell.pcisys.net ([216.229.32.243]:47197 "EHLO shell.pcisys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932600AbXARUeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 15:34:11 -0500
X-Greylist: delayed 1792 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 15:34:11 EST
Date: Thu, 18 Jan 2007 13:04:17 -0700
From: Brian Hall <brihall@pcisys.net>
To: linux-kernel@vger.kernel.org
Subject: REQ: advice on tuning via-velocity parameters
Message-ID: <20070118200416.GC22051@pcisys.net>
Reply-To: brihall@pcisys.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a GBe Via Velocity NIC on an Abit AV8 motherboard, with
1GB DDR and a 3700+ CPU, running kernel 2.6.19. When I push a
lot of data via TCP-mounted NFS, I get a lot of these messages
in the system log and the machine is briefly slow to respond:

eth0: excessive work at interrupt.

I am guessing the system becomes slow when it is 'catching up'
with all the interrupts.

There are a lot of parameters associated with the via-velocity
driver. Is there a reference online detailing how to adjust
them, or a more general network-card kernel parameter tuning
FAQ?

I have txcsum_offload enabled.

           rx_copybreak
Copy breakpoint for copy-only-tiny-frames (int)

           int_works
Number of packets per interrupt services (array of int)

           txcsum_offload
Enable transmit packet checksum offload (array of int)

           IP_byte_align
Enable IP header dword aligned (array of int)

           DMA_length
DMA length (array of int)

           rx_thresh
Receive fifo threshold (array of int)

           TxDescriptors
Number of transmit descriptors (array of int)
parm
           RxDescriptors
Number of receive descriptors (array of int)


--
Brian Hall
http://pcisys.net/~brihall

