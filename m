Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbTJUAo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbTJUAo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:44:26 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:21943 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262989AbTJUAoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:44:19 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.0-test8-mm1
Date: Tue, 21 Oct 2003 02:43:57 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031020020558.16d2a776.akpm@osdl.org> <20031020151713.149bba88.akpm@osdl.org> <200310210030.41121.schlicht@uni-mannheim.de>
In-Reply-To: <200310210030.41121.schlicht@uni-mannheim.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_UFIl/+fbKpA9LXp";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310210244.04481.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_UFIl/+fbKpA9LXp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 21 October 2003 00:30, I wrote:
> On Tuesday 21 October 2003 00:17, Andrew Mortonwrote:
> > Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
> > > On Monday 20 October 2003 23:48, Andrew Morton wrote:
> > > > A colleague here has discovered that this crash is repeatable, but
> > > > goes away when the radeon driver is disabled.
> > > >
> > > > Are you using that driver?
> > >
> > > No, I'm not... I use the vesafb driver. Do you think disabling this
> > > could cure the Oops?
> >
> > It might.  Could you test it please?
>
> I will, but currently I compile 2.6.0-test8. I want to try if this works...
> I also want to try test8-mm1 without the -Os patch, you never know... ;-)

OK, 2.6.0-test8 worked, 2.6.0-test8-mm1 without any FB support, too!!
So I didn't test reverting the -Os patch...

> > There's nothing in -mm which touches the inode list management code, so a
> > random scribble or misbehaving driver is likely.
>
> Yes, or some part of the kernel compiled false...
> (After some problems with erlier gcc's I don't trust my curent 3.3.1 that
> much...)

It seems my gcc 3.3.1 works the way it should... ;-)

--Boundary-02=_UFIl/+fbKpA9LXp
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/lIFUYAiN+WRIZzQRAmaGAJ4qLA3r2xiA880khujeiiF4OQ1XUQCgoYRM
lYaKmbWCzsc5s8rtUloQ+wE=
=QHJW
-----END PGP SIGNATURE-----

--Boundary-02=_UFIl/+fbKpA9LXp--
