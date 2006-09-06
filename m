Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWIFV51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWIFV51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 17:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWIFV51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 17:57:27 -0400
Received: from main.gmane.org ([80.91.229.2]:32944 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932205AbWIFV50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 17:57:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: alternatives to getrusage() ?
Date: Wed, 06 Sep 2006 23:56:42 +0200
Message-ID: <edng6u$kcc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3B94A1DEE6C4BADC596C0280"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-146-169.pools.arcor-ip.net
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3B94A1DEE6C4BADC596C0280
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

first, if this is the wrong place to ask, then i'm sorry and please
recomm a better place to me.


My goal is to do some precise benchmarking/profiling.

I am looking for (Linux specific) alternatives to getrusage().
As far as i understand, the precision of getrusage() is given by the
timer frequency that can be adjusted in recent kernel-versions. I think
i have the choice between 100Hz, 250Hz and 1000Hz. By chosing 1000Hz, i
get a precision of 1ms, right?

On the other hand, there are things like rdtsc() which reads the clock
counter of the CPU. So does the linux kernel currently provide a
process-specific value which counts the CPU clocks "consumed" by a
process? Maybe there are some patches?

Are there other alternatives that i didn't think about yet?

Are there maybe some kernel-unrelated alternatives?


Thanks,

  Sven


--------------enig3B94A1DEE6C4BADC596C0280
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/0Qa7Ww7FjRBE4ARAqZBAKDnamE9HQ3kOWDecB8NJWkGUevfhwCfZhTt
3gG05+LqGvVvLftpT+opT88=
=Ju2T
-----END PGP SIGNATURE-----

--------------enig3B94A1DEE6C4BADC596C0280--

