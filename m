Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbTKCSwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTKCSwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:52:21 -0500
Received: from northuist.CNS.CWRU.Edu ([129.22.104.60]:41366 "EHLO
	ims-msg.TIS.CWRU.Edu") by vger.kernel.org with ESMTP
	id S263091AbTKCSwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:52:19 -0500
Date: Mon, 03 Nov 2003 18:52:25 +0000
From: Dan Bernard <djb29@cwru.edu>
Subject: Re: kernel: i8253 counting too high! resetting..
In-reply-to: <20031103051603.GE530@alpha.home.local>
To: Willy Tarreau <willy@w.ods.org>
Cc: CN <cnliou9@fastmail.fm>, linux-kernel@vger.kernel.org
Mail-followup-to: Dan Bernard <djb29@cwru.edu>,
 Willy Tarreau <willy@w.ods.org>, CN <cnliou9@fastmail.fm>,
 linux-kernel@vger.kernel.org
Message-id: <20031103185225.GA74441%djb29@cwru.edu>
MIME-version: 1.0
X-Mailer: Mutt 1.4.1i-JA.1 [JP] (FreeBSD i386)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=82I3+IH0IqGh5yIs
Content-disposition: inline
References: <20031029075010.596C57A6C6@smtp.us2.messagingengine.com>
 <20031030171235.GA59683@teraz.cwru.edu>
 <20031031050439.E03B17E2B8@smtp.us2.messagingengine.com>
 <200310310040.19519.gene.heskett@verizon.net>
 <20031031063636.GA61826@teraz.cwru.edu>
 <20031103044155.8D0067DF67@server2.messagingengine.com>
 <20031103051603.GE530@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 20031103 0616, Willy Tarreau wrote:
> There's a simple reason for what you see : this message was introduced in
> 2.4.21 to detect buggy hardware. Before 2.4.21, you only had the luck to
> see time go backwards without any apparent reason. There was a very long
> thread about gettimeofday() jumping backwards a few months ago in which
> you may find detailed informations about this problem.

That would be the other piece that I'm currently missing regarding the ALi
M5819P on the TM5800.  On similar "buggy hardware" roughly eight months ago,
I got the mysterious chronometer jumps, although none seemed to go backwards
in time.  Whenever I watched it, it seemed normal, although when I left it
alone, the clock, on average, advanced only a few hours per day.  I saw
this problem persist up to 2.4.20, when I lost hope on that machine and
turned it into a FreeBSD workstation.  I do not currently remember whether
it had any ALi chipsets, and I never saw any weird messages, probably
because I never installed any Linux kernels after 2.4.20.  Maybe if I run
across any Knoppix CD's with recent kernels, I could test that machine
for the i8253 messages, but that is not likely at the moment.

Regards,
Dan Bernard


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (FreeBSD)

iD8DBQE/pqPpkv1ulvlcHpMRAnxNAJ9bJF9ygyBc4nsUZCIRfBd71SfsFgCfdHkQ
ffBhzEE1s2np4LwSpuT57So=
=HLom
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

