Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUCWMlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbUCWMlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:41:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30639 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262532AbUCWMlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:41:11 -0500
Date: Tue, 23 Mar 2004 13:40:32 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: dipankar@in.ibm.com, tiwai@suse.de, Robert Love <rml@ximian.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040323124032.GF13666@devserv.devel.redhat.com>
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com> <20040323123105.GI22639@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Content-Disposition: inline
In-Reply-To: <20040323123105.GI22639@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 23, 2004 at 01:31:05PM +0100, Andrea Arcangeli wrote:
> On Tue, Mar 23, 2004 at 11:35:06AM +0100, Arjan van de Ven wrote:
> > 
> > > Reduce bh processing time of rcu callbacks by using tunable per-cpu
> > > krcud daemeons.
> > 
> > why not just use work queues ?
> 
> I don't know if work queues are scheduler friendly, but definitely the
> rearming tasklets are. Running a dozen callbacks per pass and queueing
> any remining work to a rearming tasklet should fix it.

yeah ksoftirqd will work too indeed.

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAYDA/xULwo51rQBIRAil5AJ9okPTYwXsHFTcaBBvQUcRB9LpDaACdHDlr
Q+7lrX32vbTBZ7txCnCR+2I=
=xiKz
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--
