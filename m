Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUCMPez (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 10:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbUCMPey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 10:34:54 -0500
Received: from colino.net ([62.212.100.143]:22007 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S263107AbUCMPev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 10:34:51 -0500
Date: Sat, 13 Mar 2004 16:33:34 +0100
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] therm_adt7467 update
Message-Id: <20040313163334.3a3ad9c0@jack.colino.net>
In-Reply-To: <1079045140.9745.295.camel@gaston>
References: <00e401c40776$2a37eca0$3cc8a8c0@epro.dom>
	<1079045140.9745.295.camel@gaston>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__13_Mar_2004_16_33_34_+0100_b7EP7KM9XIL=A1NF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__13_Mar_2004_16_33_34_+0100_b7EP7KM9XIL=A1NF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 12 Mar 2004 at 09h03, Benjamin Herrenschmidt wrote:

Hi, 

> > Here's a patch that renames the file to therm_adt746x.c and updates
> > Kconfig and Makefile. I also changed a few lines in therm_adt746x.c after
> > renaming it (the patch contains these), the diff is here for clarity:
> 
> Ok, I'll look into getting that upstream. Renaming things is a bit
> nasty (makes big patch for little changes) unless Linus does
> directly a "bk mv" in his tree..

Ok, that's what I thought. 
Would it help if I sent a simpler patch with the modifications to 
therm_adt7467.c, Kconfig and Makefile, and specify to `bk mv` the file after
applying the patch ?

Just in case, here it is. 
Don't forget to rename drivers/macintosh/therm_adt7467.c to 
therm_adt746x.c after :-)

-- 
Colin

--Multipart=_Sat__13_Mar_2004_16_33_34_+0100_b7EP7KM9XIL=A1NF
Content-Type: application/octet-stream;
 name="746x.2.patch"
Content-Disposition: attachment;
 filename="746x.2.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtdSBkcml2ZXJzL21hY2ludG9zaC9LY29uZmlnIGRyaXZlcnMvbWFjaW50b3NoLm5ldy9L
Y29uZmlnCi0tLSBkcml2ZXJzL21hY2ludG9zaC9LY29uZmlnCTIwMDQtMDMtMTEgMDM6NTU6MjYu
MDAwMDAwMDAwICswMTAwCisrKyBkcml2ZXJzL21hY2ludG9zaC5uZXcvS2NvbmZpZwkyMDA0LTAz
LTEzIDE2OjMwOjI5LjE3MjYwMjExMiArMDEwMApAQCAtMTc0LDggKzE3NCw4IEBACiAJICBUaGlz
IGRyaXZlciBwcm92aWRlcyBzb21lIHRoZXJtb3N0YXQgYW5kIGZhbiBjb250cm9sIGZvciB0aGUg
ZGVza3RvcAogCSAgRzQgIldpbmR0dW5uZWwiCiAKLWNvbmZpZyBUSEVSTV9BRFQ3NDY3Ci0JdHJp
c3RhdGUgIlN1cHBvcnQgZm9yIHRoZXJtYWwgbWdtbnQgb24gbGFwdG9wcyB3aXRoIEFEVCA3NDY3
IGNoaXBzZXQiCitjb25maWcgVEhFUk1fQURUNzQ2WAorCXRyaXN0YXRlICJTdXBwb3J0IGZvciB0
aGVybWFsIG1nbW50IG9uIGxhcHRvcHMgd2l0aCBBRFQgNzQ2eCBjaGlwc2V0IgogCWRlcGVuZHMg
b24gSTJDICYmIEkyQ19LRVlXRVNUICYmIFBQQ19QTUFDICYmICFQUENfUE1BQzY0CiAJaGVscAog
CSAgVGhpcyBkcml2ZXIgcHJvdmlkZXMgc29tZSB0aGVybW9zdGF0IGFuZCBmYW4gY29udHJvbCBm
b3IgdGhlCmRpZmYgLXUgZHJpdmVycy9tYWNpbnRvc2gvTWFrZWZpbGUgZHJpdmVycy9tYWNpbnRv
c2gubmV3L01ha2VmaWxlCi0tLSBkcml2ZXJzL21hY2ludG9zaC9NYWtlZmlsZQkyMDA0LTAzLTEx
IDAzOjU1OjQ0LjAwMDAwMDAwMCArMDEwMAorKysgZHJpdmVycy9tYWNpbnRvc2gubmV3L01ha2Vm
aWxlCTIwMDQtMDMtMTMgMTY6MzA6MzUuNzM5NjAzNzc2ICswMTAwCkBAIC0yNSw0ICsyNSw0IEBA
CiAKIG9iai0kKENPTkZJR19USEVSTV9QTTcyKQkrPSB0aGVybV9wbTcyLm8KIG9iai0kKENPTkZJ
R19USEVSTV9XSU5EVFVOTkVMKQkrPSB0aGVybV93aW5kdHVubmVsLm8KLW9iai0kKENPTkZJR19U
SEVSTV9BRFQ3NDY3KQkrPSB0aGVybV9hZHQ3NDY3Lm8KK29iai0kKENPTkZJR19USEVSTV9BRFQ3
NDZYKQkrPSB0aGVybV9hZHQ3NDZ4Lm8KZGlmZiAtdSBkcml2ZXJzL21hY2ludG9zaC90aGVybV9h
ZHQ3NDY3LmMgZHJpdmVycy9tYWNpbnRvc2gubmV3L3RoZXJtX2FkdDc0NjcuYwotLS0gZHJpdmVy
cy9tYWNpbnRvc2gvdGhlcm1fYWR0NzQ2Ny5jCTIwMDQtMDMtMTEgMDM6NTU6MzcuMDAwMDAwMDAw
ICswMTAwCisrKyBkcml2ZXJzL21hY2ludG9zaC5uZXcvdGhlcm1fYWR0NzQ2Ny5jCTIwMDQtMDMt
MTMgMTY6MzE6MjcuMTY0Nzg1OTYwICswMTAwCkBAIC00OSw3ICs0OSw3IEBACiBzdGF0aWMgaW50
IGZhbl9zcGVlZCA9IC0xOwogCiBNT0RVTEVfQVVUSE9SKCJDb2xpbiBMZXJveSA8Y29saW5AY29s
aW5vLm5ldD4iKTsKLU1PRFVMRV9ERVNDUklQVElPTigiRHJpdmVyIGZvciBBRFQ3NDY3IHRoZXJt
b3N0YXQgaW4gaUJvb2sgRzQiKTsKK01PRFVMRV9ERVNDUklQVElPTigiRHJpdmVyIGZvciBBRFQ3
NDZ4IHRoZXJtb3N0YXQgaW4gaUJvb2sgRzQgYW5kIFBvd2VyYm9vayBHNCBBbHUiKTsKIE1PRFVM
RV9MSUNFTlNFKCJHUEwiKTsKIAogTU9EVUxFX1BBUk0obGltaXRfYWRqdXN0LCJpIik7CkBAIC0x
NjEsNyArMTYxLDcgQEAKIH0KIAogc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIHRoZXJtb3N0YXRf
ZHJpdmVyID0geyAgCi0JLm5hbWUJCT0iQXBwbGUgVGhlcm1vc3RhdCBBRFQ3NDY3IiwKKwkubmFt
ZQkJPSJBcHBsZSBUaGVybW9zdGF0IEFEVDc0NngiLAogCS5pZAkJPTB4REVBRDc0NjcsCiAJLmZs
YWdzCQk9STJDX0RGX05PVElGWSwKIAkuYXR0YWNoX2FkYXB0ZXIJPSZhdHRhY2hfdGhlcm1vc3Rh
dCwK

--Multipart=_Sat__13_Mar_2004_16_33_34_+0100_b7EP7KM9XIL=A1NF--
