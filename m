Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268467AbUIJGlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268467AbUIJGlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUIJGlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:41:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9124 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268396AbUIJGki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:40:38 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20040909232532.GA13572@taniwha.stupidest.org>
References: <20040909232532.GA13572@taniwha.stupidest.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T3A3YYdY6MbE8lCGLHpK"
Organization: Red Hat UK
Message-Id: <1094798428.2800.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 08:40:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T3A3YYdY6MbE8lCGLHpK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-09-10 at 01:25, Chris Wedgwood wrote:
> Right now CONFIG_4KSTACKS implies IRQ-stacks.  Some people though
> really need 8K stacks and it would be nice to have IRQ-stacks for them
> too.

Well I always assumed the future plan was to remove 8k stacks entirely;
4k+irqstacks and 8k basically have near comparable stack space, with
this patch you create an option that has more but that is/should be
deprecated. I'm not convinced that's a good idea.


--=-T3A3YYdY6MbE8lCGLHpK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBQUxcxULwo51rQBIRAg8HAJ9cv4w83HkWGZpoNX5L8+gzIgaOiACfbU6a
rROQbOu0tANjEIArVk0snJY=
=sHLo
-----END PGP SIGNATURE-----

--=-T3A3YYdY6MbE8lCGLHpK--

