Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTJUUbc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbTJUUbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:31:32 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:20193 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S263376AbTJUUb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:31:28 -0400
Date: Tue, 21 Oct 2003 22:31:24 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Olaf Hering <olh@suse.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] atyfb updates
In-Reply-To: <20031021201958.GA11113@suse.de>
Message-ID: <Pine.LNX.4.44.0310212230340.30060-200000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1585291996-1511902515-1066768284=:30060"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1585291996-1511902515-1066768284=:30060
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Tue, 21 Oct 2003, Olaf Hering wrote:

>  On Fri, Oct 10, Dani=C3=ABl Mantione wrote:
>
> >
> >
> > On Fri, 10 Oct 2003, Geert Uytterhoeven wrote:
> >
> > > This one is still needed to get atyfb compiled when Mach64 GX support=
 is
> > > enabled.
> >
> > Ok, go ahead! We'll also need to get that Mach64 LT fifo width set to 2=
4
> > bit and the Powerbook special detection applied.
>
> This patch is still missing, ibook1 doesnt work (unless I missed a patch
> to fix it).

It's attached again.

Dani=EBl

---1585291996-1511902515-1066768284=:30060
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="atyfb-ibook1+m64ltfixed-2.4.22-bk22.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0310212231240.30060@deadlock.et.tudelft.nl>
Content-Description: 
Content-Disposition: attachment; filename="atyfb-ibook1+m64ltfixed-2.4.22-bk22.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4yMi1iazIyL2RyaXZlcnMvdmlkZW8vYXR5
L2F0eWZiX2Jhc2UuYyBsaW51eC0yLjQuMjItYmsyMi5maXhlZC9kcml2ZXJz
L3ZpZGVvL2F0eS9hdHlmYl9iYXNlLmMNCi0tLSBsaW51eC0yLjQuMjItYmsy
Mi9kcml2ZXJzL3ZpZGVvL2F0eS9hdHlmYl9iYXNlLmMJRnJpIFNlcCAxOSAx
OTo1MjozMiAyMDAzDQorKysgbGludXgtMi40LjIyLWJrMjIuZml4ZWQvZHJp
dmVycy92aWRlby9hdHkvYXR5ZmJfYmFzZS5jCUZyaSBTZXAgMTkgMTk6NTY6
MjMgMjAwMw0KQEAgLTMyMyw3ICszMjMsOCBAQA0KICAgICAgICBJdCdzIGFs
c28gb2Z0ZW4gYSBnb29kIGlkZWEgdG8gY29udGFjdCBBVGkuDQogICAgICAg
IA0KICAgICAgICBMYXN0bHksIHRoaXJkIHBhcnR5IGJvYXJkIHZlbmRvcnMg
bWlnaHQgdXNlIGRpZmZlcmVudCBtZW1vcnkgY2xvY2tzDQotICAgICAgIHRo
YW4gQVRpLiBObyBleGFtcGxlcyBvZiB0aGlzIGhhdmUgYmVlbiBmb3VuZCB5
ZXQsIGJ1dCBpdCBpcyBwb3NzaWJsZS4NCisgICAgICAgdGhhbiBBVGkuIEFu
IGV4YW1wbGUgb2YgdGhpcyBpcyB0aGUgQXBwbGUgaUJvb2sxIHdoaWNoIGlz
IGhhbmRsZWQgc3BlY2lhbGx5DQorICAgICAgIGluIGF0eV9pbml0Lg0KICAg
ICAgICANCiAgICAgICAgKERhbmllbCBNYW50aW9uZSwgMjYgSnVuZSAyMDAz
KQ0KICAgICAgKi8NCkBAIC0zNTYsNyArMzU3LDcgQEANCiANCiAgICAgLyog
TWFjaDY0IExUICovDQogICAgIHsgMHg0YzU0LCAweDRjNTQsIDB4MDAsIDB4
MDAsIG02NG5fbHQsICAgICAgMTM1LCAgNjMsICA2MywgTTY0Rl9HVCB8IE02
NEZfSU5URUdSQVRFRCB8IE02NEZfR1RCX0RTUCB9LA0KLSAgICB7IDB4NGM0
NywgMHg0YzQ3LCAweDAwLCAweDAwLCBtNjRuX2x0ZywgICAgIDIzMCwgIDYz
LCAgNjMsIE02NEZfR1QgfCBNNjRGX0lOVEVHUkFURUQgfCBNNjRGX0dUQl9E
U1AgfCBNNjRGX1NEUkFNX01BR0lDX1BMTCB8IE02NEZfRVhUUkFfQlJJR0hU
IHwgTTY0Rl9MVF9TTEVFUCB8IE02NEZfRzNfUEJfMTAyNHg3NjggfSwNCisg
ICAgeyAweDRjNDcsIDB4NGM0NywgMHgwMCwgMHgwMCwgbTY0bl9sdGcsICAg
ICAyMzAsICA2MywgIDYzLCBNNjRGX0dUIHwgTTY0Rl9JTlRFR1JBVEVEIHwg
TTY0Rl9HVEJfRFNQIHwgTTY0Rl9TRFJBTV9NQUdJQ19QTEwgfCBNNjRGX0VY
VFJBX0JSSUdIVCB8IE02NEZfTFRfU0xFRVAgfCBNNjRGX0czX1BCXzEwMjR4
NzY4IHwgTTY0Rl9GSUZPXzI0IH0sDQogDQogICAgIC8qIE1hY2g2NCBHVEMg
KDNEIFJBR0UgUFJPKSAqLw0KICAgICB7IDB4NDc0MiwgMHg0NzQyLCAweDAw
LCAweDAwLCBtNjRuX2d0Y19iYSwgIDIzMCwgMTAwLCAxMDAsIE02NEZfR1Qg
fCBNNjRGX0lOVEVHUkFURUQgfCBNNjRGX1JFU0VUXzNEIHwgTTY0Rl9HVEJf
RFNQIHwgTTY0Rl9TRFJBTV9NQUdJQ19QTEwgfCBNNjRGX0VYVFJBX0JSSUdI
VCB9LA0KQEAgLTIwNzUsNiArMjA3NiwxNCBAQA0KICAgICAgICAgcmFtbmFt
ZSA9IGF0eV9jdF9yYW1baW5mby0+cmFtX3R5cGVdOw0KICAgICAgICAgaW5m
by0+ZGFjX29wcyA9ICZhdHlfZGFjX2N0Ow0KICAgICAgICAgaW5mby0+cGxs
X29wcyA9ICZhdHlfcGxsX2N0Ow0KKyNpZmRlZiBDT05GSUdfQUxMX1BQQw0K
KwkvKiBUaGUgQXBwbGUgaUJvb2sxIHVzZXMgbm9uLXN0YW5kYXJkIG1lbW9y
eSBmcmVxdWVuY2llcy4gV2UgZGV0ZWN0IGl0DQorCSAgIGFuZCBzZXQgdGhl
IGZyZXF1ZW5jeSBtYW51YWxseS4gKi8NCisJaWYgKCh0eXBlPT0weDRjNGUp
ICYmIG1hY2hpbmVfaXNfY29tcGF0aWJsZSgiUG93ZXJCb29rMiwxIikpIHsN
CisJICAgIG1jbGs9NzA7DQorCSAgICB4Y2xrPTUzOw0KKwl9Ow0KKyNlbmRp
Zg0KIAkvKg0KIAkgKiBJIGRpc2FibGUgdGhlIGhhY2sgYmVsb3cgYmVjYXVz
ZSBpdCBpcyBjb21wbGV0ZWx5IHVucmVsaWFibGUuIA0KIAkgKiBEUkFNIGF0
IDY3IGlzIHZlcnkgd2VsbCBpbWFnaW5hYmxlLiBJZiBhIGNoaXAgaXMgaW5k
ZWVkIGNsb2NrZWQNCg==
---1585291996-1511902515-1066768284=:30060--
