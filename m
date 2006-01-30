Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWA3LCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWA3LCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWA3LCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:02:31 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:8684 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932211AbWA3LCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:02:31 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] pid: Don't hash pid 0.
Date: Mon, 30 Jan 2006 19:58:18 +1000
User-Agent: KMail/1.9.1
Cc: Yuki Cuss <celtic@sairyx.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m1ek2rfsu9.fsf@ebiederm.dsl.xmission.com> <43DDE009.9090104@sairyx.org> <Pine.LNX.4.61.0601301047200.6405@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601301047200.6405@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1781123.WFcMYkhPLk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601301958.24047.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1781123.WFcMYkhPLk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

On Monday 30 January 2006 19:49, Jan Engelhardt wrote:
> >> How about nr==0, it would make it more obvious.
> >
> > I am inclined to agree. `!nr' seems to imply some sort of an error
> > condition;
>
> ! seems to imply a boolean usually. (If this was Java, this would even
> be enforced.)

If this was Java! Thank goodness it's not :>

Nigel

> However, !x (and x) is scattered all around the kernel where
> x==0,x!=0 (or x==NULL,x!=NULL) would be more readable.
>
> > perhaps a comment could be placed in order to make why the case of (nr ==
> > 0) is being ignored.
> >
> > - Yuki.
>
> Jan Engelhardt

--nextPart1781123.WFcMYkhPLk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD3eNAN0y+n1M3mo0RAvTHAJwKN8LYovK1CnFhhrYluqUIqR+i7QCgxS0L
QlKMUwaQ7LTp1YumRaynORA=
=QeYR
-----END PGP SIGNATURE-----

--nextPart1781123.WFcMYkhPLk--
