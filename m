Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288623AbSBDHF3>; Mon, 4 Feb 2002 02:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288639AbSBDHFK>; Mon, 4 Feb 2002 02:05:10 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:16259 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S288623AbSBDHE7>;
	Mon, 4 Feb 2002 02:04:59 -0500
Date: Mon, 4 Feb 2002 02:04:58 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.18-pre7 Fixed typo that made compiling impossible in
 /net/ipv4/netfilter/ipfwadm_core.c
Message-ID: <Pine.LNX.4.30.0202040155370.1740-200000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-74666095-1288806725-1012806094=:1740"
Content-ID: <Pine.LNX.4.30.0202040204220.1740@rtlab.med.cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---74666095-1288806725-1012806094=:1740
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0202040204221.1740@rtlab.med.cornell.edu>


/net/ipv4/netfilter/ipfwadm_core.c has a typo.  The MOD_*_USE_COUNT macros
are being used incorrectly.  Compiling was impossible as a result.

I fixed the typos.  It's trivial, but I figured I'd submit this just to
make it easier for marcello to fix this...?  (this may have been submitted
by someone else already.. but my quick scan of the mailing list didn't
reveal anyone having patched this).

-Calin

---74666095-1288806725-1012806094=:1740
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="2.4.18-pre7_ipfwadm_core_typo_fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0202040201340.1740@rtlab.med.cornell.edu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="2.4.18-pre7_ipfwadm_core_typo_fix.patch"

LS0tIHZhbmlsbGEtMi40LjE4LXByZTcvbmV0L2lwdjQvbmV0ZmlsdGVyL2lw
ZndhZG1fY29yZS5jCU1vbiBGZWIgIDQgMDE6NDk6MTQgMjAwMg0KKysrIHBh
dGNoZWQvbmV0L2lwdjQvbmV0ZmlsdGVyL2lwZndhZG1fY29yZS5jCU1vbiBG
ZWIgIDQgMDA6NTg6NTYgMjAwMg0KQEAgLTY4OCw3ICs2ODgsNyBAQA0KIAkJ
ZnRtcCA9ICpjaGFpbnB0cjsNCiAJCSpjaGFpbnB0ciA9IGZ0bXAtPmZ3X25l
eHQ7DQogCQlrZnJlZShmdG1wKTsNCi0JCU1PRF9ERUNfVVNFX0NPVU5UKCk7
DQorCQlNT0RfREVDX1VTRV9DT1VOVDsNCiAJfQ0KIAlyZXN0b3JlX2ZsYWdz
KGZsYWdzKTsNCiB9DQpAQCAtNzMyLDcgKzczMiw3IEBADQogCWZ0bXAtPmZ3
X25leHQgPSAqY2hhaW5wdHI7DQogICAgICAgIAkqY2hhaW5wdHI9ZnRtcDsN
CiAJcmVzdG9yZV9mbGFncyhmbGFncyk7DQotCU1PRF9JTkNfVVNFX0NPVU5U
KCk7DQorCU1PRF9JTkNfVVNFX0NPVU5UOw0KIAlyZXR1cm4oMCk7DQogfQ0K
IA0KQEAgLTc4Myw3ICs3ODMsNyBAQA0KIAllbHNlDQogICAgICAgICAJKmNo
YWlucHRyPWZ0bXA7DQogCXJlc3RvcmVfZmxhZ3MoZmxhZ3MpOw0KLQlNT0Rf
SU5DX1VTRV9DT1VOVCgpOw0KKwlNT0RfSU5DX1VTRV9DT1VOVDsNCiAJcmV0
dXJuKDApOw0KIH0NCiANCkBAIC04NTgsNyArODU4LDcgQEANCiAJfQ0KIAly
ZXN0b3JlX2ZsYWdzKGZsYWdzKTsNCiAJaWYgKHdhc19mb3VuZCkgew0KLQkJ
TU9EX0RFQ19VU0VfQ09VTlQoKTsNCisJCU1PRF9ERUNfVVNFX0NPVU5UOw0K
IAkJcmV0dXJuIDA7DQogCX0gZWxzZQ0KIAkJcmV0dXJuKEVJTlZBTCk7DQo=
---74666095-1288806725-1012806094=:1740--
