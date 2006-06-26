Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933118AbWFZWco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933118AbWFZWco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933115AbWFZWcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:32:33 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35793 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S933114AbWFZWcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:32:25 -0400
X-Sasl-enc: f2Ip4yOGTIljyO7p6kyheTevwhBtdDDAQGsf03qMT2To 1151361143
Message-ID: <057801c69970$70b45090$0e00cb0a@robm>
From: "Robert Mueller" <robm@fastmail.fm>
To: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <rdunlap@xenotime.net>, <hch@infradead.org>, <erich@areca.com.tw>,
       <brong@fastmail.fm>, <dax@gurulabs.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
References: <09be01c695b3$2ed8c2c0$c100a8c0@robm> <20060621222826.ff080422.akpm@osdl.org> <1151333338.2673.4.camel@mulgrave.il.steeleye.com>
Subject: Re: Areca driver recap + status
Date: Tue, 27 Jun 2006 08:32:19 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - PAE (cast of dma_addr_t to unsigned long) issues.

Can you explain a bit what this is about and what the effect is? It's just 
that we've been using the driver (older version from the areca website) in a 
PAE kernel on machines with 8G of memory and haven't had a problem yet 
(running high IO load for several weeks) but this sounds like it 
might/should cause corruption or crashing in this situation?

Rob

