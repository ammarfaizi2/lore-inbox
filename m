Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264263AbUEDH7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264263AbUEDH7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 03:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUEDH7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 03:59:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7911 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264263AbUEDH7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 03:59:18 -0400
Date: Tue, 4 May 2004 09:55:55 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: davidm@hpl.hp.com
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       bunk@fs.tum.de, eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-ID: <20040504075555.GB13287@devserv.devel.redhat.com>
References: <20040501201342.GL2541@fs.tum.de> <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org> <20040501161035.67205a1f.akpm@osdl.org> <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org> <20040501175134.243b389c.akpm@osdl.org> <16534.35355.671554.321611@napali.hpl.hp.com> <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org> <16534.45589.62353.878714@napali.hpl.hp.com> <1083618424.3843.12.camel@laptop.fenrus.com> <16534.51724.578183.845357@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <16534.51724.578183.845357@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 03, 2004 at 03:39:08PM -0700, David Mosberger wrote:
> >>>>> On Mon, 03 May 2004 23:07:04 +0200, Arjan van de Ven <arjanv@redhat.com> said:
> 
>   Arjan> Exporting sys_mlock() for a kernel module soooo sounds wrong
>   Arjan> to me
> 
> On what grounds?  What alternative are you suggesting?

if the module wants to pin userspace pages there are plenty of alternatives.
Heck I suspect what they want is to mmap a device like most V4L drivers do,
instead of doing it the windows way (let the app malloc and then pin)
--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAl0yKxULwo51rQBIRAjJdAJ0QVlMkKccqMf5Wq2BjA6Wps33w2ACghDom
1skSYxF+eXUJ8zKfZuceu7s=
=tgwt
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
