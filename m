Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWFVO2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWFVO2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbWFVO2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:28:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27047 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161145AbWFVO2T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:28:19 -0400
Subject: Re: Using libata for ICH5 PATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: marvin <marvin24@gmx.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
In-Reply-To: <200606220807.34373.marvin24@gmx.de>
References: <20060622004811.0009937c@werewolf.auna.net>
	 <4499E524.4060206@garzik.org>  <200606220807.34373.marvin24@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 22 Jun 2006 15:43:24 +0100
Message-Id: <1150987404.15275.167.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-22 am 08:07 +0200, ysgrifennodd marvin:
> Le Thursday 22 June 2006 02:32, vous avez écrit :
> > J.A. Magallón wrote:
> > > What do I need to let libata drive the ICH5 pata ?
> >
> > Probably just ATA_ENABLE_PATA at the top of include/linux/libata.h.
> 
> which doesn't work:
> 
> CC [M]  drivers/scsi/ata_piix.o
> drivers/scsi/ata_piix.c:190: error: ‘ich5_pata’ undeclared here (not in a 

Already fixed and sent to Jeff. Change ich5_pata pata_ich_133

