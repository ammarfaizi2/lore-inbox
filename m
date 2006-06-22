Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWFVGHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWFVGHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWFVGHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:07:49 -0400
Received: from mail.gmx.de ([213.165.64.21]:48091 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750817AbWFVGHs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:07:48 -0400
X-Authenticated: #9962044
From: marvin <marvin24@gmx.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: Using libata for ICH5 PATA
Date: Thu, 22 Jun 2006 08:07:34 +0200
User-Agent: KMail/1.9.1
References: <20060622004811.0009937c@werewolf.auna.net> <4499E524.4060206@garzik.org>
In-Reply-To: <4499E524.4060206@garzik.org>
Cc: linux-kernel@vger.kernel.org,
       "J.A. =?utf-8?q?Magall=C3=B3n?=" <jamagallon@ono.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606220807.34373.marvin24@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thursday 22 June 2006 02:32, vous avez écrit :
> J.A. Magallón wrote:
> > What do I need to let libata drive the ICH5 pata ?
>
> Probably just ATA_ENABLE_PATA at the top of include/linux/libata.h.

which doesn't work:

CC [M]  drivers/scsi/ata_piix.o
drivers/scsi/ata_piix.c:190: error: ‘ich5_pata’ undeclared here (not in a 
function)
make[2]: *** [drivers/scsi/ata_piix.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2


marc
