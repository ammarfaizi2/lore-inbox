Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271304AbRHORK1>; Wed, 15 Aug 2001 13:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271305AbRHORKS>; Wed, 15 Aug 2001 13:10:18 -0400
Received: from dsl254-096-012.nyc1.dsl.speakeasy.net ([216.254.96.12]:64172
	"EHLO mercury.infiniconsys.com") by vger.kernel.org with ESMTP
	id <S271304AbRHORKK>; Wed, 15 Aug 2001 13:10:10 -0400
content-class: urn:content-classes:message
Subject: RE: Implications of PG_locked and reference count in page structures....
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C125AD.286A8074"
Date: Wed, 15 Aug 2001 13:10:18 -0400
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB0C4C92@mercury.infiniconsys.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Thread-Topic: Implications of PG_locked and reference count in page structures....
Thread-Index: AcElpMUs7eLbBDi8Rl+IGAz8ovov+AAB8v5A
From: "Heinz, Michael" <mheinz@infiniconsys.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <ignacio@openservices.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C125AD.286A8074
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for all the replies;=20

I am using the O'Reilly book - but I'm kind of stuck using the semantics
that the driver's original author used. The whole effort is so we can
experiment with some hardware rather than for final release, so we don't
want to spend too much effort reengineering anything we don't have to.

Heh. I missed the part in LDD that mentions kmalloc regions being
unpageable.=20

;->

--
"Oh, bother!" said the Borg. "We've assimilated Pooh!"
"Thanks for noticing." replied Eeyore.

mheinz@infiniconsys.com
=20

------_=_NextPart_001_01C125AD.286A8074
Content-Type: text/x-vcard;
	name="Heinz, Michael.vcf"
Content-Transfer-Encoding: base64
Content-Description: Heinz, Michael.vcf
Content-Disposition: attachment;
	filename="Heinz, Michael.vcf"

QkVHSU46VkNBUkQNClZFUlNJT046Mi4xDQpOOkhlaW56O01pY2hhZWwNCkZOOkhlaW56LCBNaWNo
YWVsDQpFTUFJTDtQUkVGO0lOVEVSTkVUOm1oZWluekBpbmZpbmljb25zeXMuY29tDQpSRVY6MjAw
MTA3MTFUMTkxNTM1Wg0KRU5EOlZDQVJEDQo=

------_=_NextPart_001_01C125AD.286A8074--
