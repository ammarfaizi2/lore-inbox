Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129402AbRAZPZq>; Fri, 26 Jan 2001 10:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAZPZg>; Fri, 26 Jan 2001 10:25:36 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:54799 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129402AbRAZPZW>; Fri, 26 Jan 2001 10:25:22 -0500
Date: Fri, 26 Jan 2001 16:24:27 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, James Sutherland <jas88@cam.ac.uk>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126162427.D7096@pcep-jamie.cern.ch>
In-Reply-To: <20010126124426.O2360@marowsky-bree.de> <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk> <20010126154447.L3849@marowsky-bree.de> <20010126160342.B7096@pcep-jamie.cern.ch> <14961.37986.469902.496834@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14961.37986.469902.496834@pizda.ninka.net>; from davem@redhat.com on Fri, Jan 26, 2001 at 07:14:42AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
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

So there is no need to force everyone to upgrade to ECN right away.
They will eventually do so for the performance increase.

Presumably ISPs also benefit from ECN because they need less bandwidth
for the same traffic -- fix your firewall and SAVE MONEY on pipes!!!

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
