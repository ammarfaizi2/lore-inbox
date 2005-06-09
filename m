Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVFIMgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVFIMgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVFIMfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:35:47 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:44069 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262376AbVFIMdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:33:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=i08RhChj95aHQpvgM7k5eVJBIELEfYBla6937bNWaftweECIZNkDeuOlRtrkWwSBCeIrwfvB+ZXJTCsxuGsKsOc90l+sVaFz+ez3qRnOKqHEJcDjAM8MHquMTWUaWCgrcVEYoFkLkBnhcV6NpPLJoYZf2iY1AxDUv7JSenJ4suA=
Message-ID: <58cb370e0506090533362dfbf0@mail.gmail.com>
Date: Thu, 9 Jun 2005 14:33:52 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: info@a-wing.co.uk
Subject: Re: sis5513.c patch take 2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42A831E3.5080607@a-wing.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_393_9430505.1118320432151"
References: <42A831E3.5080607@a-wing.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_393_9430505.1118320432151
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On 6/9/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
> Hi,
>=20
> Is this patch safer?  I am burn-in testing it now and it seems work fine
> with UDMA transfers.  I added the PCI ID of the northbridge as suggested.

Thanks, could you also try this simple debugging patch?
[ without applying your patch ]

It may be possible to add generic 965L support just like 962/936L one
(also NorthBridge<->SouthBridge mapping is not unique nowadays).

Bartlomiej

------=_Part_393_9430505.1118320432151
Content-Type: application/octet-stream; name="sis5513-debug1.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sis5513-debug1.patch"

LS0tIGEvZHJpdmVycy9pZGUvcGNpL3NpczU1MTMuYwkyMDA1LTA1LTI2IDE0OjUxOjE0LjAwMDAw
MDAwMCArMDIwMAorKysgYi9kcml2ZXJzL2lkZS9wY2kvc2lzNTUxMy5jCTIwMDUtMDYtMDkgMTQ6
MTk6NDQuMDAwMDAwMDAwICswMjAwCkBAIC03NjUsNiArNzY1LDggQEAKIAkJCXBjaV9yZWFkX2Nv
bmZpZ193b3JkKGRldiwgUENJX0RFVklDRV9JRCwgJnRydWVpZCk7CiAJCQlwY2lfd3JpdGVfY29u
ZmlnX2R3b3JkKGRldiwgMHg1NCwgaWRlbWlzYyk7CiAKKwkJCXByaW50ayhLRVJOX0lORk8gIlNJ
UzU1MTM6IHRydWVpZD0weCV4XG4iLCB0cnVlaWQpOworCiAJCQlpZiAodHJ1ZWlkID09IDB4NTUx
OCkgewogCQkJCXByaW50ayhLRVJOX0lORk8gIlNJUzU1MTM6IFNpUyA5NjIvOTYzIE11VElPTCBJ
REUgVURNQTEzMyBjb250cm9sbGVyXG4iKTsKIAkJCQljaGlwc2V0X2ZhbWlseSA9IEFUQV8xMzM7
Cg==
------=_Part_393_9430505.1118320432151--
