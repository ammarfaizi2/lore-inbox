Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWCMWxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWCMWxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWCMWxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:53:15 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:48334 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964835AbWCMWxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:53:14 -0500
References: <200603131906.11739.kernel@kolivas.org> <4415F49C.8020208@bigpond.net.au>
Message-ID: <cone.1142290371.837084.5853.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH][2/4] sched: add discrete weighted cpu load function
Date: Tue, 14 Mar 2006 09:52:51 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-5853-1142290371-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-5853-1142290371-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Peter Williams writes:

> Con Kolivas wrote:
>> +unsigned long weighted_cpuload(const int cpu)
>> +{
>> +	return (cpu_rq(cpu)->raw_weighted_load);
>> +}
>> +
> 
> Wouldn't this be a candidate for inlining?

That would make it unsuitable for exporting via sched.h.

Cheers,
Con


--=_mimegpg-kolivas.org-5853-1142290371-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEFffDZUg7+tp6mRURAj7xAJ4xE61rvewXm1cvYSeo+PJXaZrXjQCgjAfq
gynvM1f3pCsiwYvgLzH46Lk=
=EEVC
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-5853-1142290371-0001--
