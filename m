Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUBJUog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266184AbUBJUog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:44:36 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:53123 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266175AbUBJUod (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:44:33 -0500
Message-Id: <200402102044.i1AKiDjR016511@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Mike Bell <kernel@mikebell.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user 
In-Reply-To: Your message of "Tue, 10 Feb 2004 11:24:57 PST."
             <20040210192456.GB4814@tinyvaio.nome.ca> 
From: Valdis.Kletnieks@vt.edu
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com>
            <20040210192456.GB4814@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-971329618P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Feb 2004 15:44:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-971329618P
Content-Type: text/plain; charset=us-ascii

On Tue, 10 Feb 2004 11:24:57 PST, Mike Bell said:

> I think the space savings are a pretty good reason alone. Add to that
> the fact I think devfs would be a good idea even if it cost MORE
> memory... You can mount a devfs on your RO root instead of needing to
> mount a tmpfs on /dev and then run udev on that.

(As an aside, the original reason I started using devfs was because it created
a separate /dev filesystem, and / can be mounted 'nodev'.  But I don't have any
religious preference for mounting devfs-by-kernel or tmpfs-from-initrd).

On the flip side, udev gives me something that devfs *cant* without major
hacking - the ability to attach extended attributes/labels to the device when
it gets created, so things like SELinux can deal with them. (OK, so I admit I'm
still sorting out how to use the SElinux transition SID support for tmpfs ;)



--==_Exmh_-971329618P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAKUKccC3lWbTT17ARAtruAJwI4B0I1lpqdy+vV4EgJnGXckGQKACgv64T
dC74fpThPWEi0aQJB1ylkDg=
=47Tp
-----END PGP SIGNATURE-----

--==_Exmh_-971329618P--
