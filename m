Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRA3MZb>; Tue, 30 Jan 2001 07:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbRA3MZV>; Tue, 30 Jan 2001 07:25:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63617 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129406AbRA3MZJ>;
	Tue, 30 Jan 2001 07:25:09 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14966.45657.61304.403990@pizda.ninka.net>
Date: Tue, 30 Jan 2001 04:23:53 -0800 (PST)
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] Fresh zerocopy patch on kernel.org
In-Reply-To: <20010131001605.B6620@metastasis.f00f.org>
In-Reply-To: <14966.35438.429963.405587@pizda.ninka.net>
	<20010131001605.B6620@metastasis.f00f.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wedgwood writes:
 > On Tue, Jan 30, 2001 at 01:33:34AM -0800, David S. Miller wrote:
 > 
 >     2) Accept TCP flags (ACK, URG, RST, etc.) for out of window packets
 >        if truncating the data to the window would make that packet valid.
 >        (Alexey)
 > 
 >     3) Add SO_ACCEPTCONN, Unix standard wants it. (me)
 > 
 > these have been feed back for 2.4.x Linus anyhow right?

Yes, but I couldn't get them to him in time for 2.4.1

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
