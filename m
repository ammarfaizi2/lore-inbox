Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTEFPa1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTEFPa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:30:27 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:5128 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263837AbTEFPaW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:30:22 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] processes stuck in D state
Date: Tue, 6 May 2003 17:41:50 +0200
User-Agent: KMail/1.5.1
References: <200305061652.13280.fsdeveloper@yahoo.de> <shsel3c85ks.fsf@charged.uio.no>
In-Reply-To: <shsel3c85ks.fsf@charged.uio.no>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       "Lever, Charles" <Charles.Lever@netapp.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Zeev Fisher <Zeev.Fisher@il.marvell.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305061742.14032.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 06 May 2003 17:20, Trond Myklebust wrote:
> >>>>> " " == Michael Buesch <fsdeveloper@yahoo.de> writes:
>      > Hi!  Please take a look at this problem:
>      >
>      > [linux-kernel-mailing-list thread]
>      > http://marc.theaimsgroup.com/?t=98639966100003&r=1&w=2
>
> If I can hazard a guess: someone is firewalling the lockd port and/or
> the statd port.
>
> Either mount using the 'nolock' option, or fix the firewall (see the
> HOWTO and/or FAQ).

To reproduce the problem:
- - mount some nfs from a server in your lan.
- - Open an app, that uses the mounted fs. I've simply opened a
  konqueror-window for the directory where the nfs is mounted.
- - shut down or crash the server or just pull the network-cable.
- - Now the konqueror-process is nonkillable in D state. There's no
  chance to kill it.

I've tried it with all firewalls disabled, but the problem resists.

> Cheers,
>   Trond

@linux-kernel-mailing-list: I've posted a thread to nfs-mailing list with
the same topic as in lkml. IMHO this is the better list for this problem. :)

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 17:34:35 up  1:26,  5 users,  load average: 1.52, 1.32, 1.13
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+t9fWoxoigfggmSgRAvrcAJ4i+i3V+kcRd+kLHS7cb2WDZDHKsQCfWljd
rwtAFK4ONkJHzVck03t7F5U=
=gHuP
-----END PGP SIGNATURE-----

