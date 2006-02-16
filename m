Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWBPVaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWBPVaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWBPVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:30:55 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58006 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932089AbWBPVay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:30:54 -0500
X-Sasl-enc: wA0EaUilpyq/CJnyDcRE+MWqs/8JnGlTNGiZSXODLi0Z 1140125451
Message-ID: <43F4EEFE.2040905@imap.cc>
Date: Thu, 16 Feb 2006 22:30:38 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Hansjoerg Lipp <hjlipp@web.de>, Karsten Keil <kkeil@suse.de>,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] isdn4linux: Siemens Gigaset drivers - Kconfigs and
 Makefiles
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de> <20060215031959.GA5099@suse.de>
In-Reply-To: <20060215031959.GA5099@suse.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA2FD0C2DCD1727DDF91DB97C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA2FD0C2DCD1727DDF91DB97C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15.02.2006 04:19, Greg KH wrote:
> On Sat, Feb 11, 2006 at 03:52:27PM +0100, Hansjoerg Lipp wrote:
>=20
>>From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>
>>
>>This patch prepares the kernel build infrastructure for addition of the=

>>Gigaset ISDN drivers. It creates a Makefile and Kconfig file for the
>>Gigaset driver and hooks them into those of the isdn4linux subsystem.
>>It also adds a MAINTAINERS entry for the driver.
>>
>>This patch depends on patches 2 to 9 of the present set, as without the=

>>actual source files, activating the options added here will cause the
>>kernel build to fail.
>=20
> Care to redo that and add the Makefile change at the same time as the
> driver goes into the tree?  We don't want to break the buid for a
> specific patch.

I'm afraid I don't quite understand what you'd like us to do. Should we
resubmit the whole driver as a single patch? If so, how do we get it
past the lkml size limit, and how do we indicate that this replaces,
instead of going on top of, our 11 Feb 2006 submission in the -mm tree?
Alternatively, would it suffice to make sure that part 1 goes into the
tree after all the others? If so, how would we achieve that?

Also, I'm a bit unsure how this comment relates to the one by Andrew
Morton dated 12 Feb 2006 02:29:21 -0800 in which he writes:

> This means that the patches should go into git in a single commit, so t=
hat
> we don't have a non-compiling tree at any step.   That's not a problem.=


That seems to indicate that the problem is already being taken care of,
and if so, I'd certainly not want to interfere with that.

As to your other comments, they are well taken, and we are preparing a
patch against 2.6.16-rc3-mm1 which we'll submit as soon as the present
issue is sorted out.

Regards
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigA2FD0C2DCD1727DDF91DB97C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD9O8HMdB4Whm86/kRApqTAJ43tQ+cX8T3DYpc4gkIJo39JbOjEACePu+5
cF/2PU/iPgf4MCFqVKgkMDg=
=AtzA
-----END PGP SIGNATURE-----

--------------enigA2FD0C2DCD1727DDF91DB97C--
