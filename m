Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317494AbSHHMRs>; Thu, 8 Aug 2002 08:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317499AbSHHMRr>; Thu, 8 Aug 2002 08:17:47 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:60142 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317494AbSHHMRr>; Thu, 8 Aug 2002 08:17:47 -0400
Subject: Re: [OT] 2.4.19 BUG in page_alloc.c:91
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <m17cmFU-003oZpC@zeus.domdv.de>
References: <3D51DB52.6000200@verizon.net>
	<1028810336.28882.18.camel@irongate.swansea.linux.org.uk> 
	<m17cmFU-003oZpC@zeus.domdv.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 14:41:19 +0100
Message-Id: <1028814079.28882.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 13:19, Andreas Steinmetz wrote:
> # insmod xircom_tulip_cb
> Using /lib/modules/2.4.19/kernel/drivers/net/pcmcia/xircom_tulip_cb.o
> Warning: loading
> /lib/modules/2.4.19/kernel/drivers/net/pcmcia/xircom_tulip_cb.o will taint the 
> kernel: non-GPL license - GPL v2

Sounds like its missing the license tag - ok that would explain it. I'll
take a look at that

> That's no criticism of the nvidia handling (I don't own such a card), it is
> more the new "P=must be proprietary" attitude I don't exactly like.

Its the only way I can filter bugs efficiently enough. The alternative
is I only look at bug reports from Red Hat paying customers, and that
isnt helpful to anyone

