Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbVIIJQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbVIIJQK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbVIIJQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:16:10 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:51471
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965113AbVIIJQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:16:08 -0400
Message-Id: <43216F39020000780002489F@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 11:17:12 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>, <discuss@x86-64.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] [PATCH] x86-64 cmpxchg adjustment
References: <43207CEA020000780002451A@emea1-mh.id2.novell.com> <200509091057.07709.ak@suse.de>
In-Reply-To: <200509091057.07709.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part51733E08.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part51733E08.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>>> Andi Kleen <ak@suse.de> 09.09.05 10:57:07 >>>
>On Thursday 08 September 2005 18:03, Jan Beulich wrote:
>> (Note: Patch also attached because the inline version is certain to
get
>> line wrapped.)
>>
>> While only cosmetic for x86-64, this adjusts the cmpxchg code
>> appearantly
>> inherited from i386 to use more generic constraints.
>
>Attachment is empty.

Strange - maybe another of these neat GroupWise problems...

--=__Part51733E08.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-x86_64-cmpxchg.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-x86_64-cmpxchg.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCldoaWxlIG9ubHkgY29zbWV0aWMgZm9yIHg4
Ni02NCwgdGhpcyBhZGp1c3RzIHRoZSBjbXB4Y2hnIGNvZGUgYXBwZWFyYW50bHkKaW5oZXJpdGVk
IGZyb20gaTM4NiB0byB1c2UgbW9yZSBnZW5lcmljIGNvbnN0cmFpbnRzLgoKU2lnbmVkLW9mZi1i
eTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9p
bmNsdWRlL2FzbS14ODZfNjQvc3lzdGVtLmggMi42LjEzLXg4Nl82NC1jbXB4Y2hnL2luY2x1ZGUv
YXNtLXg4Nl82NC9zeXN0ZW0uaAotLS0gMi42LjEzL2luY2x1ZGUvYXNtLXg4Nl82NC9zeXN0ZW0u
aAkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLXg4Nl82NC1j
bXB4Y2hnL2luY2x1ZGUvYXNtLXg4Nl82NC9zeXN0ZW0uaAkyMDA1LTA5LTAxIDExOjMyOjEyLjAw
MDAwMDAwMCArMDIwMApAQCAtMjQ3LDI1ICsyNDcsMjUgQEAgc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBsb25nIF9fY21weGNoZyh2bwogCWNhc2UgMToKIAkJX19hc21fXyBfX3ZvbGF0aWxlX18oTE9D
S19QUkVGSVggImNtcHhjaGdiICViMSwlMiIKIAkJCQkgICAgIDogIj1hIihwcmV2KQotCQkJCSAg
ICAgOiAicSIobmV3KSwgIm0iKCpfX3hnKHB0cikpLCAiMCIob2xkKQorCQkJCSAgICAgOiAiciIo
bmV3KSwgIm0iKCpfX3hnKHB0cikpLCAiMCIob2xkKQogCQkJCSAgICAgOiAibWVtb3J5Iik7CiAJ
CXJldHVybiBwcmV2OwogCWNhc2UgMjoKIAkJX19hc21fXyBfX3ZvbGF0aWxlX18oTE9DS19QUkVG
SVggImNtcHhjaGd3ICV3MSwlMiIKIAkJCQkgICAgIDogIj1hIihwcmV2KQotCQkJCSAgICAgOiAi
cSIobmV3KSwgIm0iKCpfX3hnKHB0cikpLCAiMCIob2xkKQorCQkJCSAgICAgOiAiciIobmV3KSwg
Im0iKCpfX3hnKHB0cikpLCAiMCIob2xkKQogCQkJCSAgICAgOiAibWVtb3J5Iik7CiAJCXJldHVy
biBwcmV2OwogCWNhc2UgNDoKIAkJX19hc21fXyBfX3ZvbGF0aWxlX18oTE9DS19QUkVGSVggImNt
cHhjaGdsICVrMSwlMiIKIAkJCQkgICAgIDogIj1hIihwcmV2KQotCQkJCSAgICAgOiAicSIobmV3
KSwgIm0iKCpfX3hnKHB0cikpLCAiMCIob2xkKQorCQkJCSAgICAgOiAiciIobmV3KSwgIm0iKCpf
X3hnKHB0cikpLCAiMCIob2xkKQogCQkJCSAgICAgOiAibWVtb3J5Iik7CiAJCXJldHVybiBwcmV2
OwogCWNhc2UgODoKIAkJX19hc21fXyBfX3ZvbGF0aWxlX18oTE9DS19QUkVGSVggImNtcHhjaGdx
ICUxLCUyIgogCQkJCSAgICAgOiAiPWEiKHByZXYpCi0JCQkJICAgICA6ICJxIihuZXcpLCAibSIo
Kl9feGcocHRyKSksICIwIihvbGQpCisJCQkJICAgICA6ICJyIihuZXcpLCAibSIoKl9feGcocHRy
KSksICIwIihvbGQpCiAJCQkJICAgICA6ICJtZW1vcnkiKTsKIAkJcmV0dXJuIHByZXY7CiAJfQo=

--=__Part51733E08.1__=--
