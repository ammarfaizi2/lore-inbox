Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268176AbUHYRZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268176AbUHYRZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268174AbUHYRZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:25:15 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:10881 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S268169AbUHYRXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:23:38 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Possible dcache BUG
Date: Wed, 25 Aug 2004 10:23:29 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408242233.55583.gene.heskett@verizon.net> <150920000.1093445730@[10.10.2.4]>
In-Reply-To: <150920000.1093445730@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1405242.WGXb78emFP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408251023.32434.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1405242.WGXb78emFP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 25 August 2004 07:55, Martin J. Bligh wrote:
> This whole thread makes me think ... if we oops, shouldn't we check if
> we're holding any spinlocks or semaphores, and just panic the whole
> machine if so? Not sure how expensive it would be to hold that state,
> but ...

On preempt, wouldn't it just be a matter of checking preempt_count?

-Ryan

--nextPart1405242.WGXb78emFP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBLMsUW4yVCW5p+qYRAnAFAJ4x6noJHenEX9RbQwhNMbyx6HYv+wCffn5D
krKZNyUpJbeVwtNgxxuV05A=
=Tzrz
-----END PGP SIGNATURE-----

--nextPart1405242.WGXb78emFP--
