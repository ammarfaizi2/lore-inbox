Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbRAPTxR>; Tue, 16 Jan 2001 14:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132598AbRAPTxH>; Tue, 16 Jan 2001 14:53:07 -0500
Received: from valbert.esscom.com ([199.89.135.168]:1800 "EHLO esscom.com")
	by vger.kernel.org with ESMTP id <S132547AbRAPTwy>;
	Tue, 16 Jan 2001 14:52:54 -0500
Date: Tue, 16 Jan 2001 12:52:21 -0700
From: Val Henson <vhenson@esscom.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jes@linuxcare.com,
        Kurt Ferreira <kferreir@esscom.com>
Subject: [PATCH] rrunner.c
Message-ID: <20010116125221.C11965@esscom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.11i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for the RoadRunner HIPPI driver includes:

* Fix crash on null dereference in rr_interrupt due to firmware bug
* Fix crash on null dereference in rr_interrupt with better link ON/OFF
  handling
* Fix crash due to NIC continuing to DMA after HALT (requires firmware
  >= 2.0.67)

Plus numerous smaller bugfixes and features.  Patches are available
against 2.2.18 and 2.4.0.  The patches are too big to post on the
list, so here's the URL (with more details on the patch):

http://www.nmt.edu/~val/patch.html

Sorry for the big patch, I'll be happy to create a subset of the patch
for anyone who doesn't want to merge the whole thing.

Credit goes mainly to Kurt Ferreira <kurdt@nmt.edu>, also of Essential
Communications.

-VAL
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
