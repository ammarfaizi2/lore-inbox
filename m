Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTJUMQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 08:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbTJUMQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 08:16:51 -0400
Received: from [212.239.225.50] ([212.239.225.50]:12416 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S263078AbTJUMQu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 08:16:50 -0400
From: Jan De Luyck <lkml@kcore.org>
To: mru@kth.se (=?iso-8859-1?q?M=E5ns?= =?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test8] Difference between Software Suspend and Suspend-to-disk?
Date: Tue, 21 Oct 2003 14:16:41 +0200
User-Agent: KMail/1.5.4
References: <200310211315.58585.lkml@kcore.org> <20031021113444.GC9887@louise.pinerecords.com> <yw1xy8veddj7.fsf@kth.se>
In-Reply-To: <yw1xy8veddj7.fsf@kth.se>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310211416.45202.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 21 October 2003 13:40, Måns Rullgård wrote:
> Tomas Szepe <szepe@pinerecords.com> writes:
> >> Software Suspend (EXPERIMENTAL)
> >> Suspend-to-Disk Support
> >
> > They're competing implementations of the same mechanism.
>
> And neither one works reliably, I might add.  They both appear to save
> the current state to disk, but no matter what I try, I can't make it
> resume properly.

Well, I could suspend/resume correctly first time I tried (runlevel 2 and 
disabling nearly everything to minimize loss of data on crash).

The second test in X resulted in a 'double fault'...

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lSOrUQQOfidJUwQRAsV8AJ0WGVwtPCvoRU+nYzp+1rEPGjHrDwCffiZz
wEG77k6o4VjLOb3dMvyLopg=
=uta/
-----END PGP SIGNATURE-----

