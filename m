Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269030AbUIXWsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbUIXWsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269031AbUIXWsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:48:42 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:42881 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S269030AbUIXWs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:48:26 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: mlock(1)
Date: Fri, 24 Sep 2004 15:48:19 -0700
User-Agent: KMail/1.7
Cc: Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <4154867F.7030108@nortelnetworks.com>
In-Reply-To: <4154867F.7030108@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1556630.JnaBRMxeCO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409241548.24971.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1556630.JnaBRMxeCO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 24 September 2004 13:41, Chris Friesen wrote:
> Chris Wright wrote:
> > 2. Problem is the execve(2) that the mlock(1) program would have to cal=
l.
> > This blows away the mappings which contain the locking info.
>
> Does it?  The man page said it isn't inherited on fork(), but why wouldn't
> it be inherited on exec()?
>
=46rom my mlock(2) manpage:
"...they are guaranteed to stay in RAM until the pages are unlocked by munl=
ock=20
or munlockall, until the pages are unmapped via munmap, or until the proces=
s=20
terminates or starts another program with exec."

=2DRyan

--nextPart1556630.JnaBRMxeCO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBVKQ4W4yVCW5p+qYRAkFvAJwKDMyvt21G9ZNJPHJtVM8KciNrOQCfV8Nd
Po+DmLOHAU75BiA23DVTgrQ=
=xnrc
-----END PGP SIGNATURE-----

--nextPart1556630.JnaBRMxeCO--
