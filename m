Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVAGWJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVAGWJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVAGWJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:09:05 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:36613 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261616AbVAGWID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:08:03 -0500
Message-Id: <200501072207.j07M7Lda004987@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/04/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, hch@infradead.org, mingo@elte.hu, chrisw@osdl.org,
       alan@lxorguk.ukuu.org.uk, joq@io.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-Reply-To: Your message of "Fri, 07 Jan 2005 13:49:41 PST."
             <20050107134941.11cecbfc.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net>
            <20050107134941.11cecbfc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1105135640_12694P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jan 2005 17:07:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1105135640_12694P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Jan 2005 13:49:41 PST, Andrew Morton said:

> Chris Wright <chrisw@osdl.org> wrote:

> > Last I checked they could be controlled separately in that module.  It
> > has been suggested (by me and others) that one possible solution would
> > be to expand it to be generic for all caps.
> 
> Maybe this is the way?

We already *know* how to (in principle) fix the capabilities system to make
it useful.  We should probably investigate doing that and at the same time
fixing the current CAP_SYS_ADMIN mess (which we also have at least some ideas
on fixing). The remaining problem is possible breakage of software that's doing
capability things The Old Way (as the inheritance rules are incompatible).

Linus at one time said that a 2.7 might open if there was some issue that
caused enough disruption to require a fork - could this be it, or does somebody
have a better way to address the backward-combatability problem?

--==_Exmh_1105135640_12694P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB3wgYcC3lWbTT17ARAp3DAJ4heXJkqlHsHju5KeE1CY/+QQCB2QCdFqT1
koSCUMxj+A4rvLsDElNHqa8=
=f5kY
-----END PGP SIGNATURE-----

--==_Exmh_1105135640_12694P--
