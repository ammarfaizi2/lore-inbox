Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271949AbRIDLVX>; Tue, 4 Sep 2001 07:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271950AbRIDLVN>; Tue, 4 Sep 2001 07:21:13 -0400
Received: from alpha.netvision.net.il ([194.90.1.13]:56585 "EHLO
	alpha.netvision.net.il") by vger.kernel.org with ESMTP
	id <S271949AbRIDLVE>; Tue, 4 Sep 2001 07:21:04 -0400
Message-ID: <3B94B93B.2B907DCF@netvision.net.il>
Date: Tue, 04 Sep 2001 14:21:31 +0300
From: Michael Ben-Gershon <mybg@netvision.net.il>
Organization: My Office
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: lpr to HP laserjet stalls
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <20010903221142.J20060@redhat.com> <3B94B4E7.701C76FA@netvision.net.il> <20010904121523.Q20060@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Tue, Sep 04, 2001 at 02:03:03PM +0300, Michael Ben-Gershon wrote:
> 
> > Sep  3 00:33:29 linux kernel: parport0: PC-style at 0x378 (0x778)
> > [PCSPP,TRISTATE,COMPAT,EPP,ECP]
> 
> This is 'polling' mode.  So, three code paths left to try. :-)
> 
> > As far as I can see, although IRQ 7 is detected, it is not used, so
> > I don't see how starting parport with irq=none would help. Could
> > CONFIG_PARPORT_PC_FIFO actually improve matters in such a situation?
> 
> It could, yes.
> 
> I certainly wouldn't have expected stalls in polling mode though.  I
> wonder what's up with that.
> 
> It would be very useful to see if there's any change with (a)
> interrupt-driven, (b) PIO, or (c) DMA printing.

Please excuse my ignorance, but if it detects the IRQ and does not use it,
how is it possible to set up interrupt-driven mode?

I am not really a 'kernel hacker', but am posting here as I have not
managed to solve the problem elsewhere. So please tell me exactly what to
put on the kernel command line at start-up.

Many thanks,

Michael Ben-Gershon
mybg@netvision.net.il
