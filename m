Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTHWRAM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTHWQ6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:58:43 -0400
Received: from gate.in-addr.de ([212.8.193.158]:43422 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262623AbTHWP2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 11:28:44 -0400
Date: Sat, 23 Aug 2003 17:28:26 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: md: bug in file raid5.c, line 540 was: Re: Linux 2.4.22-rc1
Message-ID: <20030823152826.GB9239@marowsky-bree.de>
References: <Pine.LNX.4.44.0308051543130.12501-100000@logos.cnet> <20030819202629.GA4083@matchmail.com> <20030819210913.GC4083@matchmail.com> <16197.43294.828878.586018@gargle.gargle.HOWL> <20030822155039.GA6980@marowsky-bree.de> <20030822212659.GK1040@matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20030822212659.GK1040@matchmail.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2003-08-22T14:26:59,
   Mike Fedyk <mfedyk@matchmail.com> said:

> > I fixed that for multipath in 2.4 too, but I can't get around to clean
> > up the patchset *sigh*
> Then send the patch to someone who can...

I've repeatedly announced the updated patches at
ftp://ftp.suse.com/pub/people/lmb/md-mp/kernel/ in the past (though the
URL has varied slightly), so feel free to pick them up.

> Has anyone attempted to create a testbed for md?=20

I've done that for the multipath module. I've put my mp-test.sh at
ftp://ftp.suse.com/pub/people/lmb/md-mp/mp-test.sh, too. It comes
without any warranty or documentation besides the comments in the
script though ;-)

It has helped me tremenduously creating weird situations and making sure
the md module keeps track of all its associated gazillions of counters
'correctly'.


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
High Availability & Clustering		ever tried. ever failed. no matter.
SuSE Labs				try again. fail again. fail better.
Research & Development, SuSE Linux AG		-- Samuel Beckett


--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/R4gZudf3XQV4S2cRAte8AJ41RpBvhkWnb2FtJmNcXa1mhLG5jwCeOaMk
eQHuhl7kSvnjtqfe4Mh9nhk=
=DNNI
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
