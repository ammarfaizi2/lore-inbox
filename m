Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUDNShM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 14:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUDNShL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 14:37:11 -0400
Received: from ns.suse.de ([195.135.220.2]:4228 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261580AbUDNShE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 14:37:04 -0400
Date: Wed, 14 Apr 2004 20:35:02 +0200
From: Kurt Garloff <garloff@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: RE: Non-Exec stack patches
Message-ID: <20040414183502.GR16701@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"Siddha, Suresh B" <suresh.b.siddha@intel.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	mingo@redhat.com
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TMgB3/Ch1aWgZB1L"
Content-Disposition: inline
In-Reply-To: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
X-Operating-System: Linux 2.6.5-2-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TMgB3/Ch1aWgZB1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2004 at 12:28:24AM -0700, Suresh B Siddha wrote:
> Recent ia64 mm trees are broken because of this issue. Attached patch=20
> fixes protection_map[7] in IA64.

Ah, sorry. ia64 seems to be strangely different here.
My understanding is that it support NX page protection. And that you
don't have executable stacks in the ia64 ABI at all. But for i386
emulation you should be able to enable and disable executable stacks.
For some reason the needed defines are missing ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--TMgB3/Ch1aWgZB1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfYRWxmLh6hyYd04RAqoqAKCRmqPG0/vXyrY4fiezY7EEcwyB/wCcCT1w
3086TbEw4Z9py4Pk4C2wWDw=
=VDw2
-----END PGP SIGNATURE-----

--TMgB3/Ch1aWgZB1L--
