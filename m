Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268449AbTGIRaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268451AbTGIRaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:30:01 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:19206 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S268449AbTGIRaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:30:00 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andreas Dilger <adilger@clusterfs.com>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: ->direct_IO API change in current 2.4 BK
Date: Wed, 9 Jul 2003 19:43:13 +0200
User-Agent: KMail/1.5.2
Cc: Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
References: <20030709133109.A23587@infradead.org> <20030709100336.H4482@schatzie.adilger.int> <Pine.LNX.4.55L.0307091421070.26373@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0307091421070.26373@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307091943.13680.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 July 2003 19:24, Marcelo Tosatti wrote:

Hi,

> > > I just got a nice XFS oops due to the direct_IO API change in
> > > 2.4.  Guys, this is a STABLE series and APIs are supposed to be exactly
> > > that, _STABLE_.  If you really think O_DIRECT on NFS is soo important
> > > please add a ->direct_IO2 for NFS like the reiserfs read_inode2 hack.
I wonder why -aa and -wolk don't have these problems with O_DIRECT vs. XFS.

ciao, Marc

