Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbUEKMTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUEKMTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUEKMTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:19:10 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:27824 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S263162AbUEKMTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:19:06 -0400
Date: Tue, 11 May 2004 22:17:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: nf2@scheinwelt.at
Cc: cw@f00f.org, ttb@tentacle.dhs.org, nautilus-list@gnome.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
Message-Id: <20040511221745.7b0fe8f3.sfr@canb.auug.org.au>
In-Reply-To: <1084276364.4081.63.camel@lilota.lamp.priv>
References: <1084152941.22837.21.camel@vertex>
	<20040510021141.GA10760@taniwha.stupidest.org>
	<1084227460.28663.8.camel@vertex>
	<20040511024701.GA19489@taniwha.stupidest.org>
	<1084276364.4081.63.camel@lilota.lamp.priv>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__11_May_2004_22_17_45_+1000_DJmK+2DoPa9I911f"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__11_May_2004_22_17_45_+1000_DJmK+2DoPa9I911f
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 11 May 2004 13:52:44 +0200 nf <nf2@scheinwelt.at> wrote:
>
> I would even claim, that simple polling ("stat"-ing) the filesystem for
> changes is more efficient in 95% of the cases, than all this dnotify,
> fam, etc... stuff.

Not if you want power savings in your idle loop ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__11_May_2004_22_17_45_+1000_DJmK+2DoPa9I911f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoMRpFG47PeJeR58RAo5lAKDOGrN51r49XPWb2Wf1R8A9wXwzpwCgtmcy
nf6YzUqCYp2X0puxv3cPW+g=
=y6nA
-----END PGP SIGNATURE-----

--Signature=_Tue__11_May_2004_22_17_45_+1000_DJmK+2DoPa9I911f--
