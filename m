Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbTEFQ2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTEFQ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:27:34 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:45072 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263932AbTEFQZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:25:28 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: trond.myklebust@fys.uio.no
Subject: Re: [NFS] processes stuck in D state
Date: Tue, 6 May 2003 18:30:14 +0200
User-Agent: KMail/1.5.1
References: <200305061652.13280.fsdeveloper@yahoo.de> <200305061742.14032.fsdeveloper@yahoo.de> <16055.56630.615496.19679@charged.uio.no>
In-Reply-To: <16055.56630.615496.19679@charged.uio.no>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Zeev Fisher <Zeev.Fisher@il.marvell.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305061830.25417.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 06 May 2003 18:05, Trond Myklebust wrote:
> >>>>> " " == Michael Buesch <fsdeveloper@yahoo.de> writes:
>      > To reproduce the problem:
>      > - - mount some nfs from a server in your lan.
>      > - - Open an app, that uses the mounted fs. I've simply opened a
>      >   konqueror-window for the directory where the nfs is mounted.
>      > - - shut down or crash the server or just pull the
>      >     network-cable.
>      > - - Now the konqueror-process is nonkillable in D
>      >     state. There's no
>      >   chance to kill it.
>
> Unless you are using the 'intr' or 'soft' mount flags, then that is
> *documented and expected* behaviour.

I'm using intr.

> However, as I've mentioned on this list *many* times before: there
> exists a workaround if you are wanting to kill all processes in order
> to unmount the partition:
>   kill -9 all the processes.
>   kill -9 rpciod.

kill -9 doesn't work for me to kill the app.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 18:28:55 up  2:20,  5 users,  load average: 1.02, 1.06, 1.06
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+t+MhoxoigfggmSgRAkeqAJ0c71DxLZ13/CHqUXlTa8TvjAt2iwCeLO34
s7crt56Gr8JyKxCLZMbrNvc=
=z8EU
-----END PGP SIGNATURE-----

