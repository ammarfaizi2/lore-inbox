Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVAWBcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVAWBcX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 20:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVAWBcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 20:32:23 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:25815 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261175AbVAWBcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 20:32:17 -0500
Message-ID: <41F2FE81.7020002@kolivas.org>
Date: Sun, 23 Jan 2005 12:31:45 +1100
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
 boundary="------------enig768F33D329CA6F353B9011BA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig768F33D329CA6F353B9011BA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> 
> Neither run exhibits reliable audio performance.  There is some low
> latency performance problem with your system.  Maybe ReiserFS is
> causing trouble even with logging turned off.  Perhaps the problem is
> somewhere else.  Maybe some device is misbehaving.
> 
> Until you solve this problem, beware of drawing conclusions.

The idea is to get equivalent performance to SCHED_FIFO. The results 
show that much, and it is 100 times better than unprivileged 
SCHED_NORMAL. The fact that this is an unoptimised normal desktop 
environment means that the conclusion we _can_ draw is that SCHED_ISO is 
as good as SCHED_FIFO for audio on the average desktop. I need someone 
with optimised hardware setup to see if it's as good as SCHED_FIFO in 
the critical setup.

I'm actually not an audio person and have no need for such a setup, but 
I can see how linux would benefit from such support... ;)

Cheers,
Con

--------------enig768F33D329CA6F353B9011BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8v6GZUg7+tp6mRURAtMPAJ9H1UZDGWOr0d39kBj15OjGPzUBawCePTJo
G1gR4t3obb5BoBVEWXBFccc=
=sRTU
-----END PGP SIGNATURE-----

--------------enig768F33D329CA6F353B9011BA--
