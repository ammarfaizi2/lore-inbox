Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264972AbUD2V1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264972AbUD2V1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264853AbUD2VYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:24:38 -0400
Received: from lists.us.dell.com ([143.166.224.162]:62848 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264870AbUD2VYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:24:06 -0400
Date: Thu, 29 Apr 2004 16:19:30 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>, akpm@osdl.org,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/3] efivars driver update and move
Message-ID: <20040429211930.GC15106@lists.us.dell.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEAB3@fmsmsx406.fm.intel.com> <1083268253.8416.100.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <1083268253.8416.100.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 29, 2004 at 01:50:54PM -0600, Alex Williamson wrote:
> # stat BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c\ /
>   File: `BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c /'

FWIW, my Intel Tiger2-based system doesn't have the space at the end...

>         *(short_name + strlen(short_name)) =3D '-';
>         efi_guid_unparse(vendor_guid, short_name + strlen(short_name));
>         *(short_name + strlen(short_name)) =3D ' ';

even though looking at this I would have expected it to...

Can you remove that last line and see what it does?  Best as I can
tell, it isn't necessary or desired.

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAkXFiIavu95Lw/AkRAuLhAJ9EMcgAuxZ+OMgqf5f2bMt1FHYBjACfRsJd
AUHRI8EORk+Utka3OFnP2uM=
=Q3HN
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
