Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVEJUg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVEJUg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVEJUgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:36:15 -0400
Received: from attila.bofh.it ([213.92.8.2]:44482 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261781AbVEJUcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:32:08 -0400
Date: Tue, 10 May 2005 22:31:56 +0200
To: Greg KH <gregkh@suse.de>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510203156.GA14979@wonderland.linux.it>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20050510201355.GB3226@suse.de>
User-Agent: Mutt/1.5.9i
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 10, Greg KH <gregkh@suse.de> wrote:

> > > Why not this or something similar (e.g. I want to blacklist the xxx a=
nd=20
> > > yyy modules)? (note, untested)
> Nice, I like it.
But it does not work.

> > Because it's impossible to predict how it will interact with other
> > install and alias commands.
> Then we will just have to find out :)
It should be clear that it will interact badly with another install
commands, with one of them being ignored. This is not acceptable.

> > A less fundamental but still major problem is that this would be a
> > different API, and both users and packages have been aware of
> > /etc/hotplug/blacklist* for a long time now.
> And as /etc/hotplug/* is going away for hotplug-ng, I don't think this
> is going to be an issue.  Also, the blacklisting stuff should not be
> that prevelant anymore...
It's a feature which I know my users and other maintainers need
(for duplicated drivers, OSS drivers, watchdog drivers, usb{mouse,kbd}
and so on) so it's a prerequisite for the successful packaging of
hotplug-ng.

--=20
ciao,
Marco

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgRo8FGfw2OHuP7ERArWNAJ9p4sv4NeO5hOs9bsn2YUKtOm05+wCeOUOS
xQzDY0pJhUpgjzvlIGlQ1dE=
=Bvqk
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
