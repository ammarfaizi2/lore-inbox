Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129798AbRBYDYX>; Sat, 24 Feb 2001 22:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129799AbRBYDYN>; Sat, 24 Feb 2001 22:24:13 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:56845 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129798AbRBYDYI>; Sat, 24 Feb 2001 22:24:08 -0500
Date: Sun, 25 Feb 2001 16:23:57 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
Message-ID: <20010225162357.A12123@metastasis.f00f.org>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <3A986EDB.363639E7@coplanar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A986EDB.363639E7@coplanar.net>; from jerj@coplanar.net on Sat, Feb 24, 2001 at 09:32:59PM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2001 at 09:32:59PM -0500, Jeremy Jackson wrote:

    Related question: are there any 100Mbit NICs with cpu's onboard?

Yes, but the only ones I've seen to date are magic and do special
things (like VPN or hardware crypto). I'm not sure without 'magic'
requirements there is much point for 100M on modern hardware.

Not affordable and whilst moving some of the IP stack onto the card
(I think this is what are alluding to) would be extremely non-trivial
especially if you want all the components (host OS, multiple networks
cards) to talk to each other asynchronously and you would all have to
deal with buggy hardware that doesn't like doing PCI-PCI transfers
and such like.

That said, it would be an extemely neat thing to do from a technical
perspective, but I don't know if you would ever get really good
performance from it.




  --cw
