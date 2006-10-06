Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWJFNhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWJFNhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWJFNhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:37:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5553 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932332AbWJFNhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:37:41 -0400
Subject: Re: [PATCH 4/5] ioremap balanced with iounmap for
	drivers/char/rio/rio_linux.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1160133666.19143.150.camel@amol.verismonetworks.com>
References: <1160110628.19143.89.camel@amol.verismonetworks.com>
	 <1160133715.1607.64.camel@localhost.localdomain>
	 <1160133666.19143.150.camel@amol.verismonetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Oct 2006 15:03:25 +0100
Message-Id: <1160143406.1607.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-06 am 16:51 +0530, ysgrifennodd Amol Lad:
> > > +
> > > +		if (hp->Caddr)
> > > +			iounmap(hp->Caddr);
> > >  	}
> > 
> > I don't think this is sufficient because it may be unmapped earlier on
> > error but hp->Caddr is not then cleared .
> 
> Is this fine ?
> 
> Signed-off-by: Amol Lad <amol@verismonetworks.com>

Acked-by: Alan Cox <alan@redhat.com>

Thanks

