Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUDGO1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbUDGO1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:27:42 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:9875 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S263679AbUDGO0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:26:03 -0400
Date: Wed, 7 Apr 2004 16:26:01 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_4KSTACKS in mm2?
Message-Id: <20040407162601.4f18ae0f@phoebee>
In-Reply-To: <20040407140346.GC32088@charite.de>
References: <20040407135551.GA32088@charite.de>
	<Pine.LNX.4.58.0404071000340.16677@montezuma.fsmlabs.com>
	<20040407140346.GC32088@charite.de>
X-Mailer: Sylpheed version 0.9.10claws42 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__7_Apr_2004_16_26_01_+0200_1IaW1rPI54B513GU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__7_Apr_2004_16_26_01_+0200_1IaW1rPI54B513GU
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__7_Apr_2004_16_26_01_+0200_eipL1c7s2fe3IEyc"


--Multipart=_Wed__7_Apr_2004_16_26_01_+0200_eipL1c7s2fe3IEyc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 7 Apr 2004 16:03:47 +0200
Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> bubbled:

> * Zwane Mwaikambo <zwane@linuxpower.ca>:
> 
> > > Is there a way of disabling CONFIG_4KSTACKS in 2.6.5-mm2?
> > > Or to make it configurable?
> > 
> > "arch/i386/Kconfig" line 1498 of 1542 --97%-- col 8
> > config 4KSTACKS
> >         def_bool y
> > 
> > you could just change that to 'n'
> 
> That's what I did (and it works) -- but it's not really intuitive or
> even configurable (in the way of menuconfig or something).
> 

here is the patch to reenable the menu config option ...

-- 
MyExcuse:
What office are you in? Oh, that one.  Did you know that your building was built
over the universities first nuclear research site? And wow, aren't you the lucky
one, your office is right over where the core is buried!

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Multipart=_Wed__7_Apr_2004_16_26_01_+0200_eipL1c7s2fe3IEyc
Content-Type: application/octet-stream;
 name="mm-4k-reenable.patch"
Content-Disposition: attachment;
 filename="mm-4k-reenable.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtTmF1cnAgbGludXgtMi42LjUtcmMxLW1tMS9hcmNoL2kzODYvS2NvbmZpZyBsaW51eC0y
LjYuNS1yYzEtbW0xLXJlbW92ZWQvYXJjaC9pMzg2L0tjb25maWcKLS0tIGxpbnV4LTIuNi41LXJj
MS1tbTEvYXJjaC9pMzg2L0tjb25maWcJMjAwNC0wMy0xNiAyMToyODowMy4wMDAwMDAwMDAgKzAx
MDAKKysrIGxpbnV4LTIuNi41LXJjMS1tbTEtcmVtb3ZlZC9hcmNoL2kzODYvS2NvbmZpZwkyMDA0
LTAzLTE2IDIxOjMyOjA4LjAwMDAwMDAwMCArMDEwMApAQCAtMTU1NSw3ICsxNTU1LDE0IEBAIGNv
bmZpZyBNQUdJQ19TWVNSUQogCWRlZmF1bHQgeQogCiBjb25maWcgNEtTVEFDS1MKLQlkZWZfYm9v
bCB5CisJYm9vbCAiVXNlIDRLYiBmb3Iga2VybmVsIHN0YWNrcyBpbnN0ZWFkIG9mIDhLYiIKKwlk
ZWZhdWx0IG4KKwloZWxwCisJICBJZiB5b3Ugc2F5IFkgaGVyZSB0aGUga2VybmVsIHdpbGwgdXNl
IGEgNEtiIHN0YWNrc2l6ZSBmb3IgdGhlCisJICBrZXJuZWwgc3RhY2sgYXR0YWNoZWQgdG8gZWFj
aCBwcm9jZXNzL3RocmVhZC4gVGhpcyBmYWNpbGl0YXRlcworCSAgcnVubmluZyBtb3JlIHRocmVh
ZHMgb24gYSBzeXN0ZW0gYW5kIGFsc28gcmVkdWNlcyB0aGUgcHJlc3N1cmUKKwkgIG9uIHRoZSBW
TSBzdWJzeXN0ZW0gZm9yIGhpZ2hlciBvcmRlciBhbGxvY2F0aW9ucy4gVGhpcyBvcHRpb24KKwkg
IHdpbGwgYWxzbyB1c2UgSVJRIHN0YWNrcyB0byBjb21wZW5zYXRlIGZvciB0aGUgcmVkdWNlZCBz
dGFja3NwYWNlLgogCiBjb25maWcgWDg2X0ZJTkRfU01QX0NPTkZJRwogCWJvb2wKCg==

--Multipart=_Wed__7_Apr_2004_16_26_01_+0200_eipL1c7s2fe3IEyc--

--Signature=_Wed__7_Apr_2004_16_26_01_+0200_1IaW1rPI54B513GU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAdA95mjLYGS7fcG0RArtgAKCkHHrv+ZN6OJOsxBXs4oVSIW+F+gCgmYhM
8N7FEE1QgZqPwD/foEIv41Y=
=+jQn
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Apr_2004_16_26_01_+0200_1IaW1rPI54B513GU--
