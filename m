Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbRAGMyk>; Sun, 7 Jan 2001 07:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbRAGMya>; Sun, 7 Jan 2001 07:54:30 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:25861
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131460AbRAGMyX>; Sun, 7 Jan 2001 07:54:23 -0500
Date: Mon, 8 Jan 2001 01:54:21 +1300
From: Chris Wedgwood <cw@f00f.org>
To: sourav@cs.cmu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Speed of the network card
Message-ID: <20010108015421.B2575@metastasis.f00f.org>
In-Reply-To: <20010107144819.B1617@metastasis.f00f.org> <200101070930.WAA20212@mx1.clear.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101070930.WAA20212@mx1.clear.net.nz>; from sourav@ux4.sp.cs.cmu.edu on Sun, Jan 07, 2001 at 04:30:30AM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 04:30:30AM -0500, Sourav Ghosh wrote:

    I would like to determine the banwidth the card is getting from
    the network.

/proc/net/dev exports counters; you can monitor those -- I'm sure
there are perfomance program that do exactly this.

    For an ethernet, it could be either 10Mbps or 100Mbps, is there
    any way of knowing from inside the kernel how much is the
    bandwidth the card is actually receiving from the network,
    especially when it is capable of getting either 10Mbps or
    100Mbps?

The kernel counts packets and bytes; you need to work out bandwidth
in userland from that.


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
