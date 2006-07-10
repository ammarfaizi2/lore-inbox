Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWGJMq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWGJMq3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWGJMq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:46:29 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:60184 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030352AbWGJMq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:46:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=rKSnhlmg7+uD1X3vgdStpp+PA87cpkBh3cUhE1ahU8tjNlwNnwXYyEDXeLguTD1SneCAL0iNdlMeo04RRMl+AOhI2iE5Fyv/UA+HYbu6m1flFJkXBB4+qcpdLhRATqDkP9lOShgePYw19sJR7+QtvBfPo2xvVOFV/aBIhbvAJ6o=
Date: Mon, 10 Jul 2006 08:45:40 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060710124540.GA742@phoenix>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com> <1152377434.3120.69.camel@laptopd505.fenrus.org> <200607082125.12819.rjw@sisk.pl> <1152387552.3120.89.camel@laptopd505.fenrus.org> <44B219CC.4010409@zurich.ibm.com> <1152523109.4874.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <1152523109.4874.11.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

First, let me say, I've gotten both swsusp and suspend2 to work, but
I've had better luck with hardware under suspend2, and reading and
writing the image was faster under suspend2.

On July 10 at 05:18 EDT, Arjan van de Ven hastily scribbled:
> As I said... if that is the case then it'd be easy to first merge "the
> right basics", get that solid, and THEN add the features. So far I've
> not seen that happen.

So, you mean like merge just the freezer mods (if needed), and the
suspend2 core, and then add the encryption/compression/filewriter/userui
stuff separately?

That doesn't sound too unreasonable, if it's possible to separate them.

--Thomas Tuttle

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEskv0/UG6u69REsYRAuVPAJsGFluuaQcOWmTZ4qPmtex4Gts3YwCfb8JX
cvPYQCnxtRQtWAnOQPPCoBo=
=9H7x
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
