Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbSJDMLn>; Fri, 4 Oct 2002 08:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261579AbSJDMLn>; Fri, 4 Oct 2002 08:11:43 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48160 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261576AbSJDMLm>; Fri, 4 Oct 2002 08:11:42 -0400
Date: Fri, 4 Oct 2002 08:17:07 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] nptl 0.2
Message-ID: <20021004081707.C5659@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <3D9D51A3.3050906@redhat.com> <3D9D5D2F.5010805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9D5D2F.5010805@pobox.com>; from jgarzik@pobox.com on Fri, Oct 04, 2002 at 05:19:43AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 05:19:43AM -0400, Jeff Garzik wrote:
> Ulrich Drepper wrote:
> > You need
> [...]
> > - - the very latest in tools such as
> > 
> >   + gcc either from the current development branch or the gcc 3.2
> >     from Red Hat Linux 8;
> > 
> >   + binutils preferrably from CVS, from H.J. Lu's latest release for
> >     Linux, or from RHL 8.
> 
> or from Mandrake 9.0...

Actually, even RHL 8.0 and Mdk 9.0 binutils are too old, there
were important TLS bugfixes since then.
So either you need latest H.J. Lu's test release:
ftp://ftp.kernel.org/pub/linux/devel/binutils/test/binutils-2.13.90.0.6.tar.bz2
or my binutils rpms which have these patches backported:
ftp://people.redhat.com/jakub/binutils/2.13.90.0.4-1/

	Jakub
