Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267590AbSKQU2f>; Sun, 17 Nov 2002 15:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267592AbSKQU2f>; Sun, 17 Nov 2002 15:28:35 -0500
Received: from mta01bw.bigpond.com ([139.134.6.78]:63692 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S267590AbSKQU2c>; Sun, 17 Nov 2002 15:28:32 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: lan based kgdb
Date: Mon, 18 Nov 2002 07:25:27 +1100
User-Agent: KMail/1.4.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk> <20021116193008.C25741@work.bitmover.com> <m11y5k3ruw.fsf@frodo.biederman.org>
In-Reply-To: <m11y5k3ruw.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211180725.27450.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 18 Nov 2002 06:42, Eric W. Biederman wrote:
> As long as the network console/debug interface includes basic a basic
> check to verify that the packets it accepts are from the local network.
This is pretty hard to do in some configurations. You essentially have to do 
this at the router, not at destination.

> And it's outgoing packets have a ttl of one.  I don't have a problem.
Recent IETF work on link-local has used TTL=255 outgoing, and it has to be 255 
at the receive end too. That is a reasonable way to ensure that is is 
link-local, since even the most brain-dead routers will at least decrement 
TTL.

> Otherwise the concept gives me security nightmares.
Computing should give you security nightmares :)

Brad
- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE91/s3W6pHgIdAuOMRAsCNAJ42Fc7CCclgD+zMbraiHYFydMcKJACfegyr
JcZ8T8+1nIe2f8G3eerNwVs=
=uGdb
-----END PGP SIGNATURE-----

