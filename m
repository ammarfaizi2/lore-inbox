Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWH1U3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWH1U3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWH1U3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:29:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:1834 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751486AbWH1U3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:29:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=j1vgIrS6gSQvqFG2W1WyPyimtdPc1/5wzrL/kmEsROnW28hG0KAwxsrvxR+aL4gZqFkBvh1dZcoIR5nkbMdOEQ2Q5GFJG8YCD+DZik0rzmCRovnIX/iGrnbEZTisBNSnO9D5Wv0VEFFK9kxUrj5w9xJ5Ca2Yqh/ZH1zpACrpEZA=
Message-ID: <9e0cf0bf0608281329x34b866d6i5f0d632ee0d1f6e1@mail.gmail.com>
Date: Mon, 28 Aug 2006 23:29:32 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Matt Domsch" <Matt_Domsch@dell.com>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Andi Kleen" <ak@suse.de>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
In-Reply-To: <20060828201223.GE13464@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_171735_16577827.1156796972014"
References: <44F1F356.5030105@zytor.com> <44F21122.3030505@zytor.com>
	 <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com>
	 <44F29BCD.3080408@zytor.com>
	 <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com>
	 <44F335C8.7020108@zytor.com>
	 <20060828184637.GD13464@lists.us.dell.com>
	 <44F33D55.4080704@zytor.com>
	 <20060828201223.GE13464@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_171735_16577827.1156796972014
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/28/06, Matt Domsch <Matt_Domsch@dell.com> wrote:
> OK, I'll look at fixing that, and using %esi throughout.
>
> Thanks,
> Matt
>

Something as the attached?

Best Regards,
Alon Bar-Lev.

------=_Part_171735_16577827.1156796972014
Content-Type: text/x-diff; name="edd-esi-null.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="edd-esi-null.diff"
X-Attachment-Id: f_erfayivg

LS0tIGxpbnV4LTIuNi4xOC1yYzQtbW0yL2FyY2gvaTM4Ni9ib290L2VkZC5TCTIwMDYtMDYtMTgg
MDQ6NDk6MzUuMDAwMDAwMDAwICswMzAwCisrKyBsaW51eC0yLjYuMTgtcmM0LW1tMi5uZXcvYXJj
aC9pMzg2L2Jvb3QvZWRkLlMJMjAwNi0wOC0yOCAyMzoyMTowMS4wMDAwMDAwMDAgKzAzMDAKQEAg
LTIyLDE0ICsyMiwxNiBAQAogIyBlZGQ9b2YgIGRpc2FibGVzIEVERCBjb21wbGV0ZWx5ICAoZWRk
PW9mZikKICMgZWRkPXNrICBza2lwcyB0aGUgTUJSIHRlc3QgICAgKGVkZD1za2lwbWJyKQogCXB1
c2hsCSVlc2kKLSAgICAJY21wbAkkMCwgJWNzOmNtZF9saW5lX3B0cgotCWp6CWRvbmVfY2wKIAlt
b3ZsCSVjczooY21kX2xpbmVfcHRyKSwgJWVzaQorCWFuZGwJJWVzaSwgJWVzaQorCWp6CWRvbmVf
Y2wKICMgZHM6ZXNpIGhhcyB0aGUgcG9pbnRlciB0byB0aGUgY29tbWFuZCBsaW5lIG5vdwotCW1v
dmwJJChDT01NQU5EX0xJTkVfU0laRS03KSwgJWVjeAorCW1vdncJJChDT01NQU5EX0xJTkVfU0la
RS03KSwgJWN4CiAjIGxvb3AgdGhyb3VnaCBrZXJuZWwgY29tbWFuZCBsaW5lIG9uZSBieXRlIGF0
IGEgdGltZQogY2xfbG9vcDoKLQljbXBsCSRFRERfQ0xfRVFVQUxTLCAoJXNpKQorCWNtcGIJJDAs
ICglZXNpKQorCWp6CWRvbmVfY2wKKwljbXBsCSRFRERfQ0xfRVFVQUxTLCAoJWVzaSkKIAlqeglm
b3VuZF9lZGRfZXF1YWxzCiAJaW5jbAklZXNpCiAJbG9vcAljbF9sb29wCkBAIC0zNyw5ICszOSw5
IEBAIGNsX2xvb3A6CiBmb3VuZF9lZGRfZXF1YWxzOgogIyBvbmx5IGxvb2tpbmcgYXQgZmlyc3Qg
dHdvIGNoYXJhY3RlcnMgYWZ0ZXIgZXF1YWxzCiAgICAgCWFkZGwJJDQsICVlc2kKLQljbXB3CSRF
RERfQ0xfT0ZGLCAoJXNpKQkjIGVkZD1vZgorCWNtcHcJJEVERF9DTF9PRkYsICglZXNpKQkjIGVk
ZD1vZgogCWp6CWRvX2VkZF9vZmYKLQljbXB3CSRFRERfQ0xfU0tJUCwgKCVzaSkJIyBlZGQ9c2sK
KwljbXB3CSRFRERfQ0xfU0tJUCwgKCVlc2kpCSMgZWRkPXNrCiAJanoJZG9fZWRkX3NraXBtYnIK
IAlqbXAJZG9uZV9jbAogZG9fZWRkX3NraXBtYnI6Cg==
------=_Part_171735_16577827.1156796972014--
