Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266042AbRGCWsW>; Tue, 3 Jul 2001 18:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266044AbRGCWsM>; Tue, 3 Jul 2001 18:48:12 -0400
Received: from toscano.org ([64.50.191.142]:38592 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S266042AbRGCWsB>;
	Tue, 3 Jul 2001 18:48:01 -0400
Date: Tue, 3 Jul 2001 18:47:56 -0400
From: Pete Toscano <pete.lkml@toscano.org>
To: linux-kernel@vger.kernel.org
Subject: USB printing == kernel lockup?
Message-ID: <20010703184756.A5174@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Unexpected: The Spanish Inquisition
X-Uptime: 6:39pm  up 2 days, 21:13,  4 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm still looking into this, but has anybody else seen this problem?
When I do anything (print to it, query its ink levels with escputil,
etc.) with my Epson 870 while it's hooked to my computer via USB, the
whole machine locks hard.  If I change the connection over to a printer
cable on a parallel port connection, eveything works fine.  USB printing
used to work fine until recently.  (I don't print much, so how recently,
I don't know yet.)

I'm in the process of trying other kernels (tested 2.4.5 and
2.4.6-pre[68]) and USB controllers (JE's UHCI vs the standard UHCI) but
I'm not done yet. 

Has anyone else has seen this problem?  I posted to the gimp-print and
linux-usb lists, but there was nary a response.

The printer is connected to the USB hub in my Nokia monitor, which also
has a mouse connected to it and that's running fine.  I'm using a Tyan
Tiger 133 mother board (VIA Apollo Pro 133A chipset) and SMP-enabled
kernel.

Thanks,
pete
