Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUEPQTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUEPQTu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 12:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUEPQTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 12:19:50 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:4304 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S263663AbUEPQTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 12:19:47 -0400
Date: Sun, 16 May 2004 16:39:46 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Philip Dodd <phil.lists@two-towers.net>
Cc: Jens Axboe <axboe@suse.de>, Daniele Bernardini <db@sqbc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: dma ripping
Message-ID: <20040516153945.GA21520@selene>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Philip Dodd <phil.lists@two-towers.net>, Jens Axboe <axboe@suse.de>,
	Daniele Bernardini <db@sqbc.com>, linux-kernel@vger.kernel.org
References: <1084548566.12022.57.camel@linux.site> <20040515101415.GA24600@suse.de> <1084610731.4666.8.camel@linux.site> <20040515145800.GE24600@suse.de> <1084629809.4612.51.camel@linux.site> <20040515211901.GG24600@suse.de> <40A78834.1030605@two-towers.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <40A78834.1030605@two-towers.net>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 16, 2004 at 05:26:44PM +0200, Philip Dodd wrote:
> Jens Axboe wrote:
> 8<
> >You are not being stupid, I think we have a leak in there some where.
> >PIO should work just fine. Slower than DMA of course, but it should work
> >perfectly of course.
> 
> Hi All,
> 
> Just a quick "me too" here - though symptoms don't appear to be 
> identical.  Running 2.6.6 on Debian Sid and using nvidia binary modules. 
>  My system doesn't hang, but when I get the log message "cdrom: 
> dropping to single frame dma" ripping stops working.  It still rips but 
> I get silence - it will rip the track OK, as in read through the correct 
> track length, but I get silence on the resulting wav file.

   Put me down for this latter one, too. I'm using a vanilla 2.6.[56]
on amd64. Controller is VIA.

   It seems to be related to hard-to-read CDs (dirty/scratched/badly-
made) -- I've got a couple here that I'm pretty sure I can use as test
cases to trigger the problem instantly.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
  --- "What's so bad about being drunk?" "You ask a glass of water" ---  
                                                                         

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAp4tBssJ7whwzWGARAj4oAJ4iTPy1REnW9d1c5F1McdhIX/EXTQCgkq0a
CCC/Od0SdW3iQNo5B4DZGcI=
=Go9B
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
