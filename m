Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLPV0E>; Sat, 16 Dec 2000 16:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbQLPVZy>; Sat, 16 Dec 2000 16:25:54 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:64525 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129352AbQLPVZp>; Sat, 16 Dec 2000 16:25:45 -0500
Date: Sat, 16 Dec 2000 14:55:09 -0600
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: fritz@isdn4linux.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/isdn/isdn_bsdcomp.c can only be modular (240t13p2)
Message-ID: <20001216145509.I3199@cadcamlab.org>
In-Reply-To: <20001216214709.C609@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001216214709.C609@jaquet.dk>; from rasmus@jaquet.dk on Sat, Dec 16, 2000 at 09:47:09PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Rasmus Andersen]
> -      tristate '    Support BSD compression with sync PPP' CONFIG_ISDN_PPP_BSDCOMP
> +      dep_tristate '    Support BSD compression with sync PPP' CONFIG_ISDN_PPP_BSDCOMP $CONFIG_MODULES

Kai has a better fix in his tree already.  Various ISDN build problems
are going away Real Soon Now. (:

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
