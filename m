Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbUB0H0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 02:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUB0H0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 02:26:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44780 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261762AbUB0H0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 02:26:06 -0500
Date: Fri, 27 Feb 2004 08:25:51 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Mark Gross <mgross@linux.co.intel.com>, Tim Bird <tim.bird@am.sony.com>,
       root@chaos.analogic.com, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why no interrupt priorities?
Message-ID: <20040227072551.GB5695@devserv.devel.redhat.com>
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, Feb 26, 2004 at 05:36:34PM -0800, Grover, Andrew wrote:
> Is the assumption that hardirq handlers are superfast also the reason
> why Linux calls all handlers on a shared interrupt, even if the first
> handler reports it was for its device?

I guess so; and in addition it may avoid future irq's in a NAPI like way :)
Or it's just plain dead silly :)

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAPvD+xULwo51rQBIRAnCdAJ4pDB+Zgq13yitMYie3orVfTWUI6gCgqLQw
AVa8N4ggziRyw+dexBiFCFs=
=h0D8
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
