Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVAWBDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVAWBDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 20:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVAWBDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 20:03:41 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:31668 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261172AbVAWBDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 20:03:37 -0500
Message-ID: <41F2F7C1.70404@kolivas.org>
Date: Sun, 23 Jan 2005 12:02:57 +1100
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
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>	<87oefkd7ew.fsf@sulphur.joq.us>	<10752.195.245.190.93.1106211979.squirrel@195.245.190.93>	<65352.195.245.190.94.1106240981.squirrel@195.245.190.94>	<41F19907.2020809@kolivas.org> <87k6q6c7fz.fsf@sulphur.joq.us>	<41F1F735.1000603@kolivas.org> <41F1F7AF.7000105@kolivas.org>	<41F1FC1D.10308@kolivas.org> <87wtu55i3x.fsf@sulphur.joq.us>
In-Reply-To: <87wtu55i3x.fsf@sulphur.joq.us>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6AD52CF3754AF51EDB84051E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6AD52CF3754AF51EDB84051E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>So let's try again, sorry about the noise:
>>
>>==> jack_test4-2.6.11-rc1-mm2-fifo.log <==
>>*********************************************
>>XRUN Count  . . . . . . . . . :     3
>>Delay Maximum . . . . . . . . : 20161   usecs
>>*********************************************
>>
>>==> jack_test4-2.6.11-rc1-mm2-iso.log <==
>>*********************************************
>>XRUN Count  . . . . . . . . . :     6
>>Delay Maximum . . . . . . . . :  4604   usecs
>>*********************************************
>>
>>Pretty pictures:
>>http://ck.kolivas.org/patches/SCHED_ISO/iso2-benchmarks/
> 
> 
> Neither run exhibits reliable audio performance.  There is some low
> latency performance problem with your system.  Maybe ReiserFS is
> causing trouble even with logging turned off.  Perhaps the problem is
> somewhere else.  Maybe some device is misbehaving.
> 
> Until you solve this problem, beware of drawing conclusions.

Sigh.. I guess you want me to do all the benchmarking. Well it's easy 
enough to get good results. I'll simply turn off all services and not 
run a desktop. This is all on ext3 on a fully laden desktop by the way, 
but if you want to get the results you're looking for I can easily drop 
down to a console and get perfect results.

Con

--------------enig6AD52CF3754AF51EDB84051E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8vfFZUg7+tp6mRURAggwAJ4mX02HL339gbiOBzqNpCeWvrkI5gCfaS0J
3G+8xq6A9rJmeL9gNFNXun4=
=C7j7
-----END PGP SIGNATURE-----

--------------enig6AD52CF3754AF51EDB84051E--
