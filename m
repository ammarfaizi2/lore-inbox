Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTJUUhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTJUUhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:37:05 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:2736 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263336AbTJUUg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:36:57 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Helge Hafting <helgehaf@aitel.hist.no>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: 2.6.0-test8-mm1
Date: Tue, 21 Oct 2003 22:36:29 +0200
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031020185613.7d670975.akpm@osdl.org> <Pine.LNX.4.44.0310211846210.32738-100000@phoenix.infradead.org> <20031021202310.GA14993@hh.idb.hist.no>
In-Reply-To: <20031021202310.GA14993@hh.idb.hist.no>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_YjZl/Jtv1E9pek1";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310212236.41476.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_YjZl/Jtv1E9pek1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 21 October 2003 22:23, Helge Hafting wrote:
> On Tue, Oct 21, 2003 at 06:47:41PM +0100, James Simmons wrote:
> > Okay I see people are having alot of problems in the -mm tree. I don't
> > have any problems but I'm working against Linus tree. Could people try
> > the patch against 2.6.0-test8 and tell me if they still have the same
> > results.
>
> This patch was fine.  2.6.0-test8 with this patch booted and
> looked no different from plain 2.6.0-test8.  I am using it for
> writing this.  The problems must be in mm1 somehow.
>
> Helge Hafting

Well here I've got same problems for -test8 + fbdev-patch as with -test8-mm=
1.=20
I've compiled the kernel with most DEBUG_* options enabled (all but=20
DEBUG_INFO and KGDB) and see the same cursor and image corruption as with=20
=2Dmm1 and the same options enabled.

Should I try compiling this kernel without the DEBUG_* options and watch if=
 I=20
get the invalidate_list Oops again?

I use vesafb on a Nvidia GeForce 2 MX 440 with 64MB Video-RAM.

Regards
   Thomas

--Boundary-02=_YjZl/Jtv1E9pek1
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/lZjYYAiN+WRIZzQRArP6AKDS+v3MRHYCcF1RZZrWfzhVn4PtCQCfedlj
mzpldGtLWRRC1ZwzgrrNNlY=
=/dzU
-----END PGP SIGNATURE-----

--Boundary-02=_YjZl/Jtv1E9pek1--
