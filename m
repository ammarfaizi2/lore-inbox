Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVGHLUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVGHLUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVGHLSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:18:33 -0400
Received: from sipsolutions.net ([66.160.135.76]:19474 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S262536AbVGHLSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:18:17 -0400
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
From: Johannes Berg <johannes@sipsolutions.net>
To: Stelian Pop <stelian@popies.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
In-Reply-To: <20050708101731.GM18608@sd291.sivit.org>
References: <20050708101731.GM18608@sd291.sivit.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RxgiUIffS/+3CdiHo1O5"
Date: Fri, 08 Jul 2005 13:18:01 +0200
Message-Id: <1120821481.5065.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RxgiUIffS/+3CdiHo1O5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

Nice to see this going into the kernel :)

> This is a driver for the USB touchpad which can be found on
> post-February 2005 Apple PowerBooks (PowerBook5,6).

This is not perfectly correct, the PowerBook5,6 is afaik only the 15"
model, the 12" and 17" have other numbers. Maybe you should just leave
that out, likewise in the code/Kconfig file.
> +/*
> + * number of sensors. Note that only 16 of the 26 x sensors are used on
> + * 12" and 15" Powerbooks.
> + */

I think that is misleading, those sensors don't even exist on 12" and
15" powerbooks. Maybe it should say 'Note that only 16 instead of 26
sensors exist on 12" and 15" models'

johannes

--=-RxgiUIffS/+3CdiHo1O5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQs5g56Vg1VMiehFYAQLizQ/+I9pYTJxbJaYS4chX2i3MV9UXGIMYH3r5
IUa2wOd2W75LfSejN++37hS81znB2fJ7EuiO3Gl8G637k2+w0o1z5MnkJS5csiHW
RqPpfyVMBVELWVPJEoXJ7eIvtIF1ps0daJvbZvQkB3B85XiPmITkrt958jc82eKr
iMPkXbb0iEEKePvRa3mcKI73n2NZ1REMLBlSOMjoW1OkMJwozZLv1iP+iqXfLLAB
5JJqASxUCnwZhbW/AjxYCiOBUE240m7MSEKklIINgPoxx1riqQthmQyI7clf9xTF
phzAA89GoS4zQce9mqcpdp0h02bpwuMwLKjjdTeVrzr/JuBfd3qj6WGSL89izwCd
n5VNuFjo4EL85ksQPzb3aBK3qe0bh0MTtV6JKNE7RQMfA0YyxonBianJfnygFFZG
SxZTljd04B8oQa7k2blD40BKBb2WVm0dEfH0i/VuklJng+QxlypQi+Q5n0lG44M8
WaVxNcKYgimMNln+8aZpxSoh4rxn53rzYpqiFi/IRIAT4LmHzyOSp6iOYUwjb262
c/M1p6ZZvagOSAIuZzwhHynlXrvG2SV1nkCBPhAHcF8yK/20HL+BndPXomB8cd91
yOhw4o6ohe1d1QgN1trf9g9UrmVczgUjsEUULW+/D2QPRer2YiAGd7la+C9YsTuX
ocq+BIMsUto=
=4Ajg
-----END PGP SIGNATURE-----

--=-RxgiUIffS/+3CdiHo1O5--

