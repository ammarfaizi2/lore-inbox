Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUFQT6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUFQT6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUFQT6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:58:40 -0400
Received: from pop.gmx.net ([213.165.64.20]:12504 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262503AbUFQT6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:58:36 -0400
X-Authenticated: #20450766
Date: Thu, 17 Jun 2004 21:58:32 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
cc: rmk@arm.linux.org.uk
Subject: Re: [Bug 2905] New: Aironet 340 PCMCIA card not working since 2.6.7
In-Reply-To: <200406171753.i5HHrx38015816@fire-2.osdl.org>
Message-ID: <Pine.LNX.4.60.0406172152310.5847@poirot.grange>
References: <200406171753.i5HHrx38015816@fire-2.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1858935792-1087502312=:5847"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811839-1858935792-1087502312=:5847
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Don't think it will help for this specific problem, but this patch fixes 
alignment problem (especially seen on ARM, Russell:-)). Sending as a text 
attachment, as my setup is known to mangle tabs...

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

On Thu, 17 Jun 2004 bugme-daemon@osdl.org wrote:

> http://bugme.osdl.org/show_bug.cgi?id=2905
>
>           Summary: Aironet 340 PCMCIA card not working since 2.6.7
>    Kernel Version: 2.6.7
>            Status: NEW
>          Severity: normal
>             Owner: rmk@arm.linux.org.uk
>         Submitter: hadmut@danisch.de
>
>
> Distribution: Debian
> Hardware Environment: Dell Inspiron 3800, Cisco
>  Aironet 340 PCMCIA card
> Software Environment:
>  Debian
> Problem Description:
>
> The system was working well with
> 2.4.x and 2.6.x kernels up to 2.6.6.
>
> After upgrade to 2.6.7 the WLAN does n
> not work anymore: There is no error message,
> no warning, everything looks fine, except
> for the fact that traffic is not possible.
>
> Maybe a WEP problem?
>
> regards
> Hadmut
>
> ------- You are receiving this mail because: -------
> You are the assignee for the bug, or are watching the assignee.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

---
Guennadi Liakhovetski

---1463811839-1858935792-1087502312=:5847
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="airo.c.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0406172158320.5847@poirot.grange>
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

---1463811839-1858935792-1087502312=:5847--
