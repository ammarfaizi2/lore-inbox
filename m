Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbWISPqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbWISPqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWISPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:46:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49876 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751807AbWISPqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:46:54 -0400
Date: Tue, 19 Sep 2006 11:46:12 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919154612.GU3951@redhat.com>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qYrsQHciA3Wqs7Iv"
Content-Disposition: inline
In-Reply-To: <451008AC.6030006@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qYrsQHciA3Wqs7Iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi -

On Tue, Sep 19, 2006 at 08:11:40AM -0700, Martin J. Bligh wrote:

> [...]  Why don't we just copy the whole damned function somewhere
> else, and make an instrumented copy (as a kernel module)? Then
> reroute all the function calls through it [...]

Interesting idea.  Are you imagining this instrumented copy being
built at kernel compile time (something like building a "-g -O0"
parallel)?  Or compiled anew from original sources after deployment?
Or on-the-fly binary-level rewriting a la SPIN?

> OK, it's not completely trivial to do, but simpler than kprobes [...]

None of the three above are that easy.  Do you have an implementation
idea?


- FChE

--qYrsQHciA3Wqs7Iv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFEBDEVZbdDOm/ZT0RAgfzAJwJe38+wQbOEZ49RC1KKoXi0I/8UwCeMApv
zO9M+y47+NCkPVB0ZlDEpyo=
=qhrb
-----END PGP SIGNATURE-----

--qYrsQHciA3Wqs7Iv--
