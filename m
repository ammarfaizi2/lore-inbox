Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUAIKSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 05:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUAIKSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 05:18:38 -0500
Received: from adsl-67-124-157-189.dsl.pltn13.pacbell.net ([67.124.157.189]:26534
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S266493AbUAIKSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 05:18:04 -0500
Date: Fri, 9 Jan 2004 02:17:59 -0800
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA 1.0.1
Message-ID: <20040109101759.GC12107@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0401082059300.13704@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401082059300.13704@pnote.perex-int.cz>
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2004 at 09:15:07PM +0100, Jaroslav Kysela wrote:
> The ALSA 1.0.1 code for 2.6 kernels is available. I think that this update
> might be included into -mm or standard 2.6 kernels.

I've tried this code with 2.6.1-mm1 and it results in my speakers
emitting a small high pitched noise when it's not busy playing audio,
using the intel8x0 driver. I'm using the onboard sound on my nForce2
based motherboard, here is the information in dmesg (not a lot,
admittedly) when i load the driver:

intel8x0_measure_ac97_clock: measured 49457 usecs
intel8x0: clocking to 47478

Otherwise it still seems to work OK.

--
Joshua Kwan

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP/5/1qOILr94RG8mAQJqWBAAwF+xbu2nGiTW0+ME5Hc9RSUsM3TABFH1
A85HhNQr9SJF+eFVaLOehS/9ddd9D3ob0zaWbzxj5TeAOOgXOn6LVR5PnrSW37Al
X5/6m8qBRv7n1eKyEtI74Y9A6B6/KZoohUQA2oySYT0wjl0t+t5Hdi9Royb7ra33
eZ2ytgLxupvHyNuhBVBsvyLCDQHunN+yDLeD5gSzUktsElzINDcnwv/aGNBDzAP+
ldYMBcFOezPVioLwnjsNbSztb43Hqpmrlh1KISsWOLIPpk4i8dCPUO3rQRbE2pGz
4qehmQZ30kToOAyaxqQr/L+beez0GE6RVuA1BuoGT6cYSg+7nm0jGkMD6+efI3Fn
1IDilTxqjyZLHKzx7e4Z780OYUHUfi68geZ1oOVUZScFQyewYMOk4YkiLYk+yHOK
GSyiiZslhDMaQ3QN05Zl5L/JcR3BFMbgW8hw0MZGpWZ0A/uFtlL7k00ABDDiDEJL
Jg246bYul4/t2rn8kr/Bg9ikuWr3NKwzE2PX56ue0i1EJYl5z1BQhgGsvJ36Mgyb
8LsUIg13IZT0Vk0fDIqsOkmLmj2yQN9eVuN7+8tYNoUgUXz2gC/auMhBLxa7ksP+
9zpTJ+9Z4qERZx3sK+E08jhJ67eBDEnGt7sAdH5C5vBgjY/Xe1MrxwbSN9X9xpwk
E7ouLw/SdIg=
=rp21
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
