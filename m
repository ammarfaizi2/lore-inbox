Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUIOOLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUIOOLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUIOOI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:08:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12967 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266173AbUIONb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:31:59 -0400
Date: Wed, 15 Sep 2004 15:31:44 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] tune vmalloc size
Message-ID: <20040915133144.GB30530@devserv.devel.redhat.com>
References: <20040915125356.GA11250@elte.hu> <20040915132936.GB30233@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <20040915132936.GB30233@tsunami.ccur.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 15, 2004 at 09:29:36AM -0400, Joe Korty wrote:
> On Wed, Sep 15, 2004 at 02:53:56PM +0200, Ingo Molnar wrote:
> > 
> > there are a few devices that use lots of ioremap space. vmalloc space is
> > a showstopper problem for them.
> > 
> > this patch adds the vmalloc=<size> boot parameter to override
> > __VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
> > doubles the size.
> 
> Perhaps this should instead be a configurable.

boot time settable is 100x better than only compile time settable imo :)

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBSEQ/xULwo51rQBIRAq3SAJ9sYjRXZnU47K3v+VWPH+4+LwPJFACeIEeL
tjAwUdClFfkOlmCe2/s9vwE=
=PpHn
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
