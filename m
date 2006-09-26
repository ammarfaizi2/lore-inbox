Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWIZUzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWIZUzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWIZUzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:55:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20445 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932307AbWIZUzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:55:11 -0400
Subject: Re: [PATCH] libata-sff: use our IRQ defines
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060926204433.GA77171@dspnet.fr.eu.org>
References: <1159289737.11049.261.camel@localhost.localdomain>
	 <20060926204433.GA77171@dspnet.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 22:19:22 +0100
Message-Id: <1159305562.11049.312.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-26 am 22:44 +0200, ysgrifennodd Olivier Galibert:
> >  		if (probe_ent->irq)
> > -			probe_ent->irq2 = 15;
> > +			probe_ent->irq2 = ATA_SECONDARY_IRQ;
> >  		else
> >  			probe_ent->irq = 15;
> 
> Isn't that one supposed to be ATA_SECONDARY_IRQ too?
> 
> >  		probe_ent->port[1].cmd_addr = ATA_SECONDARY_CMD;

Duh yes...

(adds another paper bag to the pile)

