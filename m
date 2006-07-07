Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWGGBoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWGGBoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 21:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWGGBoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 21:44:32 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:51000 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750827AbWGGBob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 21:44:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=n4Es/vvjvkVBptuR8FZhul/OFaHmYQiRdYo9JRYqj7DVWlKI/L43dWOj7fFXWHP/7HhTFoyoAlvL04V0rs56GF9q+a5rqNBmYfBAybNnaee7KFE6b9Px6kR23sXBRl9bCU3vQ02ck/9yg5G6r60KMPHQ+/Nx1CqtL80WsACIghU=
Date: Thu, 6 Jul 2006 21:44:28 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Integrate asus_acpi LED's with new LED subsystem
Message-ID: <20060707014428.GC8900@phoenix>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20060706193157.GC14043@phoenix> <20060706235020.GA4821@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <20060706235020.GA4821@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On July 06 at 19:50 EDT, Pavel Machek hastily scribbled:
> Apart from codingstyle issues...

I've fixed a bunch that Andrew Morton and Richard Purdie mentioned
(since your message, I've posted a new revision).  Are there any changes
I missed?

> yes, it looks good.

Nice. :-)

> Hooking various
> leds into led subsystem is way better than having all the separate
> drivers.

Yes.  The LED subsystem is a really cool idea, because what good are
blinkenlights if you have to write shell scripts to control them?  The
kernel should do that for you!  (/me wishes someone made a laptop with
something like 8 LED's of different colors, so he could just make them
do what he liked.)

> I guess I'll have to convert ibm_acpi...

I'm willing to take a first whack at it, if you can put me in touch with
someone to test it.

--Thomas Tuttle

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFErbx8/UG6u69REsYRAtUfAJ9zRCQ5FK/fGbvmskAcMPzVLi2FZwCdFq2e
VId2GmeOAcIZDPPZRB9Uw8o=
=Mnep
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
