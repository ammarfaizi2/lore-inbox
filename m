Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRAIVfp>; Tue, 9 Jan 2001 16:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130231AbRAIVfg>; Tue, 9 Jan 2001 16:35:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43142 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129774AbRAIVfY>;
	Tue, 9 Jan 2001 16:35:24 -0500
Date: Tue, 9 Jan 2001 13:18:06 -0800
Message-Id: <200101092118.NAA05606@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: sct@redhat.com
CC: mingo@elte.hu, sct@redhat.com, riel@conectiva.com.br, hch@caldera.de,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010109151725.D9321@redhat.com> (sct@redhat.com)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109141806.F4284@redhat.com> <Pine.LNX.4.30.0101091532150.4368-100000@e2> <20010109151725.D9321@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 9 Jan 2001 15:17:25 +0000
   From: "Stephen C. Tweedie" <sct@redhat.com>

   Jes has also got hard numbers for the performance advantages of
   jumbograms on some of the networks he's been using, and you ain't
   going to get udp jumbograms through a page-by-page API, ever.

Again, see MSG_MORE in the patches.  It is possible and our UDP
implementation could make it easily.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
