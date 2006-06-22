Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWFVMza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWFVMza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 08:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWFVMza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 08:55:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54479 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751783AbWFVMz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 08:55:29 -0400
Subject: Re: Memory corruption in 8390.c ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au,
       snakebyte@gmx.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       netdev@vger.kernel.org
In-Reply-To: <1150976016.3120.19.camel@laptopd505.fenrus.org>
References: <20060622023029.GA6156@gondor.apana.org.au>
	 <20060622.012609.25474139.davem@davemloft.net>
	 <20060622083037.GB26083@gondor.apana.org.au>
	 <20060622.013440.97293561.davem@davemloft.net>
	 <1150976063.15275.146.camel@localhost.localdomain>
	 <1150976016.3120.19.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Jun 2006 14:10:43 +0100
Message-Id: <1150981843.15275.163.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-22 am 13:33 +0200, ysgrifennodd Arjan van de Ven:
> > The 8390 change (corrected version) also makes 8390.c faster so should
> > be applied anyway, 
> 
> 8390 is such a race monster that a few cycles matter a lot! :-)

There are generic 8390 clones for 100Mbit. I'm not suggesting its a good
idea but people did it.

Alan

