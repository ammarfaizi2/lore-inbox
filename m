Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272321AbTGYUsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272367AbTGYUrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:47:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:64017
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272321AbTGYUrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:47:02 -0400
Date: Fri, 25 Jul 2003 14:02:09 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Meelis Roos <mroos@math.ut.ee>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, neilb@cse.unsw.edu.au
Subject: Re: NFS server broken in 2.4.22-pre6?
Message-ID: <20030725210209.GC1686@matchmail.com>
Mail-Followup-To: Meelis Roos <mroos@math.ut.ee>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, neilb@cse.unsw.edu.au
References: <Pine.LNX.4.55L.0307251001480.12492@freak.distro.conectiva> <Pine.GSO.4.44.0307252330160.23197-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0307252330160.23197-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 11:30:49PM +0300, Meelis Roos wrote:
> > > NFS serving seems to be broken in 2.4.22-pre6. I had 2 computers running
> > > 2.4.22-pre6 (x86, debian unstable current). Tried to acces them via NFS
> > > (using am-utils actually) from a 3rd computer, IO error. Tried to
> > > mount directly, mount: RPC: timed out. Rebooted one computer to 2.4.18
> > > and NFS started to work.
> > >
> > > No more details currently but I can test more thoroughly tomorrow.
> >
> > Meelis,
> >
> > Please report more details.
> 
> Seems to be a debian unstable problem with nfs-kernel-server:
> http://bugs.debian.org/201598

I just shut down 2.4.22-pre7 to test a 2.6-test kernel, and it hung trying
to shut down the kernel nfs server.

And I just checked my version and it is a reported good version, 1.0.3-1.

I only saw it once, and I seem to recall rebooting pre7 before without
trouble, so maybe it is hard to produce. :-/

Mike
