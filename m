Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTICRiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTICRg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:36:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61312 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263913AbTICRgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:36:07 -0400
Date: Wed, 3 Sep 2003 13:35:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Masoodur Rahman <rmasoodur@rediffmail.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP image on a UP machine
In-Reply-To: <20030903171527.30457.qmail@webmail25.rediffmail.com>
Message-ID: <Pine.LNX.4.53.0309031330330.29263@chaos>
References: <20030903171527.30457.qmail@webmail25.rediffmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-958052311-1062610523=:29263"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-958052311-1062610523=:29263
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 3 Sep 2003, Masoodur  Rahman wrote:

> Hi ,
>
>      Can I run a SMP kernel on a UP machine (x86 based ) ??
>

Yes!

>      I am working with 2.4.19 kernel compiled with CONFIG_SMP on a
> UniProcessor machine. The machine boots up with the SMP kernel
> configured in .
>

Fine.

>     The Problem comes when I try to create a kernel thread using
> the example at  http://www.scs.ch/~frey/linux/kernelthreads.html
>
>    The entire machine hangs on loading the thread_mod.o ..
>
>    What am I doing wrong ?? Is there any option that needs to be
> turned on to get this working ??
>

Kernel threads, properly implemented, do not hang the machine, SMP
or not. Find some other source to copy. The attached file, written
by Vladmir Kondratiev of Intel works.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


--1678434306-958052311-1062610523=:29263
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="kth.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0309031335230.29263@chaos>
Content-Description: 
Content-Disposition: attachment; filename="kth.c"

I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCiNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCiNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiNpbmNsdWRlIDxs
aW51eC9zY2hlZC5oPg0KI2luY2x1ZGUgPGxpbnV4L3Byb2NfZnMuaD4NCiNp
bmNsdWRlIDxsaW51eC92bWFsbG9jLmg+DQojaW5jbHVkZSA8YXNtL3VhY2Nl
c3MuaD4NCg0KdHlwZWRlZiBzdHJ1Y3Qga3RfcHJpdl9zdHJ1Y3Qgew0KICBp
bnQgbnRocmVhZHM7IC8qKjwgbGV0J3MgY291bnQgaG93IG1hbnkgdGltZXMg
a2VybmVsX3RocmVhZCBzdWNjZWVkZWQgKi8NCiAgaW50IHBpZDsNCiAgd2Fp
dF9xdWV1ZV9oZWFkX3Qgd3E7ICAgICAgLyoqPCBrdGhyZWFkIHNsZWVwIGhl
cmUgKi8NCiAgc3RydWN0IGNvbXBsZXRpb24gZXhpdGVkOw0KICBfX3UzMiB2
b2xhdGlsZSBzdGF0dXM7DQp9IGt0X3ByaXZfdDsNCg0Kc3RhdGljIGt0X3By
aXZfdCB0aGVfZGF0YTsNCg0Kc3RhdGljIGludCBrdF90aHJlYWQodm9pZCog
YXJnKQ0Kew0KICBrdF9wcml2X3QqIHByaXY9KGt0X3ByaXZfdCopYXJnOw0K
ICBkYWVtb25pemUoKTsNCiAgcmVwYXJlbnRfdG9faW5pdCgpOw0KICBzbnBy
aW50ZihjdXJyZW50LT5jb21tLHNpemVvZihjdXJyZW50LT5jb21tKSwia3Ro
XyVkIixwcml2LT5udGhyZWFkcyk7DQogICsrcHJpdi0+bnRocmVhZHM7DQog
IHdoaWxlICghdGVzdF9iaXQoMCwmcHJpdi0+c3RhdHVzKSkgew0KICAgIC8q
IGZyYW1ld29yayBmb3IgcGVyaW9kaWNhbCBleGVjdXRpb24gKi8NCiAgICB1
bnNpZ25lZCBsb25nIHRvPUhaOyAvKiB0aW1lb3V0IGZvciBwZXJpb2RpY2Fs
IG1haW50ZW5hbmNlICovDQogICAgZG8gew0KICAgICAgdG89aW50ZXJydXB0
aWJsZV9zbGVlcF9vbl90aW1lb3V0KCZwcml2LT53cSx0byk7DQogICAgfSB3
aGlsZSAoICFzaWduYWxfcGVuZGluZyhjdXJyZW50KSAmJiB0bz4wICk7DQog
ICAgaWYgKHNpZ25hbF9wZW5kaW5nKGN1cnJlbnQpKSB7DQogICAgICBzcGlu
X2xvY2tfaXJxKCZjdXJyZW50LT5zaWdtYXNrX2xvY2spOw0KICAgICAgZmx1
c2hfc2lnbmFscyhjdXJyZW50KTsNCiAgICAgIHNwaW5fdW5sb2NrX2lycSgm
Y3VycmVudC0+c2lnbWFza19sb2NrKTsNCiAgICB9DQogICAgLyogdGhyZWFk
IGJvZHkgLSBmb3IgdGhpcyBzaW1wbGUgZXhhbXBsZSBkbyBub3RoaW5nICov
DQogIH0NCiAgY29tcGxldGVfYW5kX2V4aXQoJnByaXYtPmV4aXRlZCwwKTsN
Cn0NCg0Kc3RhdGljIHZvaWQga3Rfc3RhcnQoa3RfcHJpdl90KiBwcml2KQ0K
ew0KICBpZiAocHJpdi0+cGlkPjApIHJldHVybjsNCiAgaW5pdF9jb21wbGV0
aW9uKCZwcml2LT5leGl0ZWQpOw0KICBpbml0X3dhaXRxdWV1ZV9oZWFkKCZw
cml2LT53cSk7DQogIHByaXYtPnN0YXR1cz0wOw0KICBwcml2LT5waWQ9a2Vy
bmVsX3RocmVhZChrdF90aHJlYWQscHJpdiwwKTsNCn0NCg0Kc3RhdGljIHZv
aWQga3Rfc3RvcChrdF9wcml2X3QqIHByaXYpDQp7DQogIGlmIChwcml2LT5w
aWQ+MCAmJiAoMD09dGVzdF9hbmRfc2V0X2JpdCgwLCZwcml2LT5zdGF0dXMp
KSkgew0KICAgIGtpbGxfcHJvYyhwcml2LT5waWQsU0lHSFVQLDEpOw0KICAg
IHdhaXRfZm9yX2NvbXBsZXRpb24oJnByaXYtPmV4aXRlZCk7DQogICAgcHJp
di0+cGlkPTA7DQogIH0NCn0NCg0Kc3RhdGljIGludCBrdF9wcm9jX3JlYWQo
Y2hhciogYnVmLGNoYXIqKiBzdGFydCxvZmZfdCBvZmZzZXQsaW50IA0KY291
bnQsaW50KiBlb2Ysdm9pZCogZGF0YSkNCnsNCiAgICBrdF9wcml2X3QqIHBy
aXY9KGt0X3ByaXZfdCopZGF0YTsNCiAgICBpbnQgbGVuPTA7DQogICAgbGVu
Kz1zcHJpbnRmKGJ1ZitsZW4sIm50aHJlYWRzID0gJWRcbiIscHJpdi0+bnRo
cmVhZHMpOw0KICAgIGxlbis9c3ByaW50ZihidWYrbGVuLCJwaWQgICAgICA9
ICVkXG4iLHByaXYtPnBpZCk7DQogICAgKmVvZj0xOw0KICAgIHJldHVybiBs
ZW47DQp9DQoNCnN0YXRpYyBpbnQga3RfcHJvY193cml0ZShzdHJ1Y3QgZmls
ZSAqZmlsZSwgY29uc3QgY2hhciAqYnVmZmVyLCB1bnNpZ25lZCANCmxvbmcg
Y291bnQsIHZvaWQgKmRhdGEpDQp7DQogICAgY2hhciAqYnVmOw0KICAgIGt0
X3ByaXZfdCogcHJpdj0oa3RfcHJpdl90KilkYXRhOw0KICAgIGludCByYyA9
IGNvdW50Ow0KICAgIGlmIChjb3VudDwxKQ0KICAgIHsNCiAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQogICAgfQ0KICAgIGJ1ZiA9IHZtYWxsb2MoY291bnQr
MSk7DQogICAgaWYgKCFidWYpIHJldHVybiAtRU5PTUVNOw0KICAgIGJ1Zltj
b3VudF09J1wwJzsNCiAgICBpZiAoY29weV9mcm9tX3VzZXIoYnVmLGJ1ZmZl
cixjb3VudCkpDQogICAgew0KICAgICAgIHJjPS1FRkFVTFQ7DQogICAgICAg
Z290byBvdXQ7DQogICAgfQ0KICAgIHN3aXRjaCAoYnVmWzBdKQ0KICAgIHsN
CiAgICBjYXNlICcrJzoNCiAgICAgICAga3Rfc3RhcnQocHJpdik7DQogICAg
ICAgIGJyZWFrOw0KICAgIGNhc2UgJy0nOg0KICAgICAgICBrdF9zdG9wKHBy
aXYpOw0KICAgICAgICBicmVhazsNCiAgICB9DQogICAgb3V0Og0KICAgIHZm
cmVlKGJ1Zik7DQogICAgcmV0dXJuIHJjOw0KfQ0KDQpzdGF0aWMgY2hhciog
a3RfcHJvY19uYW1lPSJrdGhyZWFkIjsNCg0Kc3RhdGljIGludCBrdF9tb2Rf
aW5pdCh2b2lkKQ0Kew0KICBzdHJ1Y3QgcHJvY19kaXJfZW50cnkgKnA7IA0K
ICBrdF9wcml2X3QqIHByaXY9JnRoZV9kYXRhOw0KICBtZW1zZXQocHJpdiww
LHNpemVvZigqcHJpdikpOw0KICBwPWNyZWF0ZV9wcm9jX3JlYWRfZW50cnko
a3RfcHJvY19uYW1lLDA2NjYsTlVMTCxrdF9wcm9jX3JlYWQscHJpdik7DQog
IGlmIChwKSB7DQogICAgU0VUX01PRFVMRV9PV05FUihwKTsNCiAgICBwLT53
cml0ZV9wcm9jPWt0X3Byb2Nfd3JpdGU7DQogIH0NCiAgcmV0dXJuIDA7DQp9
DQoNCnN0YXRpYyB2b2lkIGt0X21vZF9leGl0KHZvaWQpDQp7DQogIGt0X3N0
b3AoJnRoZV9kYXRhKTsNCiAgcmVtb3ZlX3Byb2NfZW50cnkoa3RfcHJvY19u
YW1lLE5VTEwpOw0KfQ0KDQptb2R1bGVfaW5pdChrdF9tb2RfaW5pdCk7DQpt
b2R1bGVfZXhpdChrdF9tb2RfZXhpdCk7DQoNCk1PRFVMRV9BVVRIT1IoIlZs
YWRpbWlyIEtvbmRyYXRpZXYgPHZsYWRpbWlyLmtvbmRyYXRpZXZAaW50ZWwu
Y29tPiIpOw0KTU9EVUxFX0RFU0NSSVBUSU9OKCJLZXJuZWwgdGhyZWFkIGV4
YW1wbGUiKTsNCk1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCg==

--1678434306-958052311-1062610523=:29263--
