Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUFWTzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUFWTzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUFWTzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:55:12 -0400
Received: from pop.gmx.de ([213.165.64.20]:32137 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266631AbUFWTzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:55:04 -0400
X-Authenticated: #20450766
Date: Wed, 23 Jun 2004 21:54:19 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [Bug 2905] New: Aironet 340 PCMCIA card not working since 2.6.7
In-Reply-To: <20040623132456.A27549@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.60.0406232149230.3950@poirot.grange>
References: <200406171753.i5HHrx38015816@fire-2.osdl.org>
 <Pine.LNX.4.60.0406172152310.5847@poirot.grange> <20040623132456.A27549@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1846257012-1088020459=:3950"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811839-1846257012-1088020459=:3950
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Wed, 23 Jun 2004, Russell King wrote:

> On Thu, Jun 17, 2004 at 09:58:32PM +0200, Guennadi Liakhovetski wrote:
>> Don't think it will help for this specific problem, but this patch fixes
>> alignment problem (especially seen on ARM, Russell:-)). Sending as a text
>> attachment, as my setup is known to mangle tabs...
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> Can you forward this to Jeff Garzik please?

Jeff, please, apply to 2.6. It should also go into 2.4, it is quite 
trivial and is actually a bugfix. Don't know if it will aply to 
2.4, if not, and if you prefer me to do it rather than do it yourself, I 
could rediff it against 2.4 too.

Thanks
Guennadi
---
Guennadi Liakhovetski

---1463811839-1846257012-1088020459=:3950
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="airo.c.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0406232154190.3950@poirot.grange>
Content-Description: 
Content-Disposition: attachment; filename="airo.c.patch"

ZGlmZiAtdSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Fpcm8uYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2Fpcm8uYw0KLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvYWlyby5jCTE5IE1heSAyMDA0IDE2OjA2OjM2DQorKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9haXJvLmMJMTcgSnVuIDIwMDQgMTk6NTA6NTYN
CkBAIC0zMTUxLDExICszMTUxLDEyIEBADQogCQkJfSBlbHNlDQogCQkJCWhk
cmxlbiA9IEVUSF9BTEVOICogMjsNCiANCi0JCQlza2IgPSBkZXZfYWxsb2Nf
c2tiKCBsZW4gKyBoZHJsZW4gKyAyICk7DQorCQkJc2tiID0gZGV2X2FsbG9j
X3NrYiggbGVuICsgaGRybGVuICsgMiArIDIgKTsNCiAJCQlpZiAoICFza2Ig
KSB7DQogCQkJCWFwcml2LT5zdGF0cy5yeF9kcm9wcGVkKys7DQogCQkJCWdv
dG8gYmFkcng7DQogCQkJfQ0KKwkJCXNrYl9yZXNlcnZlKHNrYiwgMik7IC8q
IFRoaXMgd2F5IHRoZSBJUCBoZWFkZXIgaXMgYWxpZ25lZCAqLw0KIAkJCWJ1
ZmZlciA9ICh1MTYqKXNrYl9wdXQgKHNrYiwgbGVuICsgaGRybGVuKTsNCiAJ
CQlpZiAodGVzdF9iaXQoRkxBR184MDJfMTEsICZhcHJpdi0+ZmxhZ3MpKSB7
DQogCQkJCWJ1ZmZlclswXSA9IGZjOw0K

---1463811839-1846257012-1088020459=:3950--
