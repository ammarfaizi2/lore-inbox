Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265297AbSJRRjm>; Fri, 18 Oct 2002 13:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265279AbSJRR1X>; Fri, 18 Oct 2002 13:27:23 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:59398 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S265312AbSJRQ5h>; Fri, 18 Oct 2002 12:57:37 -0400
Date: Fri, 18 Oct 2002 13:03:20 -0400
From: Ben Collins <bcollins@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
Message-ID: <20021018170320.GA540@phunnypharm.org>
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com> <Pine.NEB.4.44.0210181856330.28761-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0210181856330.28761-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 07:00:44PM +0200, Adrian Bunk wrote:
> On Tue, 15 Oct 2002, Linus Torvalds wrote:
> 
> >...
> > Summary of changes from v2.5.42 to v2.5.43
> > ============================================
> >...
> > Ben Collins <bcollins@debian.org>:
> >   o Linux IEEE-1394 Updates
> >...
> 
> This patch added an argument "flags" to the prototypes of
> sbp2_handle_physdma_write and sbp2_handle_physdma_read in
> drivers/ieee1394/sbp2.h but doesn't include the corresponding changes to
> drivers/ieee1394/sbp2.c resulting in the following compile error:

Ok. In the meantime, just disable PHY DMA for sbp2. It's a debug option
anyway. Not meant for general purpose use.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
