Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269068AbUIQWNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269068AbUIQWNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUIQWKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:10:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17643 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269182AbUIQWGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:06:30 -0400
Date: Sat, 18 Sep 2004 00:06:13 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, kkeil@suse.de
Subject: Re: [patch] tune vmalloc size
Message-ID: <20040917220613.GA16920@devserv.devel.redhat.com>
References: <2EHyq-5or-39@gated-at.bofh.it> <m34qlzbqy6.fsf@averell.firstfloor.org> <1095257576.2698.4.camel@laptop.fenrus.com> <20040917220340.GA2890@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20040917220340.GA2890@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 17, 2004 at 03:03:40PM -0700, Chris Wedgwood wrote:
> On Wed, Sep 15, 2004 at 04:12:56PM +0200, Arjan van de Ven wrote:
> 
> > that is the case already
> 
> why do we still use 128MB as a default then?  this is way over-kill
> from what i can tell looking on what my machines use.  i'd rather have
> this be a bit smaller and enable the slab/whatever to grow a little
> more

if you have an old glibc it will use ldt's which in turn use vmalloc for
threading... 128Mb is no luxury there.


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBS1/UxULwo51rQBIRAvdpAKCroO0NkTlcVT0XwnzixBkRR8wWWQCfW7Wl
VGEFgCOuGnzAx6h+LVwLS2E=
=Yxn+
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
