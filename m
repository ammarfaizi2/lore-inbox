Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWFLQvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWFLQvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbWFLQvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:51:14 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:40170 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750727AbWFLQvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:51:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=JLWnlNHvWXpQwDKCrsDjMeY+CJRk7hl6ww+8MHPU3FaQRtqqlISjx/72qiZK5uig8QXRm6EVFpMn4A6FbMLGwwPPwKD57U2wDvz6lL2FgDpak6uQUNTFQ5uzCCnmjHOl8Vb5Fr2P2ajLcuXSGkvqAGi0HaSO3VncKKWVcw8QxT8=
Message-ID: <88ee31b70606120951h15dc1171k2c5576bf39e66d0c@mail.gmail.com>
Date: Tue, 13 Jun 2006 01:51:13 +0900
From: "Jerome Pinot" <ngc891@gmail.com>
To: dtor_core@ameritech.net
Subject: Re: Patch for atkbd.c from Ubuntu
Cc: "Pete Zaitcev" <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, adobriyan@gmail.com
In-Reply-To: <d120d5000606120916h48b4037ei1bbc54ebc645134@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14681_13262662.1150131073792"
References: <20060524113139.e457d3a8.zaitcev@redhat.com>
	 <200605290059.32302.dtor_core@ameritech.net>
	 <20060528233420.9de79795.zaitcev@redhat.com>
	 <200606120049.13974.dtor_core@ameritech.net>
	 <20060612002650.6f61a83b.zaitcev@redhat.com>
	 <88ee31b70606120901ud36842eu99355a546fea59cc@mail.gmail.com>
	 <d120d5000606120916h48b4037ei1bbc54ebc645134@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_14681_13262662.1150131073792
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/13/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 6/12/06, Jerome Pinot <ngc891@gmail.com> wrote:
> > On 6/12/06, Pete Zaitcev <zaitcev@redhat.com> wrote:
> > > On Mon, 12 Jun 2006 00:49:13 -0400, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > [...]
> > > Sounds good. Hangul is usually spelled without 'E' in the West, but
> > > I am not Korean, I can't know what is right.
> > >
> > > -- Pete
> >
> > Maybe a good time, at last, to correct this mispelling ?
> >
> > http://lists.osdl.org/pipermail/kernel-janitors/2005-October/004970.html
> >
>
> Yep. Could you please resend me the patch?
>
> Thanks!

Here it is. You may had the signed-off of Alexey Dobriyan.
If you can't read the attached patch (thanks to gmail), you can get it too from:
http://ngc891.blogdns.net/pub/projects/patches/linux-2.6-hangeul.diff

You're welcome,

-- 
Jerome Pinot
http://ngc891.blogdns.net/

------=_Part_14681_13262662.1150131073792
Content-Type: application/octet-stream; name=linux-2.6-hangeul.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eod26bjb
Content-Disposition: attachment; filename="linux-2.6-hangeul.diff"

Rml4IGEgbWlzcGVsbCBvZiB0aGUga29yZWFuIGFscGhhYmV0IG5hbWUgaW4gdGhlIGF0a2JkIHN1
YnN5c3RlbS4KIFNlZSBodHRwOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0hhbmdldWwjTmFtZXMg
Zm9yIG1vcmUgZGV0YWlscy4KIFdpbGwgbWFrZSBzb21lIGtvcmVhbiBwZW9wbGUgaGFwcHkuCgpQ
YXRjaCBhZ2FpbnN0IGxpbnV4LTIuNiBnaXQgMGU4MzhiNzJkNTRlZDE4OTAzMzkzOTI1OGE5NjFm
MmEwY2Q1OTY0NwoKIFNpZ25lZC1vZmYtYnk6IEplcm9tZSBQaW5vdCA8bmdjODkxIGF0IGdtYWls
LmNvbT4KIC0tLQoJd2lraXBlZGlhOiBIYW5nZXVsCglnb29nbGU6IDI4NjAwMCB2cyA3OTQKCUtF
WV9IQU5HVUVMIGxlZnQgdG8gbm90IGJyZWFrIHBlb3BsZQoKCQkJCS0tYWRvYnJpeWFuCgoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9rZXlib2FyZC5jIGIvZHJpdmVycy9jaGFyL2tleWJvYXJk
LmMKaW5kZXggNTc1NWI3ZS4uNTU3MDRkMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL2tleWJv
YXJkLmMKKysrIGIvZHJpdmVycy9jaGFyL2tleWJvYXJkLmMKQEAgLTEwNzMsNyArMTA3Myw3IEBA
IHN0YXRpYyBpbnQgZW11bGF0ZV9yYXcoc3RydWN0IHZjX2RhdGEgKnYKIAkJCXB1dF9xdWV1ZSh2
YywgMHgxZCB8IHVwX2ZsYWcpOwogCQkJcHV0X3F1ZXVlKHZjLCAweDQ1IHwgdXBfZmxhZyk7CiAJ
CQlyZXR1cm4gMDsKLQkJY2FzZSBLRVlfSEFOR1VFTDoKKwkJY2FzZSBLRVlfSEFOR0VVTDoKIAkJ
CWlmICghdXBfZmxhZykgcHV0X3F1ZXVlKHZjLCAweGYxKTsKIAkJCXJldHVybiAwOwogCQljYXNl
IEtFWV9IQU5KQToKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvYXRrYmQuYyBi
L2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvYXRrYmQuYwppbmRleCBmYWQwNGI2Li5lNDhlZmRiIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2F0a2JkLmMKKysrIGIvZHJpdmVycy9p
bnB1dC9rZXlib2FyZC9hdGtiZC5jCkBAIC0xNTAsNyArMTUwLDcgQEAgI2RlZmluZSBBVEtCRF9S
RVRfQkFUCQkweGFhCiAjZGVmaW5lIEFUS0JEX1JFVF9FTVVMMAkJMHhlMAogI2RlZmluZSBBVEtC
RF9SRVRfRU1VTDEJCTB4ZTEKICNkZWZpbmUgQVRLQkRfUkVUX1JFTEVBU0UJMHhmMAotI2RlZmlu
ZSBBVEtCRF9SRVRfSEFOR1VFTAkweGYxCisjZGVmaW5lIEFUS0JEX1JFVF9IQU5HRVVMCTB4ZjEK
ICNkZWZpbmUgQVRLQkRfUkVUX0hBTkpBCQkweGYyCiAjZGVmaW5lIEFUS0JEX1JFVF9FUlIJCTB4
ZmYKIApAQCAtMzA0LDcgKzMwNCw3IEBAICNlbmRpZgogCiAJCWlmIChhdGtiZC0+ZW11bCB8fAog
CQkgICAgKGNvZGUgIT0gQVRLQkRfUkVUX0VNVUwwICYmIGNvZGUgIT0gQVRLQkRfUkVUX0VNVUwx
ICYmCi0JCSAgICAgY29kZSAhPSBBVEtCRF9SRVRfSEFOR1VFTCAmJiBjb2RlICE9IEFUS0JEX1JF
VF9IQU5KQSAmJgorCQkgICAgIGNvZGUgIT0gQVRLQkRfUkVUX0hBTkdFVUwgJiYgY29kZSAhPSBB
VEtCRF9SRVRfSEFOSkEgJiYKIAkJICAgICAoY29kZSAhPSBBVEtCRF9SRVRfRVJSIHx8IGF0a2Jk
LT5lcnJfeGwpICYmCiAJICAgICAgICAgICAgIChjb2RlICE9IEFUS0JEX1JFVF9CQVQgfHwgYXRr
YmQtPmJhdF94bCkpKSB7CiAJCQlhdGtiZC0+cmVsZWFzZSA9IGNvZGUgPj4gNzsKQEAgLTMzMyw4
ICszMzMsOCBAQCAjZW5kaWYKIAkJY2FzZSBBVEtCRF9SRVRfUkVMRUFTRToKIAkJCWF0a2JkLT5y
ZWxlYXNlID0gMTsKIAkJCWdvdG8gb3V0OwotCQljYXNlIEFUS0JEX1JFVF9IQU5HVUVMOgotCQkJ
YXRrYmRfcmVwb3J0X2tleShhdGtiZC0+ZGV2LCByZWdzLCBLRVlfSEFOR1VFTCwgMyk7CisJCWNh
c2UgQVRLQkRfUkVUX0hBTkdFVUw6CisJCQlhdGtiZF9yZXBvcnRfa2V5KGF0a2JkLT5kZXYsIHJl
Z3MsIEtFWV9IQU5HRVVMLCAzKTsKIAkJCWdvdG8gb3V0OwogCQljYXNlIEFUS0JEX1JFVF9IQU5K
QToKIAkJCWF0a2JkX3JlcG9ydF9rZXkoYXRrYmQtPmRldiwgcmVncywgS0VZX0hBTkpBLCAzKTsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFjaW50b3NoL2FkYmhpZC5jIGIvZHJpdmVycy9tYWNpbnRv
c2gvYWRiaGlkLmMKaW5kZXggMzk0MzM0ZS4uM2M5Yzk3MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9t
YWNpbnRvc2gvYWRiaGlkLmMKKysrIGIvZHJpdmVycy9tYWNpbnRvc2gvYWRiaGlkLmMKQEAgLTE3
OSw3ICsxNzksNyBAQCB1OCBhZGJfdG9fbGludXhfa2V5Y29kZXNbMTI4XSA9IHsKIAkvKiAweDY1
ICovIEtFWV9GOSwJCS8qICA2NyAqLwogCS8qIDB4NjYgKi8gS0VZX0hBTkpBLAkJLyogMTIzICov
CiAJLyogMHg2NyAqLyBLRVlfRjExLAkJLyogIDg3ICovCi0JLyogMHg2OCAqLyBLRVlfSEFOR1VF
TCwJCS8qIDEyMiAqLworCS8qIDB4NjggKi8gS0VZX0hBTkdFVUwsCQkvKiAxMjIgKi8KIAkvKiAw
eDY5ICovIEtFWV9TWVNSUSwJCS8qICA5OSAqLwogCS8qIDB4NmEgKi8gMCwKIAkvKiAweDZiICov
IEtFWV9TQ1JPTExMT0NLLAkvKiAgNzAgKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2lucHV0
L2hpZC1kZWJ1Zy5oIGIvZHJpdmVycy91c2IvaW5wdXQvaGlkLWRlYnVnLmgKaW5kZXggNzAyYzQ4
Yy4uZjA0ZDZkNyAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2IvaW5wdXQvaGlkLWRlYnVnLmgKKysr
IGIvZHJpdmVycy91c2IvaW5wdXQvaGlkLWRlYnVnLmgKQEAgLTU2Myw3ICs1NjMsNyBAQCBzdGF0
aWMgY2hhciAqa2V5c1tLRVlfTUFYICsgMV0gPSB7CiAJW0tFWV9WT0xVTUVVUF0gPSAiVm9sdW1l
VXAiLAkJW0tFWV9QT1dFUl0gPSAiUG93ZXIiLAogCVtLRVlfS1BFUVVBTF0gPSAiS1BFcXVhbCIs
CQlbS0VZX0tQUExVU01JTlVTXSA9ICJLUFBsdXNNaW51cyIsCiAJW0tFWV9QQVVTRV0gPSAiUGF1
c2UiLAkJCVtLRVlfS1BDT01NQV0gPSAiS1BDb21tYSIsCi0JW0tFWV9IQU5HVUVMXSA9ICJIYW5n
dWVsIiwJCVtLRVlfSEFOSkFdID0gIkhhbmphIiwKKwlbS0VZX0hBTkdVRUxdID0gIkhhbmdldWwi
LAkJW0tFWV9IQU5KQV0gPSAiSGFuamEiLAogCVtLRVlfWUVOXSA9ICJZZW4iLAkJCVtLRVlfTEVG
VE1FVEFdID0gIkxlZnRNZXRhIiwKIAlbS0VZX1JJR0hUTUVUQV0gPSAiUmlnaHRNZXRhIiwJCVtL
RVlfQ09NUE9TRV0gPSAiQ29tcG9zZSIsCiAJW0tFWV9TVE9QXSA9ICJTdG9wIiwJCQlbS0VZX0FH
QUlOXSA9ICJBZ2FpbiIsCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lucHV0LmggYi9pbmNs
dWRlL2xpbnV4L2lucHV0LmgKaW5kZXggY2UxYTc1Ni4uMmE1MzQzMSAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9pbnB1dC5oCisrKyBiL2luY2x1ZGUvbGludXgvaW5wdXQuaApAQCAtMjMxLDcg
KzIzMSw4IEBAICNkZWZpbmUgS0VZX0tQUExVU01JTlVTCQkxMTgKICNkZWZpbmUgS0VZX1BBVVNF
CQkxMTkKIAogI2RlZmluZSBLRVlfS1BDT01NQQkJMTIxCi0jZGVmaW5lIEtFWV9IQU5HVUVMCQkx
MjIKKyNkZWZpbmUgS0VZX0hBTkdFVUwJCTEyMgorI2RlZmluZSBLRVlfSEFOR1VFTAkJS0VZX0hB
TkdFVUwKICNkZWZpbmUgS0VZX0hBTkpBCQkxMjMKICNkZWZpbmUgS0VZX1lFTgkJCTEyNAogI2Rl
ZmluZSBLRVlfTEVGVE1FVEEJCTEyNQo=
------=_Part_14681_13262662.1150131073792--
