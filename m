Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130248AbQKAPiL>; Wed, 1 Nov 2000 10:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131225AbQKAPiC>; Wed, 1 Nov 2000 10:38:02 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:30985
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130248AbQKAPhs>; Wed, 1 Nov 2000 10:37:48 -0500
Date: Wed, 1 Nov 2000 07:37:22 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Mares <mj@suse.cz>
cc: Tom Rini <trini@kernel.crashing.org>,
        Stephen Rothwell <sfr@linuxcare.com.au>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] make my life easier ...
In-Reply-To: <20001101120405.C1110@albireo.ucw.cz>
Message-ID: <Pine.LNX.4.10.10011010736100.31230-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Martin Mares wrote:

> Hello!
> 
> > Aside from all of the other comments that've been made, because the user might
> > have tweeked them at boot.  ie turn on UDMA.  If we just re-initalized on
> > wakeup, you loose this.
> 
> I've of course meant reinitialize with the user-supplied settings, just as we
> do during normal initialization/configuration of the driver.

No, we put it back in the mode it was in before APM wacked.
Yes, if we call the settings before APM wacks it 'user settings'.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
