Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283231AbRK2N7C>; Thu, 29 Nov 2001 08:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283230AbRK2N6n>; Thu, 29 Nov 2001 08:58:43 -0500
Received: from ns.caldera.de ([212.34.180.1]:1923 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S283229AbRK2N6i>;
	Thu, 29 Nov 2001 08:58:38 -0500
Date: Thu, 29 Nov 2001 14:58:28 +0100
Message-Id: <200111291358.fATDwSh32089@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: maftoul@esrf.fr (Samuel Maftoul)
Cc: linux-kernel@vger.kernel.org
Subject: Re: rpm builder of kernel image
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20011129143411.A3221@pcmaftoul.esrf.fr>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011129143411.A3221@pcmaftoul.esrf.fr> you wrote:
> Hello everyone,
> I'm searching for something on Rpm based distributions.
> I'm usually using debian and whenever I recompile my kernel I use the
> make-kpkg buildpackage in the /usr/src/linux directory to have a nice
> debian pacakge with creates the lilo image (I'm using grub but whatever
> :) ).
> Is there such a tool for redhat based distribution or at least only for
> the suse (7.2 or 7.3) ?
> Thanks for any help.

You might want to take a look at make-krpm [1], currently I only have
support for Caldera and a default target that might work or not work
for others.  I accept patches..

	Christoph

[1] ftp://ftp.openlinux.org/pub/people/hch/make-krpm/
-- 
Whip me.  Beat me.  Make me maintain AIX.
