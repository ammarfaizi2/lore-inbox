Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131732AbRBDMgH>; Sun, 4 Feb 2001 07:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131733AbRBDMfr>; Sun, 4 Feb 2001 07:35:47 -0500
Received: from colorfullife.com ([216.156.138.34]:20243 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131732AbRBDMfm>;
	Sun, 4 Feb 2001 07:35:42 -0500
Message-ID: <3A7D4C8E.EC487631@colorfullife.com>
Date: Sun, 04 Feb 2001 13:35:26 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: Jonathan Morton <chromi@cyberspace.org>, linux-kernel@vger.kernel.org,
        ksa1 <ksa1@gmx.de>
Subject: Re: d-link dfe-530 tx (bug-report)
In-Reply-To: <Pine.LNX.4.30.0102041127500.24217-100000@cola.teststation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:
> 
> The "transmit timed out" message is simply saying that we told the card to
> send something but it hasn't generated an interrupt or anything allowing
> the driver to know the packet was actually sent.
>
check via_rhine_tx_timeout():
the function is basically empty.

> 
> Oh, that's known already. They haven't released any info on the older
> "VT3043" chip either, afaik. And the vt86c100a.pdf document is just a
> preliminary version.
> 
Where can I find that file?
I'll try to implement tx_timeout()

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
