Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEP0o>; Fri, 5 Jan 2001 10:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAEP0e>; Fri, 5 Jan 2001 10:26:34 -0500
Received: from columba.EUR.3Com.COM ([161.71.169.13]:59542 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id <S129183AbRAEP0Y>; Fri, 5 Jan 2001 10:26:24 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: I Lee Hetherington <ilh@sls.lcs.mit.edu>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Lee Hetherington <ilh@sls.lcs.mit.edu>
Message-ID: <802569CB.005567CF.00@notesmta.eur.3com.com>
Date: Fri, 5 Jan 2001 15:26:00 +0000
Subject: Re: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



What is the output of 'lspci -v'? If it says that the chip revision is '78' then
this is one of the new 3C905CX (note the CX) NIC's or ASIC on the motherboard.
I've seen a problem with the 3c59x.c driver and this chip, it can send packets
but not receive any. The 3Com 3c90x-1.0.0i.tgz driver at
http://support.3com.com/infodeli/tools/nic/linux.htm should work with this chip.

There has been some discussion of this NIC on the vortex mailing list at
http://www.scyld.com/network/vortex.html , with a patched driver to make for
this chip available for testing at Andrew's web site
http://www.uow.edu.au/~andrewm/linux/#3c59x-bc (see the '2.2.19pre2 driver for
testing').

     Jon


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
