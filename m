Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVCRDnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVCRDnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 22:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVCRDnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 22:43:32 -0500
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:51212 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261457AbVCRDmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 22:42:50 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
Organization: IBM LTC
To: linuxppc64-dev@ozlabs.org
Subject: Re: Why no bigphysarea in mainline?
Date: Fri, 18 Mar 2005 14:42:48 +1100
User-Agent: KMail/1.7.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200503172057.06570.michael@ellerman.id.au> <1111070132.19021.31.camel@localhost>
In-Reply-To: <1111070132.19021.31.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1640885.zgvatvuQzy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503181442.51830.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1640885.zgvatvuQzy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 18 Mar 2005 01:35, Dave Hansen wrote:
> Doing mem=3D for drivers isn't just a hack, it's *WRONG*.  It's a ticking
> time bomb that magically happens to work on some systems.  It will not
> work consistently on a discontiguous memory system, or a memory hotplug
> system.

I couldn't agree more. Problem is I've been asked to change the way mem=3DX=
=20
works on PPC64 so that this hack will work, which is a horrible thought.

> Could you give some examples of drivers which are in the kernel that
> could benefit from this patch?  We don't tend to put things like this
> in, unless they have actual users.  We don't tend to change code for
> out-of-tree users, either.

No I can't. I've been approached by several "vendors" asking about using me=
m=3DX=20
hacks on PPC64, however I doubt any of them have code in-tree. I'll check=20
though.

cheers

--nextPart1640885.zgvatvuQzy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCOk47dSjSd0sB4dIRAilNAJ9U6DP0kKOn0TtjgZGETOmBhH9FngCfUtSP
JXWE7LKWyfinz8WMOqF8Q6w=
=cNrA
-----END PGP SIGNATURE-----

--nextPart1640885.zgvatvuQzy--
