Return-Path: <linux-kernel-owner+w=401wt.eu-S932937AbWLTBzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932937AbWLTBzE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932943AbWLTBzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:55:04 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:36326 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932937AbWLTBzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:55:01 -0500
X-Greylist: delayed 1914 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 20:55:01 EST
Date: Wed, 20 Dec 2006 12:22:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Judith Lebzelter <judith@osdl.org>, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  powerpc iseries link error in allmodconfig
Message-Id: <20061220122249.d0c1f241.sfr@canb.auug.org.au>
In-Reply-To: <1166543839.25827.117.camel@pmac.infradead.org>
References: <20061108173429.GB14991@shell0.pdx.osdl.net>
	<1166543839.25827.117.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__20_Dec_2006_12_22_49_+1100_MiE+9lw1T9TujqJo"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__20_Dec_2006_12_22_49_+1100_MiE+9lw1T9TujqJo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2006 15:57:19 +0000 David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Wed, 2006-11-08 at 09:34 -0800, Judith Lebzelter wrote:
> > Choose rpa_vscsi.c over iseries_vscsi.c when building both
> > pseries and iseries.
>
> Would it not be better to make them both work instead?

The maintainer's take on this is the noone installs onto vscsi disks on
legacy iSeries.

> Untested-but-otherwise-Signed-off-by: David Woodhouse <dwmw2@infradead.org>

And that will, unfortunately, never get into 2.6.20.  I suggest that we
put the simpler patch into 2.6.20 and maybe revisit this afterwards if
we think it is worth the effort.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__20_Dec_2006_12_22_49_+1100_MiE+9lw1T9TujqJo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFiJBuFdBgD/zoJvwRAi12AJ0VkdEN0YmzdGjTxq3g2cIFRu7R4gCeL6HG
Efdbn0yJycHdCE5oI6vY094=
=ulBG
-----END PGP SIGNATURE-----

--Signature=_Wed__20_Dec_2006_12_22_49_+1100_MiE+9lw1T9TujqJo--
