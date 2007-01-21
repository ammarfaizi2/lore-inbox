Return-Path: <linux-kernel-owner+w=401wt.eu-S1751298AbXAULex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbXAULex (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 06:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbXAULex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 06:34:53 -0500
Received: from mx.mips.com ([63.167.95.198]:62028 "EHLO dns0.mips.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbXAULew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 06:34:52 -0500
X-Greylist: delayed 1218 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 06:34:52 EST
Message-ID: <005101c73d4e$6bbf96d0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Sunil Naidu" <akula2.shark@gmail.com>,
       "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-kernel@vger.kernel.org>,
       "sathesh babu" <sathesh_edara2003@yahoo.co.in>,
       <linux-mips@linux-mips.org>
References: <20070120234237.49126.qmail@web7912.mail.in.yahoo.com> <20070121001457.GA9123@linux-mips.org> <8355959a0701210159k2fcb2323s2d38f91a41fcb942@mail.gmail.com>
Subject: Re: Running Linux on FPGA
Date: Sun, 21 Jan 2007 12:22:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The overhead of timer interrupts at this low clockrate is significant
> > so I recommend to minimize the timer interrupt rate as far as possible.
> > This is really a tradeoff between latency and overhead and matters
> > much less on hardcores which run at hundreds of MHz.  For power sensitive
> > applications lowering the interrupt rate can also help.  And that's alredy
> > pretty much what you need to know, that is a 10ms  timer is fine.
> >
> 
> I have worked with FPGA Linux system which is reconfigurable
> on-the-fly by the 200Mhz ARM9 CPU running Debian Linux, Altera Cyclone
> II FPGA is included on my TS-7300 board. Advantage is, Altera FPGA and
> a dedicated high-speed bus between the CPU and FPGA provides a good
> design scope to provide many solutions.

What's your point here?  A 200MHz hard ore won't see the issues 
under discussion.  We're talking about systems where the CPU itself
is "soft" and implemented in an FPGA.

            Regards,

            Kevin K.

