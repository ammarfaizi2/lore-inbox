Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264893AbUE0RMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUE0RMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbUE0RMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:12:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30636 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264893AbUE0RMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:12:31 -0400
Date: Thu, 27 May 2004 19:12:19 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6] don't put IDE disks in standby mode on halt on Alpha
Message-ID: <20040527171219.GA17111@devserv.devel.redhat.com>
References: <20040527194920.A1709@jurassic.park.msu.ru> <1085675193.7179.5.camel@laptop.fenrus.com> <20040527211113.B2004@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20040527211113.B2004@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 27, 2004 at 09:11:13PM +0400, Ivan Kokshaysky wrote:
> On Thu, May 27, 2004 at 06:26:33PM +0200, Arjan van de Ven wrote:
> > how do you flush the disks' writecache then? Halting the disk seems to
> > be the only reliable way to do so.
> 
> Isn't ide_cacheflush_p() supposed to do that on modern drives?

that command seems to be optional to implement for drives unfortionately ;(

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAtiFyxULwo51rQBIRAuM/AKCPn3mJ4cfSj252PdcGkZHcZAVQMgCfXzpb
47s84xU7LJe99wpzEd/vHSI=
=C3KR
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
