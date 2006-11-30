Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758541AbWK3H3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758541AbWK3H3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758543AbWK3H3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:29:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:6396 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1758541AbWK3H3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:29:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=urCph6PyoZaKcmx8fqhkiMOrC4cSiFSF1u6zRU9hzkS6Xu2YVO1R+Vtx5yrr7ONdsIfoPebKhM9LPwPArZGZtTIf4ZbeBbshjby2clTk9YERApZqBzyNDo6CDSAyM+Jc6YPon92N1Lm++8vj7gnODxC1Yw26w8/bFUXG7C8xOVc=
Message-ID: <74d0deb30611292329ifc9f69bk77bd8b3a1b22cf3e@mail.gmail.com>
Date: Thu, 30 Nov 2006 08:29:28 +0100
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Cc: "Bill Gatliff" <bgat@billgatliff.com>, "Paul Mundt" <lethal@linux-sh.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Andrew Victor" <andrew@sanpeople.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
       "Kevin Hilman" <khilman@mvista.com>, "Nicolas Pitre" <nico@cam.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
In-Reply-To: <74d0deb30611292257n3f532abbyedef9b543b9d48ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_31974_4785888.1164871768729"
References: <200611111541.34699.david-b@pacbell.net>
	 <200611202135.39970.david-b@pacbell.net>
	 <456321E9.2030308@billgatliff.com>
	 <200611221640.55574.david-b@pacbell.net>
	 <74d0deb30611292257n3f532abbyedef9b543b9d48ae@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_31974_4785888.1164871768729
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/30/06, pHilipp Zabel <philipp.zabel@gmail.com> wrote:
> > Effectively, yes.  I counted quite a few implementations in the current
> > tree which can trivially (#defines) map to that API.

Or so I thought, sorry.

regards
Philipp

------=_Part_31974_4785888.1164871768729
Content-Type: text/x-patch; name=gpio-api-pxa.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ev4ukbap
Content-Disposition: attachment; filename="gpio-api-pxa.patch"

SW5kZXg6IGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1weGEvZ3Bpby5oCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIC9kZXYvbnVsbAkxOTcwLTAxLTAxIDAwOjAwOjAwLjAwMDAwMDAwMCArMDAwMAorKysg
bGludXgtMi42L2luY2x1ZGUvYXNtLWFybS9hcmNoLXB4YS9ncGlvLmgJMjAwNi0xMS0zMCAwNzoz
OTo1OS4wMDAwMDAwMDAgKzAxMDAKQEAgLTAsMCArMSw2NSBAQAorLyoKKyAqIGxpbnV4L2luY2x1
ZGUvYXNtLWFybS9hcmNoLXB4YS9ncGlvLmgKKyAqCisgKiBQWEEgR1BJTyB3cmFwcGVycyBmb3Ig
YXJjaC1uZXV0cmFsIEdQSU8gY2FsbHMKKyAqCisgKiBXcml0dGVuIGJ5IFBoaWxpcHAgWmFiZWwg
PHBoaWxpcHAuemFiZWxAZ21haWwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieQorICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBv
ZiB0aGUgTGljZW5zZSwgb3IKKyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQg
d2lsbCBiZSB1c2VmdWwsCisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZl
biB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1Mg
Rk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiBTZWUgdGhlCisgKiBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZl
ZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiBhbG9uZyB3aXRo
IHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorICogRm91
bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIx
MTEtMTMwNyBVU0EKKyAqCisgKi8KKworI2lmbmRlZiBfX0FTTV9BUkNIX1BYQV9HUElPX0gKKyNk
ZWZpbmUgX19BU01fQVJDSF9QWEFfR1BJT19ICisKKyNpbmNsdWRlIDxhc20vYXJjaC9weGEtcmVn
cy5oPgorI2luY2x1ZGUgPGFzbS9hcmNoL2lycXMuaD4KKyNpbmNsdWRlIDxhc20vYXJjaC9oYXJk
d2FyZS5oPgorCisjaW5jbHVkZSA8YXNtL2Vycm5vLmg+CisKK3N0YXRpYyBpbmxpbmUgaW50IGdw
aW9fcmVxdWVzdCh1bnNpZ25lZCBncGlvLCBjb25zdCBjaGFyICpsYWJlbCkKK3sKKwlyZXR1cm4g
MDsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGdwaW9fZnJlZSh1bnNpZ25lZCBncGlvKQorewor
CXJldHVybjsKK30KKworc3RhdGljIGlubGluZSBpbnQgZ3Bpb19kaXJlY3Rpb25faW5wdXQodW5z
aWduZWQgZ3BpbykKK3sKKwlpZiAoZ3BpbyA+IFBYQV9MQVNUX0dQSU8pCisJCXJldHVybiAtRUlO
VkFMOworCXB4YV9ncGlvX21vZGUoZ3BpbyB8IEdQSU9fSU4pOworfQorCitzdGF0aWMgaW5saW5l
IGludCBncGlvX2RpcmVjdGlvbl9vdXRwdXQodW5zaWduZWQgZ3BpbykKK3sKKwlpZiAoZ3BpbyA+
IFBYQV9MQVNUX0dQSU8pCisJCXJldHVybiAtRUlOVkFMOworCXB4YV9ncGlvX21vZGUoZ3BpbyB8
IEdQSU9fT1VUKTsKK30KKworI2RlZmluZSBncGlvX2dldF92YWx1ZShncGlvKQkoR1BMUihncGlv
KSAmIEdQSU9fYml0KGdwaW8pKQorI2RlZmluZSBncGlvX3NldF92YWx1ZShncGlvLHZhbHVlKSBc
CisJKCh2YWx1ZSk/IChHUFNSKGdwaW8pID0gR1BJT19iaXQoZ3BpbykpOihHUENSKGdwaW8pID0g
R1BJT19iaXQoZ3BpbykpKQorCisjZGVmaW5lIGdwaW9fdG9faXJxKGdwaW8pCUlSUV9HUElPKGdw
aW8pCisjZGVmaW5lIGlycV90b19ncGlvKGlycSkJSVJRX1RPX0dQSU8oaXJxKQorCisKKyNlbmRp
Zgo=
------=_Part_31974_4785888.1164871768729--
