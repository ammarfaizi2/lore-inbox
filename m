Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUEWJOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUEWJOX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUEWJOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:14:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55204 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262434AbUEWJOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:14:07 -0400
Date: Sun, 23 May 2004 11:13:56 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
Message-ID: <20040523091356.GD5889@devserv.devel.redhat.com>
References: <20040522234059.GA3735@infradead.org> <1085296400.2781.2.camel@laptop.fenrus.com> <20040523084415.GB16071@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <20040523084415.GB16071@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 23, 2004 at 10:44:15AM +0200, Willy Tarreau wrote:
> Hi Arjan,
> 
> On Sun, May 23, 2004 at 09:13:20AM +0200, Arjan van de Ven wrote:
> > on first look it seems to be missing a bunch of get_user() calls and
> > does direct access instead....
> 
> It was intentional for speed purpose. The areas are checked once with
> verify_area() when we need to access memory, then data is copied directly
> from/to memory. I don't think there's any risk, but I can be wrong.

it's an oopsable offence; nothing is making sure the memory is actually
present for example.

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAsGtUxULwo51rQBIRAvg/AJ47wL3Tg9qQ+wdqN0y8EMNoP1g6kgCfdQ8D
Wy9Sy4g9yzttsfTeqsQH1XU=
=wN48
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
