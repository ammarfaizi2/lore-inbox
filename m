Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131136AbRAZRGW>; Fri, 26 Jan 2001 12:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRAZRGN>; Fri, 26 Jan 2001 12:06:13 -0500
Received: from 041imtd176.chartermi.net ([24.247.41.176]:46479 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S131136AbRAZRGF>; Fri, 26 Jan 2001 12:06:05 -0500
Date: Fri, 26 Jan 2001 12:05:56 -0500
From: Simon Kirby <sim@stormix.com>
To: linux-kernel@vger.kernel.org
Subject: ECN
Message-ID: <20010126120556.A13417@stormix.com>
In-Reply-To: <20010126124426.O2360@marowsky-bree.de> <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk> <20010126154447.L3849@marowsky-bree.de> <20010126160342.B7096@pcep-jamie.cern.ch> <14961.37986.469902.496834@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <14961.37986.469902.496834@pizda.ninka.net>; from davem@redhat.com on Fri, Jan 26, 2001 at 07:14:42AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 07:14:42AM -0800, David S. Miller wrote:

> Jamie Lokier writes:
>  > Does ECN provide perceived benefits to the node using it?
> 
> Yes, endpoints and intermediate routers can tell the TCP sender about
> congestion instead of TCP having to guess about it based upon observed
> packet drop.
> 
> It is a major enhancement to performance over any WAN.
> 
> The endpoint based congestion notification happens _now_ if both
> sides speak ECN.  The router based notification will be happening
> in the near future as Cisco and others deploy ECN speaking versions of
> their router software.

Hmm... Just wondering: what does TCP then do when it receives this ECN
notification?  Try harder, try less?  Or does it get a specific packet
saying "I dropped your packet", and then the sender retransmits?

I suppose I could go find the RFC...

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
