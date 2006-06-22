Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbWFVOmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWFVOmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWFVOmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:42:39 -0400
Received: from mail.gmx.net ([213.165.64.21]:65205 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751267AbWFVOmi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:42:38 -0400
X-Authenticated: #9962044
From: marvin24@gmx.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Using libata for ICH5 PATA
Date: Thu, 22 Jun 2006 16:42:30 +0200
User-Agent: KMail/1.9.3
References: <20060622004811.0009937c@werewolf.auna.net> <200606220807.34373.marvin24@gmx.de> <1150987404.15275.167.camel@localhost.localdomain>
In-Reply-To: <1150987404.15275.167.camel@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606221642.31639.marvin24@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thursday 22 June 2006 16:43 schrieben Sie:
> Ar Iau, 2006-06-22 am 08:07 +0200, ysgrifennodd marvin:
> > Le Thursday 22 June 2006 02:32, vous avez écrit :
> > > J.A. Magallón wrote:
> > > > What do I need to let libata drive the ICH5 pata ?
> > >
> > > Probably just ATA_ENABLE_PATA at the top of include/linux/libata.h.
> >
> > which doesn't work:
> >
> > CC [M]  drivers/scsi/ata_piix.o
> > drivers/scsi/ata_piix.c:190: error: ‘ich5_pata’ undeclared here (not
> > in a
>
> Already fixed and sent to Jeff. Change ich5_pata pata_ich_133

you probably mean ich_pata_133

it compiles now 

thanks 

marc
