Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbQKUMpz>; Tue, 21 Nov 2000 07:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbQKUMpp>; Tue, 21 Nov 2000 07:45:45 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:48904 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129636AbQKUMpa>; Tue, 21 Nov 2000 07:45:30 -0500
Date: Tue, 21 Nov 2000 06:15:11 -0600
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andre Hedrick <andre@linux-ide.org>, Hakan Lennestal <hakanl@cdt.luth.se>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem
Message-ID: <20001121061511.F2918@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.10.10011210112530.26514-100000@master.linux-ide.org> <8094.974804486@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8094.974804486@redhat.com>; from dwmw2@infradead.org on Tue, Nov 21, 2000 at 11:01:26AM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [hakanl@cdt.luth.se]
> > Udma3 seem to be rock solid though as long as it manages to pass
> > the partition detection during boot up.

[David Woodhouse]
> If it falls over at udma3, perhaps we should blacklist it all the way
> down to udma2?

The way I understood Hakan was: "it boots in udma4, and if it gets all
the way to userland I immediately hdparm it down to udma3, and then it
works fine".

Hakan, is this what you meant?  If so, forcing it <= udma3 should be ok.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
