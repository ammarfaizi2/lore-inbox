Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVAJHkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVAJHkg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 02:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVAJHke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 02:40:34 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:8859 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262134AbVAJHk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 02:40:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=QWuckS1ho9f2c0H0XEGGdDX+kRLhyqXBST86kfOW+H+5zm6ovxqXbWnQu+MCOtq9JrNIa2NfdPSUL3n+i+eT83/tcGVlpez0LJoW7w3FyzgVP9Uuize/MRNXDOPQQfHpkmCO9NQwn1hr/Zykf5cwp/2V//rhvQUzw1w/g7YcVq0=
Message-ID: <21d7e99705010923403a57c7a6@mail.gmail.com>
Date: Mon, 10 Jan 2005 18:40:25 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Brice.Goglin@ens-lyon.org
Subject: Re: 2.6.10-mm2
Cc: Benoit Boissinot <bboissin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mike Werner <werner@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <41E13C87.3050306@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_141_8034753.1105342825583"
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <40f323d005010701395a2f8d00@mail.gmail.com>
	 <21d7e99705010718435695f837@mail.gmail.com>
	 <40f323d00501080427f881c68@mail.gmail.com>
	 <21d7e99705010805487322533e@mail.gmail.com>
	 <40f323d0050108074112ae4ac7@mail.gmail.com>
	 <21d7e99705010817386f55e836@mail.gmail.com>
	 <40f323d005010906093ba08ba4@mail.gmail.com>
	 <41E13C87.3050306@ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_141_8034753.1105342825583
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 09 Jan 2005 15:15:35 +0100, Brice Goglin
<Brice.Goglin@ens-lyon.fr> wrote:
> >>If you could apply the patch I've attached (just adds some debug...)
> >>it'll narrow it down a small bit where it is failing for me...
> >>

I've another patch on top of -mm2 anyone wanna try this.. i'm
interested in finding out when the atomic_inc actually is happening...

Dave.

------=_Part_141_8034753.1105342825583
Content-Type: application/octet-stream; name="part1"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="part1"

LS0tIGRyaXZlcnMvY2hhci9hZ3AvYmFja2VuZC5jLm9yaWcJMjAwNS0wMS0wOSAxMjozNjoxOS4w
MDAwMDAwMDAgKzExMDAKKysrIGRyaXZlcnMvY2hhci9hZ3AvYmFja2VuZC5jCTIwMDUtMDEtMTAg
MTg6MzY6MTUuMDAwMDAwMDAwICsxMTAwCkBAIC02NiwxMCArNjYsMTcgQEAKIAlicmlkZ2UgPSBh
Z3BfZ2VuZXJpY19maW5kX2JyaWRnZShwZGV2KTsKIAogCWlmICghYnJpZGdlKQorCXsJCisJCXBy
aW50aygiYWdwX2JhY2tlbmRfYWNxdWlyZSBmYWlsZWQgb24gZmluZCBicmlkZ2VcbiIpOwogCQly
ZXR1cm4gTlVMTDsKKwl9CiAKIAlpZiAoYXRvbWljX3JlYWQoJmJyaWRnZS0+YWdwX2luX3VzZSkp
CisJeworCQlwcmludGsoImFncF9iYWNrZW5kX2FjcXVpcmUgZmFpbGVkIG9uIGF0b21pYyByZWFk
XG4iKTsKIAkJcmV0dXJuIE5VTEw7CisJfQorCXByaW50aygiYWdwX2JhY2tlbmRfYWNxdWlyZTog
aW5jcmVhc2UgYWdwX2luX3VzZVxuIik7CiAJYXRvbWljX2luYygmYnJpZGdlLT5hZ3BfaW5fdXNl
KTsKIAlyZXR1cm4gYnJpZGdlOwogfQpAQCAtODcsOCArOTQsMTAgQEAKIHZvaWQgYWdwX2JhY2tl
bmRfcmVsZWFzZShzdHJ1Y3QgYWdwX2JyaWRnZV9kYXRhICpicmlkZ2UpCiB7CiAKLQlpZiAoYnJp
ZGdlKQorCWlmIChicmlkZ2UpIHsKKwkJcHJpbnRrKCJhZ3BfYmFja2VuZF9hY3F1aXJlOiBkZWNy
ZWFzZSBhZ3BfaW5fdXNlXG4iKTsKIAkJYXRvbWljX2RlYygmYnJpZGdlLT5hZ3BfaW5fdXNlKTsK
Kwl9CiB9CiBFWFBPUlRfU1lNQk9MKGFncF9iYWNrZW5kX3JlbGVhc2UpOwogCi0tLSBkcml2ZXJz
L2NoYXIvYWdwL2Zyb250ZW5kLmMub3JpZwkyMDA1LTAxLTEwIDE4OjM4OjA1LjAwMDAwMDAwMCAr
MTEwMAorKysgZHJpdmVycy9jaGFyL2FncC9mcm9udGVuZC5jCTIwMDUtMDEtMTAgMTg6MzY6NTIu
MDAwMDAwMDAwICsxMTAwCkBAIC03OTQsNiArNzk0LDcgQEAKICAgICAgICAgaWYgKGF0b21pY19y
ZWFkKCZhZ3BfYnJpZGdlLT5hZ3BfaW5fdXNlKSkKICAgICAgICAgICAgICAgICByZXR1cm4gLUVC
VVNZOwogCisJcHJpbnRrKCJhZ3Bpb2MgYWNxdWlyZSBpbmNyZWFzZSBhZ3BfaW5fdXNlXG4iKTsK
IAlhdG9taWNfaW5jKCZhZ3BfYnJpZGdlLT5hZ3BfaW5fdXNlKTsKIAogCWFncF9mZS5iYWNrZW5k
X2FjcXVpcmVkID0gVFJVRTsK
------=_Part_141_8034753.1105342825583--
