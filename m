Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbTBFJxW>; Thu, 6 Feb 2003 04:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbTBFJxW>; Thu, 6 Feb 2003 04:53:22 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:39849 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id <S265872AbTBFJxV>; Thu, 6 Feb 2003 04:53:21 -0500
Date: Thu, 6 Feb 2003 10:02:32 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030206100232.GA9613@axis.demon.co.uk>
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205141104.6ae9e439.arashi@yomerashi.yi.org> <20030205233115.GB14131@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205233115.GB14131@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 03:31:15PM -0800, Larry McVoy wrote:
> We can go buy another machine for glibc2.3

Buy a machine?  Why not use UML?

  http://user-mode-linux.sourceforge.net/

umlbuilder can build Redhat 8.0 images (along with loads of others)

  http://umlbuilder.sourceforge.net/
  http://umlbuilder.sourceforge.net/distributions.shtml

There are debian root filing systems on the UML site.

Alternatively use the image created by umlbuilder and chroot into it.
Mount --bind your source directory and away you go...

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
