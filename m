Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135731AbRDTHcZ>; Fri, 20 Apr 2001 03:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135739AbRDTHcP>; Fri, 20 Apr 2001 03:32:15 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:9224 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135731AbRDTHcG>; Fri, 20 Apr 2001 03:32:06 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: "J . A . Magallon" <jamagallon@able.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ac10 ide-cd oopses on boot
Date: Fri, 20 Apr 2001 09:05:00 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  charset="US-ASCII";
  boundary="------------Boundary-00=_C0X2I4YO84THM71S6FU3"
In-Reply-To: <20010420004914.A1052@werewolf.able.es>
In-Reply-To: <20010420004914.A1052@werewolf.able.es>
MIME-Version: 1.0
Message-Id: <01042009050000.06427@antares>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_C0X2I4YO84THM71S6FU3
Content-Type: text/plain;
  charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

On Friday 20 April 2001 00:49, J . A . Magallon wrote:
> Hi,
>
> Just built 2.4.3-ac10 and got an oops when booting. It tries to detect
> the CD and gives the oops.
> >>EIP; c01bfc7c <cdrom_get_entry+1c/50>   <=3D=3D=3D=3D=3D

This appears to be a known problem. Jens Axboe sent a patch in a differen=
t
thread ("SD-W2002 DVD-RAM") that fixes this. I am including it
here for your convenience. (The patch is against 2.4.4-pre4 + Jens'=20
latest fixes.)=20

Stefan

=00
--------------Boundary-00=_C0X2I4YO84THM71S6FU3
Content-Type: text/plain;
  name="cd-get-entry-1"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cd-get-entry-1"

LS0tIGRyaXZlcnMvY2Ryb20vY2Ryb20uY34JVGh1IEFwciAxOSAxMzo0NDo0NiAyMDAxCisrKyBk
cml2ZXJzL2Nkcm9tL2Nkcm9tLmMJVGh1IEFwciAxOSAxMzo0NTozMyAyMDAxCkBAIC0zNTAsNiAr
MzUwLDEyIEBACiB7CiAJaW50IGksIG5yLCBmb287CiAKKwlpZiAoIWNkcm9tX251bWJlcnMpIHsK
KwkJaW50IG5fZW50cmllcyA9IENEUk9NX01BWF9DRFJPTVMgLyAoc2l6ZW9mKHVuc2lnbmVkIGxv
bmcpICogOCk7CisJCWNkcm9tX251bWJlcnMgPSBrbWFsbG9jKG5fZW50cmllcyAqIHNpemVvZih1
bnNpZ25lZCBsb25nKSwgR0ZQX0tFUk5FTCk7CisJCW1lbXNldChjZHJvbV9udW1iZXJzLCAwLCBu
X2VudHJpZXMgKiBzaXplb2YodW5zaWduZWQgbG9uZykpOworCX0KKwogCW5yID0gMDsKIAlmb28g
PSAtMTsKIAlmb3IgKGkgPSAwOyBpIDwgQ0RST01fTUFYX0NEUk9NUyAvIChzaXplb2YodW5zaWdu
ZWQgbG9uZykgKiA4KTsgaSsrKSB7CkBAIC0yNjk2LDEwICsyNzAyLDYgQEAKIAogc3RhdGljIGlu
dCBfX2luaXQgY2Ryb21faW5pdCh2b2lkKQogewotCWludCBuX2VudHJpZXMgPSBDRFJPTV9NQVhf
Q0RST01TIC8gKHNpemVvZih1bnNpZ25lZCBsb25nKSAqIDgpOwotCi0JY2Ryb21fbnVtYmVycyA9
IGttYWxsb2Mobl9lbnRyaWVzICogc2l6ZW9mKHVuc2lnbmVkIGxvbmcpLCBHRlBfS0VSTkVMKTsK
LQogI2lmZGVmIENPTkZJR19TWVNDVEwKIAljZHJvbV9zeXNjdGxfcmVnaXN0ZXIoKTsKICNlbmRp
ZgoA

--------------Boundary-00=_C0X2I4YO84THM71S6FU3--
