Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131028AbRAXOoI>; Wed, 24 Jan 2001 09:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130508AbRAXOn6>; Wed, 24 Jan 2001 09:43:58 -0500
Received: from vulcan.datanet.hu ([194.149.0.156]:26517 "EHLO relay.datanet.hu")
	by vger.kernel.org with ESMTP id <S131636AbRAXOnt>;
	Wed, 24 Jan 2001 09:43:49 -0500
From: "Bakonyi Ferenc" <fero@drama.obuda.kando.hu>
Organization: Datakart Geodzia KFT.
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Date: Wed, 24 Jan 2001 15:42:28 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH]: hgafb crash on MDA only cards
CC: geert@linux-m68k.org, linux-kernel@vger.kernel.org
In-Reply-To: <3A6EDDD3.1509716C@yahoo.com>
X-mailer: Pegasus Mail for Win32 (v3.01d)
Message-Id: <E14LR8X-0007eR-00@aleph0.datakart.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul Gortmaker wrote:
> Current (2.4.0pre8) hgafb will misdetect MDA only cards and
> then crash - last message briefly seen before screen clears is
> 
> hgafb: <NULL> with 32K of memory detected.
> 
> A comparison to the detection code in XFree86 shows that hgafb 
> forgets to return failure if the status port doesn't show 
> any active changes associated with counting vertical syncs.

Hi!

I'm happy to see I'm not the only one using theese old beasts. :)
Your patch looks good, thanks for it! I'll test it tonight.

Best regards,
	Ferenc Bakonyi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
