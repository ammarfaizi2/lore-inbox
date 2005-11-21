Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVKUPKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVKUPKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVKUPKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:10:42 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:26604 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S932319AbVKUPKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:10:40 -0500
Date: Mon, 21 Nov 2005 15:10:35 +0000
From: Hugo Mills <hugo@carfax.org.uk>
To: Patrick Boettcher <pb@linuxtv.org>
Cc: Johannes Stezenbach <js@linuxtv.org>, Hugo Mills <hugo-lkml@carfax.org.uk>,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
       Jeremy Nysen <jnysen@idx.com.au>
Subject: Re: [linux-dvb-maintainer] Multiple USB DVB devices cause hard lockups
Message-ID: <20051121151035.GC17895@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
	Patrick Boettcher <pb@linuxtv.org>,
	Johannes Stezenbach <js@linuxtv.org>,
	Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
	Jeremy Nysen <jnysen@idx.com.au>
References: <20051109135925.GF12751@localhost.localdomain> <20051120021719.GC8157@linuxtv.org> <Pine.LNX.4.64.0511210942360.1390@pub3.ifh.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511210942360.1390@pub3.ifh.de>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 21, 2005 at 09:52:20AM +0100, Patrick Boettcher wrote:
> On Sun, 20 Nov 2005, Johannes Stezenbach wrote:
> >>   I'm trying to get a pair of Twinhan Alpha II DVB-USB devices
> >>working on the same machine. With a single device plugged in, I can
> >>quite easily receive and stream data.
> >
> >Maybe Patrick can comment, I believe he tested with multiple
> >USB devices.
> 
> Sorry Johannes, that it seems I'm always waiting for your alarm to make me 
> write a Mail - but this time I cannot add anything to find the problem - 
> or maybe I can - not sure :):
> 
> I tested it with multiple dvb-usb devices in parallel - but never with 2 
> Twinhan Alpha boxes.
> 
> Just a thought: Hugo, can you enable dvb-usb-debug and load the dvb-usb.ko 
> with parameter debug=9 .
> 
> Then start the transfer and your syslog will be filled with messages of 
> returning USB-buffers and their sizes. Try to catch some lines from both 
> devices and send them here.

   Yes, I'll try that. It'll be tomorrow evening (GMT), though, as I'm
out this evening. I'll also try to get a serial console running so I
can try to capture the full oops text.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
  --- You've read the project plan.  Forget that. We're going to Do ---  
                      Stuff and Have Fun doing it.                       

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDgeNrssJ7whwzWGARAsrzAJ4+t1kd+wg/PUqEKvULqtAIdnA5PwCgpylx
qPqsOxSif4K6yu3tH7CW92E=
=euuu
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
