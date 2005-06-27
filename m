Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVF0T6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVF0T6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVF0T6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:58:24 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:22993 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261599AbVF0T5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:57:24 -0400
Subject: Re: PATCH: IDE - sensible probing for PCI systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61L.0506271519060.23903@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl>
	 <1119363150.3325.151.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl>
	 <1119379587.3325.182.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl>
	 <1119566026.18655.30.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506241217490.28452@blysk.ds.pg.gda.pl>
	 <1119702761.28649.2.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506271519060.23903@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119902086.27009.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Jun 2005 20:54:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-27 at 15:55, Maciej W. Rozycki wrote:
>  Strange -- boxes have started to appear that have no connectors or at 
> least PCB headers for them.  What's the point in removing connectors and 
> leaving the (otherwise useful) hardware inaccessible?

It saves external components, buffers etc and makes it easier to pass
FCC and CE emissions testing, while removing it from the chip means two
chips and that costs money

> > Whats the _economic_ incentive to do so ? There basically isnt one.
> 
>  One chip less?  Well, perhaps the cost of R&D for such a system would 
> exceed the total cost of keeping that chip included in all boards 
> manufactured during the term corporate planning is able to cover....

A PC with all the LPC bus goodies is generally a three chip solution
anyway. The ISA bus vanished, some bits got integrated and an LPC bus
was added. By now the LPC bus and its contents have all vanished into
the onboard logic too.


