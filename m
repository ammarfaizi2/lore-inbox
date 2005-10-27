Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVJ0U5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVJ0U5v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVJ0U5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:57:51 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:10375 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932242AbVJ0U5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:57:50 -0400
Subject: Re: 4GB memory and Intel Dual-Core system
From: Marcel Holtmann <marcel@holtmann.org>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051027204923.M89071@linuxwireless.org>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	 <20051027204923.M89071@linuxwireless.org>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 22:57:47 +0200
Message-Id: <1130446667.5416.14.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alejandro,

> > Look at the e820 dump in your kernel bootlog.  I'll bet you'll see a
> > big chunk of reserved address space.  Do you have any PCI devices 
> > like video cards that use a lot of PCI address space?
> > 
> > I don't know if EM64T systems (or whatever the right term is) have a
> > way of remapping some RAM above 4 GB so that you can use all your
> > memory in a case like this.
> 
> I think this always shows this amount of RAM. Windows does the same thing
> AFAIK. It's basically some sort of limitation and the motherboard reports an
> specific amount of memory.
> 
> There is a deeper reason, ask google.
> 
> (IA32 does not support all that much RAM, so it shows like 3.xxGB RAM but uses
> the rest for System Resources like Video, PCI, bla bla)
> 
> EM64T is not really 64Bit so, is still IA32.

the board in this system is a Intel D945GNT and the box tells me the
maximum supported amount of RAM is 4 GB. So there should be a way to
address this amount memory.

Regards

Marcel


