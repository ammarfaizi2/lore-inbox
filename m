Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbQKSCDI>; Sat, 18 Nov 2000 21:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130805AbQKSCDA>; Sat, 18 Nov 2000 21:03:00 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:40968
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130516AbQKSCCp>; Sat, 18 Nov 2000 21:02:45 -0500
Date: Sat, 18 Nov 2000 17:32:35 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Rene Rebe <rene.rebe@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: VIA IDE UDMA Mode x -> CRC-ERRORs (2.4.0-testxx)
In-Reply-To: <20001118233837L.rene@jackson>
Message-ID: <Pine.LNX.4.10.10011181725580.18257-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a problem that it does not downgrade the IO if all you have is
iCRC errors.  The threshold is 10 events without other errors and it
should skip you from ATA-66 to ATA-44.  If you did not enable the tuning
aspect of the chipset then do so now.

Regards,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
