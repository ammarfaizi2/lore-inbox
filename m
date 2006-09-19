Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWISTqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWISTqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWISTqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:46:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28088 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751082AbWISTqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:46:07 -0400
Date: Tue, 19 Sep 2006 15:45:15 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
Message-ID: <20060919194515.GB18646@redhat.com>
References: <20060919183447.GA16095@Krystal> <y0m4pv3ek49.fsf@ton.toronto.redhat.com> <20060919193623.GA9459@Krystal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20060919193623.GA9459@Krystal>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi -

On Tue, Sep 19, 2006 at 03:36:24PM -0400, Mathieu Desnoyers wrote:
> [...]
> > If you don't allow yourself to presume on-the-fly function
> > recompilation, then these markers would need to be made run-time
> > rather than compile-time configurable.  That is, not like this:
> > [...]

> By making them run-time configurable, I don't see any whay not to bloat the
> kernel. How can be embed calls to printk+function+kprobe+djprobe without
> having some kind of performance impact ?

In order to have what we appear to need, we cannot avoid having some
impact.  (Even NOPs have impact.)

Suppose that mbligh's clever but speculative idea has some nasty flaw,
once someone tried to reduce it to code.  Do you see that markers
along the lines you've posted would be unsatisfactory?  With that in
mind, is there point adding such markers now?

- FChE

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFEEjLVZbdDOm/ZT0RAhd3AJ0Rqu08opLvHdPQtnzUBBAwFlTcEQCdFPj9
hUggBYuqRXZ5Ito8qf83eEM=
=in9L
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
