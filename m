Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136830AbRAHKwc>; Mon, 8 Jan 2001 05:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRAHKwW>; Mon, 8 Jan 2001 05:52:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18308 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136920AbRAHKwG>;
	Mon, 8 Jan 2001 05:52:06 -0500
Date: Mon, 8 Jan 2001 02:34:52 -0800
Message-Id: <200101081034.CAA17681@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hch@caldera.de
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <200101081039.LAA30397@ns.caldera.de> (message from Christoph
	Hellwig on Mon, 8 Jan 2001 11:39:15 +0100)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101081039.LAA30397@ns.caldera.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 8 Jan 2001 11:39:15 +0100
   From: Christoph Hellwig <hch@caldera.de>

   don't you think the writepage file operation is rather hackish?

Not at all, it's simply direct sendfile support.  It does
not try to be any fancier than that.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
