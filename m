Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269135AbUJTWaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269135AbUJTWaC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269153AbUJTTtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:49:10 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:40590 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S269160AbUJTTiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:38:50 -0400
Message-ID: <1098301128.4176bec839f5e@imp4-q.free.fr>
Date: Wed, 20 Oct 2004 21:38:48 +0200
From: castet.matthieu@free.fr
To: linux-kernel@vger.kernel.org
Subject: fw :[patch] i810 TCO TIMER WATCHDOG request region fix
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ10983011279fec2435becaa393ca8fdeda7fa5210f"
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 82.67.62.65
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ10983011279fec2435becaa393ca8fdeda7fa5210f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi,
I sent this patch more than 1 month ago to the i810 tco maintainer. Since I have
no reply, I forward it to the lkml.

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

----- Message transféré de castet.matthieu@free.fr -----
   Date : Sat, 28 Aug 2004 22:33:32 +0200
     De : castet.matthieu@free.fr
Adresse de retour :castet.matthieu@free.fr
  Sujet : i810 TCO TIMER WATCHDOG resuaest region fix
      À : nils@kernelconcepts.de

Hello,
in i8xx_tco.c, during the initialisation, the driver make io without checking if
the port is free.

Patch attach.

Thanks

Matthieu
----- Fin du message transféré -----



---MOQ10983011279fec2435becaa393ca8fdeda7fa5210f
Content-Type: text/x-patch; name="i8xx_tco.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="i8xx_tco.patch"

LS0tIGxpbnV4LTIuNi43by9kcml2ZXJzL2NoYXIvd2F0Y2hkb2cvaTh4eF90Y28uYwkyMDA0LTA4
LTIyIDIxOjM1OjE2LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjcvZHJpdmVycy9jaGFy
L3dhdGNoZG9nL2k4eHhfdGNvLmMJMjAwNC0wOC0yMiAyMjowNDozNi4wMDAwMDAwMDAgKzAyMDAK
QEAgLTQxNSwxMiArNDE2LDE1IEBACiAJCQl9CiAJCX0KIAkJLyogU2V0IHRoZSBUQ09fRU4gYml0
IGluIFNNSV9FTiByZWdpc3RlciAqLworCQlpZiAoIXJlcXVlc3RfcmVnaW9uIChTTUlfRU4gKyAx
LCAxLCAiaTh4eCBUQ08iKSkgeworCQkJcHJpbnRrIChLRVJOX0VSUiBQRlggIkkvTyBhZGRyZXNz
IDB4JTA0eCBhbHJlYWR5IGluIHVzZVxuIiwKKwkJCQlTTUlfRU4gKyAxKTsKKwkJCXJldHVybiAw
OworCQl9CiAJCXZhbDEgPSBpbmIgKFNNSV9FTiArIDEpOwogCQl2YWwxICY9IDB4ZGY7CiAJCW91
dGIgKHZhbDEsIFNNSV9FTiArIDEpOwotCQkvKiBDbGVhciBvdXQgdGhlIChwcm9iYWJseSBvbGQp
IHN0YXR1cyAqLwotCQlvdXRiICgwLCBUQ08xX1NUUyk7Ci0JCW91dGIgKDMsIFRDTzJfU1RTKTsK
KwkJcmVsZWFzZV9yZWdpb24gKFNNSV9FTiArIDEsIDEpOwogCQlyZXR1cm4gMTsKIAl9CiAJcmV0
dXJuIDA7CkBAIC00NDMsNiArNDQ3LDEwIEBACiAJCWdvdG8gb3V0OwogCX0KIAorCS8qIENsZWFy
IG91dCB0aGUgKHByb2JhYmx5IG9sZCkgc3RhdHVzICovCisJb3V0YiAoMCwgVENPMV9TVFMpOwor
CW91dGIgKDMsIFRDTzJfU1RTKTsKKwogCS8qIENoZWNrIHRoYXQgdGhlIGhlYXJ0YmVhdCB2YWx1
ZSBpcyB3aXRoaW4gaXQncyByYW5nZSA7IGlmIG5vdCByZXNldCB0byB0aGUgZGVmYXVsdCAqLwog
CWlmICh0Y29fdGltZXJfc2V0X2hlYXJ0YmVhdCAoaGVhcnRiZWF0KSkgewogCQloZWFydGJlYXQg
PSBXQVRDSERPR19IRUFSVEJFQVQ7Cg==

---MOQ10983011279fec2435becaa393ca8fdeda7fa5210f--
