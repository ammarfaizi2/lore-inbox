Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVAVGUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVAVGUY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 01:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVAVGUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 01:20:24 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:17088 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262576AbVAVGUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 01:20:16 -0500
Message-ID: <41F1F070.1080103@kolivas.org>
Date: Sat, 22 Jan 2005 17:19:28 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>	<87oefkd7ew.fsf@sulphur.joq.us>	<10752.195.245.190.93.1106211979.squirrel@195.245.190.93>	<65352.195.245.190.94.1106240981.squirrel@195.245.190.94>	<41F19907.2020809@kolivas.org> <87k6q6c7fz.fsf@sulphur.joq.us>
In-Reply-To: <87k6q6c7fz.fsf@sulphur.joq.us>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF7ED2A21AA45652768EA23B9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF7ED2A21AA45652768EA23B9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>Here's fresh results on more stressed hardware (on ext3) with
>>2.6.11-rc1-mm2 (which by the way has SCHED_ISO v2 included). The load
>>hovering at 50% spikes at times close to 70 which tests the behaviour
>>under iso throttling.
> 
> 
> What version of JACK are you running (`jackd --version')?
> 
> You're still getting zero Delay Max.  That is an important measure.

Oops I haven't updated it on this machine.

jackd version 0.99.0 tmpdir /tmp protocol 13

Con

--------------enigF7ED2A21AA45652768EA23B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8fBwZUg7+tp6mRURAqL9AKCLYIWFaxc9tcyYP7upu4JiHnwmtgCgjCUy
KrDT1gYTKCkCH5JUw0avFD4=
=zypg
-----END PGP SIGNATURE-----

--------------enigF7ED2A21AA45652768EA23B9--
