Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131652AbRABXcH>; Tue, 2 Jan 2001 18:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131133AbRABXb5>; Tue, 2 Jan 2001 18:31:57 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:63498
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131081AbRABXbq>; Tue, 2 Jan 2001 18:31:46 -0500
Date: Tue, 2 Jan 2001 14:49:32 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dan Hollis <goemon@anime.net>, David Woodhouse <dwmw2@infradead.org>,
        Hakan Lennestal <hakanl@cdt.luth.se>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts.... 
In-Reply-To: <Pine.LNX.4.10.10101021444010.1037-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101021447070.26680-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Linus Torvalds wrote:

> Does the Maxtor and/or CDROM problems have anything to do with udma66? Ie
> if you can test, can you please check whether it's ok when they are added
> to the blacklists (or if udma66 is just disabled by default)?

Once I resend you the patches I have media-type block code for DMA on know
hosts.

Basically I have not gotten the time to add the extra DMA engine code to
handle ATAPI on these controllers in question.  Yes they do have
different address locations and rules for doing DMA/ATA33/66/100 ATAPI.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
