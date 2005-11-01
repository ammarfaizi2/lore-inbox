Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVKAQix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVKAQix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVKAQix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:38:53 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:18109 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750931AbVKAQiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:38:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=TvD0QaFDAX0kaetBZ8uL+yz8tqY6nzmPF/MysMfFV2e06XtU2n8zxpMKXaGuQAcLLW3LM3hNPmYDz/DDSueJElz5QWlQ8ikCW6AXub+Taw47a1O6tdm1xfqLB0Ew0ICuCmm0VoxnoH2J+btKUjM+Ae+L2UUFjOA75xPR+Mu8cbI=
Message-ID: <d120d5000511010838j2013f29et3d48d891e5ea8dad@mail.gmail.com>
Date: Tue, 1 Nov 2005 11:38:51 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Subject: Re: Kernel Badness 2.6.14-Git
Cc: Robert Love <rml@novell.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051101144509.M10192@linuxwireless.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18017_26645232.1130863131826"
References: <4362BFF1.3040304@linuxwireless.org>
	 <200510312221.13217.dtor_core@ameritech.net>
	 <20051101073530.GB27536@kroah.com>
	 <200511010258.14313.dtor_core@ameritech.net>
	 <20051101081433.GB28048@kroah.com>
	 <1130854317.16163.52.camel@phantasy>
	 <20051101144509.M10192@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_18017_26645232.1130863131826
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/1/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> On Tue, 01 Nov 2005 09:11:57 -0500, Robert Love wrote
> > On Tue, 2005-11-01 at 00:14 -0800, Greg KH wrote:
> >
> > > I don't have a problem with this, try it out and see what breaks :)
> >
> > I don't mind moving the driver (as Greg suggested earlier) if needed,
> > but if Dmitry's idea to move input.o works, even better.
> >
>
> I can try the suggested solution if I'm told how to. ;-)
>

Could you try the attached (I did compile it but didn't try to boot).

--
Dmitry

------=_Part_18017_26645232.1130863131826
Content-Type: application/octet-stream; name="input-move-core-earlier.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="input-move-core-earlier.patch"

SW5wdXQ6IHJlZ2lzdGVyIGlucHV0IGNvcmUgZWFybGllcgoKTm93IHRoYXQgaW5wdXQgY29yZSBp
cyBpbnRlZ3JhdGVkIHdpdGggc3lzZnMgaW5wdXQgY2xhc3Mgc2hvdWxkCmJlIGZ1bGx5IHJlZ2lz
dGVyZWQgYmVmb3JlIGFueW9uZSB0cmllcyB0byB1c2UgaXQuIE1vdmUgaW5wdXQubwp0byB0aGUg
dG9wIG9mIHRoZSBkcml2ZXJzL01ha2VmaWxlIHdoaWxlIGxlYXZpbmcgdGhlIHJlc3Qgb2YKdGhl
IGlucHV0IHN5c3RlbSBpbiB0aGUgb2xkIHBsYWNlLgoKU2lnbmVkLW9mZi1ieTogRG1pdHJ5IFRv
cm9raG92IDxkdG9yQG1haWwucnU+Ci0tLQoKIGRyaXZlcnMvTWFrZWZpbGUgICAgICAgfCAgICA0
ICsrKysKIGRyaXZlcnMvaW5wdXQvTWFrZWZpbGUgfCAgICAzICsrLQogMiBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCkluZGV4OiBsaW51eC9kcml2ZXJzL01h
a2VmaWxlCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9NYWtlZmlsZQorKysgbGlu
dXgvZHJpdmVycy9NYWtlZmlsZQpAQCAtNSw2ICs1LDEwIEBACiAjIFJld3JpdHRlbiB0byB1c2Ug
bGlzdHMgaW5zdGVhZCBvZiBpZi1zdGF0ZW1lbnRzLgogIwogCisjIHdlIG5lZWQgaW5wdXQgY29y
ZSBlYXJseSBzbyBpbnB1dCBjbGFzcyBpcyByZWdpc3RlcmVkIGJlZm9yZSBhbnlvbmUKKyMgdHJp
ZXMgdG8gdXNlIGl0Lgorb2JqLSQoQ09ORklHX0lOUFVUKQkJKz0gaW5wdXQvaW5wdXQubworCiBv
YmotJChDT05GSUdfUENJKQkJKz0gcGNpLyB1c2IvCiBvYmotJChDT05GSUdfUEFSSVNDKQkJKz0g
cGFyaXNjLwogb2JqLXkJCQkJKz0gdmlkZW8vCkluZGV4OiBsaW51eC9kcml2ZXJzL2lucHV0L01h
a2VmaWxlCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9pbnB1dC9NYWtlZmlsZQor
KysgbGludXgvZHJpdmVycy9pbnB1dC9NYWtlZmlsZQpAQCAtNCw3ICs0LDggQEAKIAogIyBFYWNo
IGNvbmZpZ3VyYXRpb24gb3B0aW9uIGVuYWJsZXMgYSBsaXN0IG9mIGZpbGVzLgogCi1vYmotJChD
T05GSUdfSU5QVVQpCQkrPSBpbnB1dC5vCisjIG5vdGUgdGhhdCBpbnB1dC5vIGlzIHJlZ2lzdGVy
ZWQgZWFybHkgZnJvbSBkcml2ZXJzL01ha2VmaWxlCisKIG9iai0kKENPTkZJR19JTlBVVF9NT1VT
RURFVikJKz0gbW91c2VkZXYubwogb2JqLSQoQ09ORklHX0lOUFVUX0pPWURFVikJKz0gam95ZGV2
Lm8KIG9iai0kKENPTkZJR19JTlBVVF9FVkRFVikJKz0gZXZkZXYubwo=
------=_Part_18017_26645232.1130863131826--
