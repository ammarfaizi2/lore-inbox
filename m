Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752169AbWJ0Mwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbWJ0Mwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 08:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbWJ0Mwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 08:52:30 -0400
Received: from cernmx04.cern.ch ([137.138.166.167]:5409 "EHLO cernmxlb.cern.ch")
	by vger.kernel.org with ESMTP id S1752169AbWJ0Mw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 08:52:29 -0400
Keywords: CERN SpamKiller Note: -51 Charset: west-latin
X-Filter: CERNMX04 CERN MX v2.0 060921.0942 Release
In-Reply-To: <1161901793.9087.110.camel@dv>
References: <1161807069.3441.33.camel@dv> <1161808227.7615.0.camel@localhost.localdomain> <20061025205923.828c620d.akpm@osdl.org> <1161859199.12781.7.camel@localhost.localdomain> <1161890340.9087.28.camel@dv>  <20061026214600.GL27968@stusta.de> <1161901793.9087.110.camel@dv>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-80--1037251960"
Message-Id: <B5254A8D-0E60-4C51-AF71-7F76F3B8B917@e18.physik.tu-muenchen.de>
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: incorrect taint of ndiswrapper
Date: Fri, 27 Oct 2006 14:52:21 +0200
To: Pavel Roskin <proski@gnu.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.2)
X-OriginalArrivalTime: 27 Oct 2006 12:52:27.0379 (UTC) FILETIME=[C19D4C30:01C6F9C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-80--1037251960
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hi Pavel!

On 27 Oct 2006, at 00:29, Pavel Roskin wrote:

>> EXPORT_SYMBOL_GPL shows a pretty clear intention, and offering
>> functionality provided throug h EXPORT_SYMBOL_GPL'ed symbols to
>> proprietary code sounds very fishy.
>
> Last time I checked, EXPORT_SYMBOL_GPL was an indication that a code
> using it will be considered as a work derived from Linux.  This way,
> ndiswrapper, which is free software, can be considered a derived work.
>
> NDIS drivers don't know about any Linux API, therefore they cannot use
> it directly.  The purpose of ndiswrapper is not to remove limitations
> from the Linux API, but to present a completely different API.
>
Maybe everyone would be more happy if this "completely different API"  
would live at lower priviledge level, e.g. ring 1, so it could not  
screw up kernel internals? Is this technically possible? Maybe it's  
the same thing, but another way could be to run NDIS stuff inside a  
xen-like virtual environment... Has anyone tried yet?

Ciao,
                     Roland

--
TU Muenchen, Physik-Department E18, James-Franck-Str., 85748 Garching
Telefon 089/289-12575; Telefax 089/289-12570
--
CERN office: 892-1-D23 phone: +41 22 7676540 mobile: +41 76 487 4482
--
Any society that would give up a little liberty to gain a little
security will deserve neither and lose both.  - Benjamin Franklin
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/CS/M/MU d-(++) s:+ a-> C+++ UL++++ P+++ L+++ E(+) W+ !N K- w--- M 
+ !V Y+
PGP++ t+(++) 5 R+ tv-- b+ DI++ e+++>++++ h---- y+++
------END GEEK CODE BLOCK------



--Apple-Mail-80--1037251960
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFFQgEJI4MWO8QIRP0RAskeAJ4hQoohvLAk9EENes1KwIkQjhMiyQCcCXuE
jQDKgFGEBlYcCCHXoP7nA7o=
=xlhs
-----END PGP SIGNATURE-----

--Apple-Mail-80--1037251960--
