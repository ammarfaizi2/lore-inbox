Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280110AbRKHOv6>; Thu, 8 Nov 2001 09:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280159AbRKHOvv>; Thu, 8 Nov 2001 09:51:51 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:36108 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S280110AbRKHOvb> convert rfc822-to-8bit; Thu, 8 Nov 2001 09:51:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Update to the Compaq cpqarray driver for 2.4.14 kernel tree ...
Date: Thu, 8 Nov 2001 08:51:25 -0600
Message-ID: <A2C35BB97A9A384CA2816D24522A53BB0EA42A@cceexc18.americas.cpqcorp.net>
Thread-Topic: [PATCH] Update to the Compaq cpqarray driver for 2.4.14 kernel tree ...
Thread-Index: AcFoY0NUTF5TCSNkTFeSb/6nhBWS7gAAKdgg
From: "White, Charles" <Charles.White@COMPAQ.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Alan Cox (E-mail)" <alan@redhat.com>, <linux-kernel@vger.kernel.org>,
        "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
X-OriginalArrivalTime: 08 Nov 2001 14:51:25.0747 (UTC) FILETIME=[D7135030:01C16864]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it is backing out the do_request changes, because that version was
locking up on format.. 
I just got your fix for that... I will work it into the next rev of the
driver... 


		-----Original Message-----
		From:	Jens Axboe [mailto:axboe@suse.de]
		Sent:	Thursday, November 08, 2001 8:40 AM
		To:	White, Charles
		Cc:	Alan Cox (E-mail); linux-kernel@vger.kernel.org;
Cameron, Steve
		Subject:	Re: [PATCH] Update to the Compaq
cpqarray driver for 2.4.14 kernel tree ...

		On Thu, Nov 08 2001, White, Charles wrote:
		> The patch is to big to include in the e-mail... 
		> This is version 2.4.20 of the cpqarray driver... 
		> 
		> This changes the driver to use the new 2.4 kernel PCI
APIs. This changes
		> how all our cards are detected. 
		> This adds some new IOCTLs for adding/deleting volumes
while the driver
		> is online. 
		> It have added code to request/release the io-region
used by our cards.
		> 
		> It has a small fix to the flush on unload.  
		> 
		>
ftp://ftp.compaq.com/pub/products/drivers/linux/released/cpqarray/cpqarr
		> ay_2.4.20D_for_2.4.14.patch

		It's backing out the recent changes etc.

		-- 
		Jens Axboe
		
