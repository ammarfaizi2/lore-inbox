Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVIVV6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVIVV6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVIVV6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:58:03 -0400
Received: from pat.uio.no ([129.240.130.16]:37035 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751284AbVIVV6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:58:02 -0400
Subject: Re: [Fwd: [Fwd: [Fwd: Re: 2.6.13-mm2]]]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: cel@citi.umich.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43330970.9030006@citi.umich.edu>
References: <43330970.9030006@citi.umich.edu>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 17:57:48 -0400
Message-Id: <1127426268.8365.174.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.085, required 12,
	autolearn=disabled, AWL 0.92, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 22.09.2005 Klokka 15:43 (-0400) skreiv Chuck Lever:
> attached please find the original message containing the pmap reserved 
> port patch.

There's just one problem: it won't apply to my tree. Looks like this is
relative to something you haven't merged yet.

Cheers,
  Trond

> e-postmelding vedlegg ([Fwd: [Fwd: Re: 2.6.13-mm2]])
> to den 22.09.2005 Klokka 15:43 (-0400) skreiv Chuck Lever:
> > andrew-
> > 
> > please replace the one-liner that adds "xprt->resvport = 0;" to 
> > net/sunrpc/clnt.c with the attached patch.
> > 
> > i haven't heard confirmation from dominik on this, but trond and i 
> > suspect this is a reasonable replacement for the original patch.
> > e-postmelding vedlegg ([Fwd: Re: 2.6.13-mm2])
> > to den 22.09.2005 Klokka 15:43 (-0400) skreiv Chuck Lever:
> > > Looks like one of your patches...
> > > e-postmelding vedlegg, "Vidaresendt melding - Re: 2.6.13-mm2"
> > > to den 22.09.2005 Klokka 15:43 (-0400) skreiv Chuck Lever:
> > > > Dominik Karall <dominik.karall@gmx.net> wrote:
> > > > >
> > > > > On Thursday 08 September 2005 14:30, Andrew Morton wrote:
> > > > >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13
> > > > >  >-mm2/
> > > > > 
> > > > >  I have problems using NFS with 2.6.13-mm2, it failes to start, but works with 
> > > > >  2.6.13-ck1 (so pure 2.6.13 should work too, as there are no nfs related 
> > > > >  changes in -ck, I think).
> > > > >  Following messages appear in /var/log/messages:
> > > > > 
> > > > >  Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> > > > >  rpc.statd[15041]: Version 1.0.7 Starting
> > > > >  NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> > > > >  NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
> > > > >  NFSD: starting 90-second grace period
> > > > >  portmap[15048]: connect from 127.0.0.1 to set(nfs): request from unprivileged 
> > > > >  port
> > > > >  nfsd[15046]: nfssvc: Permission denied
> > > > > 
> > > > > 
> > > > >  with 2.6.13-ck1:
> > > > > 
> > > > >  Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> > > > >  rpc.statd[16126]: Version 1.0.7 Starting
> > > > >  NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
> > > > >  NFSD: starting 90-second grace period
> > > > 
> > > > OK.  We don't have many nfsd patches at all in 2.6.13-mm2.  But there are
> > > > quite a few sunrpc changes.  Plus I have a few random nfs patches which
> > > > should be merged up or dropped.
> > > > 
> > > > In short: dunno.  Relevant people cc'ed ;)

