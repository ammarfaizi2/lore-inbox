Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUFKGXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUFKGXQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 02:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUFKGXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 02:23:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262003AbUFKGXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 02:23:14 -0400
Date: Fri, 11 Jun 2004 08:22:56 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: ganzinger@mvista.com
Cc: Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Message-ID: <20040611062256.GB13100@devserv.devel.redhat.com>
References: <40C7BE29.9010600@am.sony.com> <1086861862.2733.6.camel@laptop.fenrus.com> <40C8F68F.4030601@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <40C8F68F.4030601@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 10, 2004 at 05:02:23PM -0700, George Anzinger wrote:
> Arjan van de Ven wrote:
> >On Thu, 2004-06-10 at 03:49, Geoff Levand wrote:
> >
> >>Available at 
> >>http://tree.celinuxforum.org/pubwiki/moin.cgi/CELinux_5fPatchArchive
> >>
> >>For those interested, the set of three patches provide POSIX high-res 
> >>timer support for linux-2.6.6.  The core and i386 patches are updates of 
> >>George Anzinger's hrtimers-2.6.5-1.0.patch available on SourceForge 
> >><http://sourceforge.net/projects/high-res-timers/>.  The ppc32 port is 
> >>not available on SourceForge yet.
> >
> >
> >My first impression is that it has WAAAAAAAAAAAY too many ifdefs. I
> >would strongly suggest to not make this a config option and just
> >mandatory, it's a core feature that has no point in being optional. If
> >you accept that, the code also becomes a *LOT* cleaner.
> >
> Yes, but...  The main problem is that this would break all the archs that 
> don't have the needed arch dependent code yet.  By making the high-res part 
> depend on the arch config turning on a config, we don't break the archs and 
> they can sign up as they get their act together.

if the price is this amount of uglyness then that's the wrong approach imo.
Would be nicer to make dummy helpers the arch people can just take during
the transition instead.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAyU+/xULwo51rQBIRArm3AKCn5trYnEG4rrYxKXZRzNqgOb43bACgkVDP
/dh67EtDhMaXi7ksoaJruF0=
=TWbr
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
