Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTGIRkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTGIRkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:40:46 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:21254 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264271AbTGIRkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:40:45 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ->direct_IO API change in current 2.4 BK
Date: Wed, 9 Jul 2003 19:55:08 +0200
User-Agent: KMail/1.5.2
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrea Arcangeli <andrea@suse.de>,
       Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
References: <20030709133109.A23587@infradead.org> <200307091943.13680.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0307091445470.27004@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0307091445470.27004@freak.distro.conectiva>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307091954.12895.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 July 2003 19:46, Marcelo Tosatti wrote:

Hi Marcelo,

> > > > > I just got a nice XFS oops due to the direct_IO API change in
> > > > > 2.4.  Guys, this is a STABLE series and APIs are supposed to be
> > > > > exactly that, _STABLE_.  If you really think O_DIRECT on NFS is soo
> > > > > important please add a ->direct_IO2 for NFS like the reiserfs
> > > > > read_inode2 hack.
> >
> > I wonder why -aa and -wolk don't have these problems with O_DIRECT vs.
> > XFS.
> Do they have the NFS DIRECT IO patch?
Yes. If not, my sentence would be superflous ;)

ciao, Marc

