Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbVHRWlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbVHRWlo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVHRWln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:41:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:4505 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932504AbVHRWln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:41:43 -0400
Subject: Re: [git patches] ide update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Aug 2005 00:08:54 +0100
Message-Id: <1124406535.20755.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-18 at 23:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> +	},{	/* 14 */
> +		.name		= "Revolution",
> +		.init_hwif	= init_hwif_generic,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.bootable	= OFF_BOARD,
>   	}

This seems rather odd - the driver asks for AUTODMA yet because its IDE
generic contains no code to retune the device interface for DMA ?


BTW whats the status on the CS5535 driver that someone submitted a while
back ?

