Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVBOVV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVBOVV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVBOVV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:21:56 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17935 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261892AbVBOVVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 16:21:40 -0500
Message-Id: <200502152121.j1FLLMcP024112@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Diego Calleja <diegocg@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       prakashp@arcor.de, paolo.ciarrocchi@gmail.com, gregkh@suse.de,
       pmcfarland@downeast.net, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Optimizing disk-I/O [was Re: [ANNOUNCE] hotplug-ng 001 release] 
In-Reply-To: Your message of "Tue, 15 Feb 2005 13:56:14 CST."
             <20050215195614.GT23424@austin.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050215004329.5b96b5a1.diegocg@gmail.com>
            <20050215195614.GT23424@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1108502482_4257P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Feb 2005 16:21:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1108502482_4257P
Content-Type: text/plain; charset=us-ascii

On Tue, 15 Feb 2005 13:56:14 CST, Linas Vepstas said:

> Now I like this idea. It need not have anything to do with startup,
> or with any particular program or distro whatsoever.  Rather, one 
> would have a daemon keeping track of disk i/o patterns, and constantly 
> trying to figure out if there is a rearrangement of the sectors on disk
> that would minimize i/o seeks based on past uasge. 

More prior art - a company called FDR made a disk compactor product for IBM's
OS series, and I seem to remember a SHARE (IBM mainframe user group) tape that
had a program to read the I/O trace table and generate an optimal "what goes
where" command stream for FDR's software.  Again a late 70s to early 80s thing.

(Probably not enough to be "prior art" by itself, but certainly goes towards
the "obviousness to a practitioner in the field" criteria - if *I* knew about it
as a junior sysadmin at a college in middle-of-nowhere upstate NY knew about
it in 1983.. ;)


--==_Exmh_1108502482_4257P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCEmfScC3lWbTT17ARAsQ8AKCM/Cknozx1DdJCh9dO7fO3jYGCiwCgpQ9K
1lEbhdr6zeW7biyQcZ5YhB8=
=3FOR
-----END PGP SIGNATURE-----

--==_Exmh_1108502482_4257P--
