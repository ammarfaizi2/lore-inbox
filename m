Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWBLQmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWBLQmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 11:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWBLQmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 11:42:24 -0500
Received: from smtpout05-04.prod.mesa1.secureserver.net ([64.202.165.221]:35491
	"HELO smtpout05-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1750708AbWBLQmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 11:42:23 -0500
From: hackmiester / Hunter Fuller <hackmiester@hackmiester.com>
Reply-To: hackmiester@hackmiester.com
Organization: hackmiester.com, Ltd.
To: Alon Bar-Lev <alon.barlev@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sun, 12 Feb 2006 10:42:07 -0600
User-Agent: KMail/1.8
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <B5780C33-81CE-4B8A-9583-B9B3973FCC11@mac.com> <43EEF711.2010409@gmail.com>
In-Reply-To: <43EEF711.2010409@gmail.com>
X-Face: #pm4uI.4%U/S1i<i'(UPkahbf^inZ;WOH{EKM,<n/P;R5m8#`2&`HN`hB;ht_>=?utf-8?q?oJYRGD3o=0A=09?=)AM
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4368979.01ohDnQSnk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602121042.16147.hackmiester@hackmiester.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4368979.01ohDnQSnk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 12 February 2006 02:51, Alon Bar-Lev wrote:
>
> Hello,
>
> I don't understand how a fundamental (good) debate of how
> suspend to disk should be implemented in kernel, changed
> into this one.
>
> I don't care what Linus said... Suspend-to-disk is more
> complicated than suspend-to-RAM. It is more complicated

And more useful in many cases... I'd just like to throw in here that when m=
y=20
battery has seven minutes left and I have a month's uptime... I suspend to=
=20
disk. I also presume that many people do this as well.

> since it provides more features. Suspend-to-RAM only stores
> state, where Suspend-to-disk need to store the state
> somewhere thus changing the initial state.
>
> There is a long list of features available at
> http://wiki.suspend2.net/FeatureUserRegister, which cannot
> be provided using suspend-to-RAM, examples:
> 1. Store state on files - this allow you to resume your
> machine into a different OS.
> 2. Encrypt state - this allow you to be sure that your data
> is stored encrypted. (Yes... You can encrypt the memory...
> but then you need a whole initramfs clone in order to allow
> the user to specify how he want to encrypt/decrypt).
> 3. Network resume - this allow you to resume a network
> machine (Not implemented yet, but cannot be done if
> suspend-to-RAM is the sole implementation).
> 4. Support desktops/servers - this allow you to
> suspend/resume hardware that is not designed to sleep, in
> order to minimize downtime on power failure.
>
> And another fact: Suspend-to-RAM implementation can be
> derived form suspend-to-disk but not the other way around.
>
> So let's invert the initial "fact"...
> Suspend-to-RAM is basically for people that don't need the
> full functionality of suspend-to-disk, after I got
> suspend-to-disk to work reliably here (suspend2), I *NEVER*
> use suspend-to-RAM.
>
> Best Regards,
> Alon Bar-Lev.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
=2D-hackmiester
If you can read this, you don't need glasses.

--nextPart4368979.01ohDnQSnk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD72Vo3ApzN91C7BcRAs1OAKDj6CCD2+f6Jr8UlPeGlnYCHjUkKgCghn3v
IujdY/ngoBgh0I8JtRRjCLE=
=QxkL
-----END PGP SIGNATURE-----

--nextPart4368979.01ohDnQSnk--
