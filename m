Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTELSBt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTELSBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:01:49 -0400
Received: from zeus.kernel.org ([204.152.189.113]:6605 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262413AbTELRnO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:43:14 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Message Signalled Interrupt support?
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Mon, 12 May 2003 10:53:55 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56401E44FDE@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Message Signalled Interrupt support?
Thread-Index: AcMYo0LM/HyIEr8lRxSwovntR+roTQAC8bKA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Cc: "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>, <willy@debian.org>,
       <davem@redhat.com>
X-OriginalArrivalTime: 12 May 2003 17:54:04.0455 (UTC) FILETIME=[7A2BF370:01C318AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes. We are posting a patch soon (probably this week). 

You don't need to change the existing device drivers unless you want to support multiple messages (something like multiple vectors per IRQ).

Thanks,
Jun

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com]
> Sent: Monday, May 12, 2003 9:33 AM
> To: linux-kernel@vger.kernel.org
> Cc: Ivan Kokshaysky; willy@debian.org; davem@redhat.com
> Subject: Message Signalled Interrupt support?
> 
> Has anybody done any work, or put any thought, into MSI support?
> 
> Would things massively break if I set up MSI manually in the driver?
> 
> I heard rumblings on lkml that Intel has done some work internally w/
> MSI support in Linux, but that doesn't help me much without further
> details ;-)
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
