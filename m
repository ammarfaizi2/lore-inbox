Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLUIa4>; Thu, 21 Dec 2000 03:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLUIaq>; Thu, 21 Dec 2000 03:30:46 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:19214 "EHLO
	pobox.com") by vger.kernel.org with ESMTP id <S129260AbQLUIal>;
	Thu, 21 Dec 2000 03:30:41 -0500
From: "Barry K. Nathan" <barryn@pobox.com>
Message-Id: <200012210758.XAA07609@pobox.com>
Subject: Re: Extreme IDE slowdown with 2.2.18
To: mharris@opensourceadvocate.org (Mike A. Harris)
Date: Wed, 20 Dec 2000 23:58:45 -0800 (PST)
Cc: ja@ssi.bg (Julian Anastasov),
        robho956@student.liu.se (Robert Högberg),
        andre@linux-ide.org (Andre Hedrick),
        linux-kernel@vger.kernel.org (linux-kernel)
Reply-To: barryn@pobox.com
In-Reply-To: <Pine.LNX.4.31.0012202253530.748-100000@asdf.capslock.lan> from "Mike A. Harris" at Dec 20, 2000 11:06:02 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike A. Harris wrote:
[snip]
> message saying UDMA 3/4/5 is not supported.  It also claims the
> MVP3 chipset is UDMA-33 only, whereas all relevant docs I can
> muster including the mobo manual state the board is UDMA-66
> capable.  Mental note to myself: Do not enable WORD93 invalidate.
> ;o)

I'm somewhat tired and busy, so I'll post URLs without quoting anything
from them (look at the data in *all* of them, and connect the dots, before
you come to any conclusions). Short version of the story: Some MVP3's
support UDMA-66, some don't -- it depends on the southbridge. 596B & 686A
do, others don't.

http://www.via.com.tw/news/98mvp3nr.htm
http://www.via.com.tw/products/prodmvp3.htm
http://www.via.com.tw/support/faq.htm#ide

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
