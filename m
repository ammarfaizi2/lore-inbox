Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVFQOp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVFQOp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 10:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVFQOpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 10:45:25 -0400
Received: from [213.69.232.60] ([213.69.232.60]:58895 "HELO ei.schottelius.org")
	by vger.kernel.org with SMTP id S261988AbVFQOoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 10:44:55 -0400
Date: Fri, 17 Jun 2005 16:44:18 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel eats argument=
Message-ID: <20050617144418.GC17910@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
References: <20050617143642.GB17910@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <20050617143642.GB17910@schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> [Does the kernel eat arguments?]

Found the answer myself:=20

init/main.c:

/*
 * Unknown boot options get handed to init, unless they look like
 * failed parameters
 */
static int __init unknown_bootoption(char *param, char *val)

Yes, it does and I'll have to use a different string.

Have a nice day,

Nico


--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQrLhwLOTBMvCUbrlAQJ07A/9GYoJPI4xSIKvDZL/BydJnWMNABQWtiul
JpTEpgK7ceNdAlScap8UtcxJvTRrfA4m4kjCIetPtxo8AGY2UugNHBnDnDO2C4je
7kkhggIsoQEQvLRQbAwWpLCxzqdsCkrJ1PP3oCIHp9H1ai6USuwpV2OaO8zKzGR0
KF4FfpDTZINMZenIhr03I58Hsw27j8hYorDi7eTqCK9bPkVHfjUDCzZfV+dQ+NDB
4xIaC1WRxbnPOy0HvGeJVwOZP4Q1HGHPFFJXA4twa8fFSwR60szerGVVtP3YSrJp
s3QwwcAhs8mHMZV979RBxBTNEG3o2paXeaN22am9IzDw5oOi4b04MUivaClSTdx+
KWaUXA056KvR1cbjVZbBj+oABkx8CLTtCW8r07s7tT0ql8a+x8bA29dNqUpf+8Xm
03nOAzOO0QwrjfaNVxLJV8rTxL2sCbvoeojrj9ZD3Fck0ZrPmWUXKI+woXsFFkHm
eH/qOV5nHnzl6LCKo4w5WNtxm//MiTzP1MkN06TEZ91LFYf0mvjJoB5k+B0kiaQQ
wNIf8u5NKnbcUxI1fmYoW5SzO4oM/ojcakyP1oMYZnvfUDwU+xIZmhcW0XLzEgpA
mMEDpBUT930AdvhcvKPmGq6OV5EXM3De0smQkJKZmzcya6cJ0FZ+K8xKoplYI7x8
HEC7jwaNlOU=
=kuhP
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
