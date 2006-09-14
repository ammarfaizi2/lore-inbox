Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWINHte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWINHte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWINHte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:49:34 -0400
Received: from agent.admingilde.org ([213.95.21.5]:54201 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751443AbWINHtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:49:33 -0400
Date: Thu, 14 Sep 2006 09:49:22 +0200
From: Martin Waitz <tali@admingilde.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 1/11] LTTng-core 0.5.108 : build
Message-ID: <20060914074922.GR17042@admingilde.org>
Mail-Followup-To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
	Michel Dagenais <michel.dagenais@polymtl.ca>
References: <20060914034030.GB2194@Krystal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tZCmRiovzb4sxAVa"
Content-Disposition: inline
In-Reply-To: <20060914034030.GB2194@Krystal>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tZCmRiovzb4sxAVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Sep 13, 2006 at 11:40:30PM -0400, Mathieu Desnoyers wrote:
> 1- LTTng menu options and Makefiles

adding Makefiles before the needed .c files breaks bisecting.

> (do not enable blktrace for now : kernel/relay.o is disabled)

If kernel/relay.c becomes obsolete, then perhaps this should be a separate
patch, removing it entirely.

--=20
Martin Waitz

--tZCmRiovzb4sxAVa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFCQmCj/Eaxd/oD7IRAp6UAJ9h+wwXnE+gNzy38rDOQ0Jds40amQCggCz0
W7+0JPtO4+bAKALD02Nqt/o=
=YRyj
-----END PGP SIGNATURE-----

--tZCmRiovzb4sxAVa--
