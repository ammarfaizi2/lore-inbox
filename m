Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWF0Re2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWF0Re2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbWF0Re2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:34:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:29870 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161225AbWF0Re1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:34:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=A/HS5/FHiATcFKXY0UWWRp6BuKZxJwPtJGL9qLOYBM/jPXfqFBvPKsHE7ct4x5ZWFnEwGl9TxnMHxOlXKlfeOQ1lCe0p1GzlAK1kaxmwOU1VYFCZUgMBL3ttIOoreGxQ86IBwVCT7EeX2dKwg1WjoHeAGvUR6WDXLhzKoc6EbKU=
Message-ID: <d120d5000606271034l693567a3r23d892204d5fd3f7@mail.gmail.com>
Date: Tue, 27 Jun 2006 13:34:26 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Paolo Ornati" <ornati@fastwebnet.it>
Subject: Re: broken auto-repeat on PS/2 keyboard
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060627162733.551f844f@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14294_17216760.1151429666082"
References: <20060627162733.551f844f@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_14294_17216760.1151429666082
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/27/06, Paolo Ornati <ornati@fastwebnet.it> wrote:
> Hello,
>
> with current git kernel keyboard repeat for my plain PS/2 keyboard
> stopped working.
>
> Reverting
>        0ae051a19092d36112b5ba60ff8b5df7a5d5d23b
>
> fixes the problem...
>

Paolo,

Thank you for identifying the problem commit. Please try the attached
patch, it should fix the problem.

-- 
Dmitry

------=_Part_14294_17216760.1151429666082
Content-Type: text/plain; name="atkbd-fix-hardware-autorepeat.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="atkbd-fix-hardware-autorepeat.patch"
X-Attachment-Id: f_eoyjh4j0

SW5wdXQ6IGF0a2JkIC0gZml4IGhhcmR3YXJlIGF1dG9yZXBlYXQKClNpZ25lZC1vZmYtYnk6IERt
aXRyeSBUb3Jva2hvdiA8ZHRvckBtYWlsLnJ1PgotLS0KIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
YXRrYmQuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKSW5kZXg6IGxpbnV4L2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvYXRrYmQuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBsaW51eC5vcmlnL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvYXRrYmQuYworKysg
bGludXgvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9hdGtiZC5jCkBAIC00NTksNyArNDU5LDcgQEAg
c3RhdGljIGlycXJldHVybl90IGF0a2JkX2ludGVycnVwdChzdHJ1YwogCQkJfQogCiAJCQlpbnB1
dF9yZWdzKGRldiwgcmVncyk7Ci0JCQlpbnB1dF9yZXBvcnRfa2V5KGRldiwga2V5Y29kZSwgdmFs
dWUpOworCQkJaW5wdXRfZXZlbnQoZGV2LCBFVl9LRVksIGtleWNvZGUsIHZhbHVlKTsKIAkJCWlu
cHV0X3N5bmMoZGV2KTsKIAogCQkJaWYgKHZhbHVlICYmIGFkZF9yZWxlYXNlX2V2ZW50KSB7Cg==

------=_Part_14294_17216760.1151429666082--
