Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267589AbUIFHxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267589AbUIFHxU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUIFHxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:53:14 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:18857 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267582AbUIFHw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:52:57 -0400
Date: Mon, 6 Sep 2004 09:45:18 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Spam <spam@tnonline.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040906074518.GA28697@thundrix.ch>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org> <1591214030.20040902215031@tnonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <1591214030.20040902215031@tnonline.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Thu, Sep 02, 2004 at 09:50:31PM +0200, Spam wrote:
> Their  libraries are  huge and  memory hogging  which so  many Linux
> users just do not like.

This  is rather  a  fud argument:  both  the gnome  VFS  code and  the
KIOserver/KIOslave  code aren't really  large. You  don't want  to use
them for a busybox/tinylogin system, however.

> What if  a user doesn't want  KDE or Gnome? Would  all files created
> with either be broken?

The files  still work well, just  that you can't access  them over the
old fancy URL schemes.

> I  doubt  that  something   like  file  streams  and  meta-data  can
> successfully be  implemented purely in  user-space and get  the same
> support (ie  be used by many  programs) if this  change doesn't come
> from the kernel. I just do not see it happen.

Actually,  practical  discordianism.  If  you develop  a  common  API,
there'll always be people disagreeing.

GTK+ with all  its features is just cool. Desktop  warping is a really
nice  thing. But  there are  people out  there who  don't want  to use
it. They use QT, or even plain old Athena Widgets. So what? Will we be
implementing the X toolkits into the kernel?

In case of marketing it's up to the distributions to provide something
concise  so  everyone  can  use  their  programs  through  a  coherent
namespace. (I.e. port all the apps they ship to gnome-vfs or kio).

			    Tonnerre

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPBWO/4bL7ovhw40RAjSWAKCq0mojqMrj5U0kywi5bJLuHvOsGwCeMgwn
/z2OnS7XcLu4Ecmo16PDcr4=
=BwD3
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
