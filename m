Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTEUJNO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTEUJNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:13:14 -0400
Received: from pop.gmx.de ([213.165.65.60]:46894 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261832AbTEUJNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:13:13 -0400
Message-Id: <5.2.0.9.2.20030521112745.01eb9c80@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 21 May 2003 11:30:39 +0200
To: davidm@hpl.hp.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: web page on O(1) scheduler
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
In-Reply-To: <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
References: <16075.8557.309002.866895@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_59349421==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_59349421==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 11:26 AM 5/21/2003 +0200, Mike Galbraith wrote:

>Try the attached overly simplistic (KISS:) diff, and watch your starvation 
>issues be very noticably reduced.

Ahem ;-)

Now even attached.

         -Mike 
--=====================_59349421==_
Content-Type: application/octet-stream; name="xx.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xx.diff"

LS0tIGxpbnV4LTIuNS42OS9rZXJuZWwvc2NoZWQuYy5vcmcJV2VkIE1heSAyMSAwNzo0NTowMCAy
MDAzCisrKyBsaW51eC0yLjUuNjkva2VybmVsL3NjaGVkLmMJV2VkIE1heSAyMSAwODoyNzowOSAy
MDAzCkBAIC0xMjY0LDcgKzEyNjQsNyBAQAogCXRhc2tfdCAqcHJldiwgKm5leHQ7CiAJcnVucXVl
dWVfdCAqcnE7CiAJcHJpb19hcnJheV90ICphcnJheTsKLQlzdHJ1Y3QgbGlzdF9oZWFkICpxdWV1
ZTsKKwlzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkLCAqY3VycjsKIAlpbnQgaWR4OwogCiAJLyoKQEAg
LTEzMzEsOCArMTMzMSwyMiBAQAogCX0KIAogCWlkeCA9IHNjaGVkX2ZpbmRfZmlyc3RfYml0KGFy
cmF5LT5iaXRtYXApOwotCXF1ZXVlID0gYXJyYXktPnF1ZXVlICsgaWR4OwotCW5leHQgPSBsaXN0
X2VudHJ5KHF1ZXVlLT5uZXh0LCB0YXNrX3QsIHJ1bl9saXN0KTsKK25leHRfcXVldWU6CisJaGVh
ZCA9IGFycmF5LT5xdWV1ZSArIGlkeDsKKwljdXJyID0gaGVhZC0+bmV4dDsKKwluZXh0ID0gbGlz
dF9lbnRyeShjdXJyLCB0YXNrX3QsIHJ1bl9saXN0KTsKKwljdXJyID0gY3Vyci0+bmV4dDsKKwkv
KgorCSAqIElmIHdlIGFyZSBhYm91dCB0byB3cmFwIGJhY2sgdG8gdGhlIGhlYWQgb2YgdGhlIHF1
ZXVlLAorCSAqIGdpdmUgYSBsb3dlciBwcmlvcml0eSBxdWV1ZSBhIGNoYW5jZSB0byBzbmVhayBv
bmUgaW4uCisJICovCisJaWYgKGlkeCA9PSBwcmV2LT5wcmlvICYmIGN1cnIgPT0gaGVhZCAmJiBh
cnJheS0+bnJfYWN0aXZlID4gMSkgeworCQlpbnQgdG1wID0gZmluZF9uZXh0X2JpdChhcnJheS0+
Yml0bWFwLCBNQVhfUFJJTywgKytpZHgpOworCQlpZiAodG1wIDwgTUFYX1BSSU8pIHsKKwkJCWlk
eCA9IHRtcDsKKwkJCWdvdG8gbmV4dF9xdWV1ZTsKKwkJfQorCX0KIAogc3dpdGNoX3Rhc2tzOgog
CXByZWZldGNoKG5leHQpOwo=
--=====================_59349421==_--

