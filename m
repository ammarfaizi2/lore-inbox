Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTILUiE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTILUiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:38:04 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:11224 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S261895AbTILUiA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:38:00 -0400
Date: Fri, 12 Sep 2003 21:37:57 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org, Dale Blount <linux-kernel@dale.us>
Subject: Re: Adaptec 1210SA (SiL3112)
Message-ID: <20030912203757.GA25993@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org, Dale Blount <linux-kernel@dale.us>
References: <1063378797.8512.48.camel@dale.velocity.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <1063378797.8512.48.camel@dale.velocity.net>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2003 at 10:59:57AM -0400, Dale Blount wrote:
> So I've moved on to the Adaptec card (only card I could find with a SiL
> chipset).  I'd rather use a 3114 card as I need 4 ports, but I couldn't
> find any info on support/cards using that chipset.
> 
> The current problem is that the SiL3112 keeps throwing 'lost interrupt'
> messages.  I've tried DMA off/on all with no luck.  Here is the relevant
> output from dmesg:

   I get the same problem with this card. It takes my machine 90
minutes to reboot -- 30 to shut down, and 60 to restart, due to the
LVM tools scanning all of my drives. I've got a 120Gb SATA drive which
is just dead weight in this machine, I can't use it at all because of
these problems.

   Can anybody say exactly what the problem is, and how we might go
about fixing it? I haven't even seen anyone just saying "it's not
frobbing the foobar properly -- you need to get the docs from SiI to
work out why".

> Is there anything else I can do to get this card working?  Or another
> sata card *verified* working under 2.4.2x?

   I have been told by someone that the SIIG cards (with SiI3112A
chips) work under Linux. I can't confirm this, though.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
  --- "So, you're an officer and a gentleman." "Well, I always take ---  
            my socks off before,  if that's what you mean..."            

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/Yi6lssJ7whwzWGARAvWWAJ9cq3IPyAtsXdZt8R6BCXG5tOiBrgCfSbUG
LGcaX6YXG4DvbI4QIdfPUtE=
=qt+O
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
