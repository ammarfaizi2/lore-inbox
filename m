Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992749AbWKAT23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992749AbWKAT23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992750AbWKAT23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:28:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:2569 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2992749AbWKAT23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:28:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=olhTTYcMcvlK3LuEdGuixaB6bCGEYO0BlzMYGlkZ8xsvq78KvFG9bK0hOMvdDrcSW+TK6h1VY9Avi+fqQhN9cyEs3SxqZaGaHNizcJ4DAr5eoBvYC0tV/ewr6lYCHtLjHOo0RQEfTlv7clpxV7oO/Lo/Fj/26z51hrpu+iOCaRs=
Message-ID: <2aac3c260611011128r5c557732o9949405661ef5175@mail.gmail.com>
Date: Wed, 1 Nov 2006 20:28:25 +0100
From: "Giangiacomo Mariotti" <giangiacomo.mariotti@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]cleaning of the definition of HANDLE_STACK and related compilation warning
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_31090_25601888.1162409305629"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_31090_25601888.1162409305629
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is my new version of a patch that I've already posted in kernel-janitors.
This new version cleans the definition of the macro HANDLE_STACK in
arch/x86_64/kernel/traps.c and erases a related compilation warning
about while(){} not being a compound statement.

Signed-off-by: Giangiacomo Mariotti <giangiacomo.mariotti@gmail.com>

------=_Part_31090_25601888.1162409305629
Content-Type: text/plain; 
	name=0001-cleaning-of-the-definition-of-HANDLE_STACK.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etznbwve
Content-Disposition: attachment; filename="0001-cleaning-of-the-definition-of-HANDLE_STACK.txt"

RnJvbSA5NjAyN2RkNzkxNmE4NGE1NzMxNmYxYTBhYzI3MjY4NWM0ZGVmNTU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHaWFuZ2lhY29tbyBNYXJpb3R0aSA8Z2lhbmdpYWNvbW8ubWFy
aW90dGlAZ21haWwuY29tPgpEYXRlOiBXZWQsIDEgTm92IDIwMDYgMTI6MDY6MzEgKzAxMDAKU3Vi
amVjdDogW1BBVENIXSBjbGVhbmluZyBvZiB0aGUgZGVmaW5pdGlvbiBvZiBIQU5ETEVfU1RBQ0sK
CnRoaXMgcGF0Y2ggY2xlYW5zIHRoZSBkZWZpbml0aW9uIG9mIEhBTkRMRV9TVEFDSwppbiB0aGUg
ZmlsZSBhcmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYyBhbmQKaXQgZXJhc2VzIGEgY29tcGlsYXRp
b24gd2FybmluZy4KLS0tCiBhcmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYyB8ICAgMzUgKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0
aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODZfNjQva2VybmVs
L3RyYXBzLmMgYi9hcmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYwppbmRleCA3ODE5MDIyLi4wNTMw
NzcxIDEwMDY0NAotLS0gYS9hcmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYworKysgYi9hcmNoL3g4
Nl82NC9rZXJuZWwvdHJhcHMuYwpAQCAtMjk3LDIyICsyOTcsMjcgQEAgdm9pZCBkdW1wX3RyYWNl
KHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLAogCSAqIGl0ZXJhdGlvbiB3aWxsIGV2ZW50dWFsbHkg
dHJpZ2dlci4KIAkgKi8KICNkZWZpbmUgSEFORExFX1NUQUNLKGNvbmQpIFwKLQlkbyB3aGlsZSAo
Y29uZCkgeyBcCi0JCXVuc2lnbmVkIGxvbmcgYWRkciA9ICpzdGFjaysrOyBcCi0JCWlmIChvb3Bz
X2luX3Byb2dyZXNzID8gCQlcCi0JCQlfX2tlcm5lbF90ZXh0X2FkZHJlc3MoYWRkcikgOiBcCi0J
CQlrZXJuZWxfdGV4dF9hZGRyZXNzKGFkZHIpKSB7IFwKLQkJCS8qIFwKLQkJCSAqIElmIHRoZSBh
ZGRyZXNzIGlzIGVpdGhlciBpbiB0aGUgdGV4dCBzZWdtZW50IG9mIHRoZSBcCi0JCQkgKiBrZXJu
ZWwsIG9yIGluIHRoZSByZWdpb24gd2hpY2ggY29udGFpbnMgdm1hbGxvYydlZCBcCi0JCQkgKiBt
ZW1vcnksIGl0ICptYXkqIGJlIHRoZSBhZGRyZXNzIG9mIGEgY2FsbGluZyBcCi0JCQkgKiByb3V0
aW5lOyBpZiBzbywgcHJpbnQgaXQgc28gdGhhdCBzb21lb25lIHRyYWNpbmcgXAotCQkJICogZG93
biB0aGUgY2F1c2Ugb2YgdGhlIGNyYXNoIHdpbGwgYmUgYWJsZSB0byBmaWd1cmUgXAotCQkJICog
b3V0IHRoZSBjYWxsIHBhdGggdGhhdCB3YXMgdGFrZW4uIFwKLQkJCSAqLyBcCi0JCQlvcHMtPmFk
ZHJlc3MoZGF0YSwgYWRkcik7ICAgXAorCWRveyBcCisJCXVuc2lnbmVkIGxvbmcgYWRkcjsgXAor
CQl3aGlsZShjb25kKXsgXAorCQkJYWRkciA9ICpzdGFjaysrOyBcCisJCQlpZihvb3BzX2luX3By
b2dyZXNzID8gCQlcCisJCQkJX19rZXJuZWxfdGV4dF9hZGRyZXNzKGFkZHIpIDogXAorCQkJCWtl
cm5lbF90ZXh0X2FkZHJlc3MoYWRkcikpeyBcCisJCQkJLyogXAorCQkJCSogSWYgdGhlIGFkZHJl
c3MgaXMgZWl0aGVyIGluIHRoZSB0ZXh0IFwKKwkJCQkqIHNlZ21lbnQgb2YgdGhlIGtlcm5lbCwg
b3IgaW4gdGhlIHJlZ2lvbiBcCisJCQkJKiB3aGljaCBjb250YWlucyB2bWFsbG9jJ2VkIG1lbW9y
eSwgaXQgbWF5IFwKKwkJCQkqIGJlIHRoZSBhZGRyZXNzIG9mIGEgY2FsbGluZyByb3V0aW5lOyBp
ZiBcCisJCQkJKiBzbywgcHJpbnQgaXQgc28gdGhhdCBzb21lb25lIHRyYWNpbmcgXAorCQkJCSog
ZG93biB0aGUgY2F1c2Ugb2YgdGhlIGNyYXNoIHdpbGwgYmUgYWJsZSBcCisJCQkJKiB0byBmaWd1
cmUgb3V0IHRoZSBjYWxsIHBhdGggdGhhdCBcCisJCQkJKiB3YXMgdGFrZW4uIFwKKwkJCQkqLyBc
CisJCQkJb3BzLT5hZGRyZXNzKGRhdGEsIGFkZHIpOyAgIFwKKwkJCX0gXAogCQl9IFwKLQl9IHdo
aWxlICgwKQorCX13aGlsZSgwKQogCiAJLyoKIAkgKiBQcmludCBmdW5jdGlvbiBjYWxsIGVudHJp
ZXMgaW4gYWxsIHN0YWNrcywgc3RhcnRpbmcgYXQgdGhlCi0tIAoxLjQuMy4zCgo=
------=_Part_31090_25601888.1162409305629--
