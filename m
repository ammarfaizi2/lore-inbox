Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271972AbRIDNlP>; Tue, 4 Sep 2001 09:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271973AbRIDNlF>; Tue, 4 Sep 2001 09:41:05 -0400
Received: from alpha.netvision.net.il ([194.90.1.13]:50445 "EHLO
	alpha.netvision.net.il") by vger.kernel.org with ESMTP
	id <S271972AbRIDNku>; Tue, 4 Sep 2001 09:40:50 -0400
Message-ID: <3B94DA02.9F6E9184@netvision.net.il>
Date: Tue, 04 Sep 2001 16:41:22 +0300
From: Michael Ben-Gershon <mybg@netvision.net.il>
Organization: My Office
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tim Waugh <twaugh@redhat.com>
Subject: Re: lpr to HP laserjet stalls
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <20010903221142.J20060@redhat.com> <3B94B4E7.701C76FA@netvision.net.il> <20010904121523.Q20060@redhat.com> <3B94B93B.2B907DCF@netvision.net.il> <20010904122751.S20060@redhat.com> <3B94D58B.180860A2@netvision.net.il> <20010904142755.V20060@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Tue, Sep 04, 2001 at 04:22:19PM +0300, Michael Ben-Gershon wrote:
> 
> > I don't know what they mean (the printing itself was not affected) but
> > I guess it would be better to avoid modes which give such messages.
> 
> They are normal, really, and are there to help debugging.
> 
> > At the moment I am loading the module with:
> >
> >       insmod parport
> >       insmod parport_pc io=0x378,0xa800 irq=auto,auto dma=nofifo,nofifo
> 
> So this is interrupt-driven printing but without using the ECP
> hardware.  I wonder why CONFIG_PARPORT_PC_FIFO makes a difference.  It
> shouldn't, really, and neither should building it as a module.

Building it as a module meant I didn't have to reboot for every time
I wanted to retest it with different parameters.

Michael Ben-Gershon
mybg@netvision.net.il
