Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261694AbSJFQRr>; Sun, 6 Oct 2002 12:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbSJFQRB>; Sun, 6 Oct 2002 12:17:01 -0400
Received: from altus.drgw.net ([209.234.73.40]:45579 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S261694AbSJFQQf>;
	Sun, 6 Oct 2002 12:16:35 -0400
Date: Sun, 6 Oct 2002 11:49:46 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2)
Message-ID: <20021006164946.GD878@altus.drgw.net>
References: <torvalds@transmeta.com> <Pine.LNX.4.33.0210021730170.22980-100000@penguin.transmeta.com> <13691.1033635939@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13691.1033635939@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 10:05:39AM +0100, David Howells wrote:
> 
> Linus Torvalds wrote:
> > On Wed, 2 Oct 2002, David Howells wrote:
> > >
> > > This patch adds an Andrew File System (AFS) driver to the
> > > kernel. Currently it only provides read-only, uncached, non-automounted
> > > and unsecured support.
> >
> > Are you sure this is the right way to go?
> 
> I think so. I think it makes sense for the AFS VFS-interface to go as directly
> as possible to the network without having to make context switches to get into
> userspace.

Hrrm, well, I'm in the middle of deploying AFS (moving away from NFS), and 
one of the ideas I toyed with was how to get a diskless AFS client. (yeah, 
that sounds silly at first, 2GB disks used to be large, not systems with 
2GB of ram are common.) A mostly kernel-based implementation of AFS would 
be quite usefull for this. (and the remaining bits could be in an 
initramfs)

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
