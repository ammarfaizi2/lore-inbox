Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270645AbRIWR4B>; Sun, 23 Sep 2001 13:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272369AbRIWRzv>; Sun, 23 Sep 2001 13:55:51 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:39496 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S270645AbRIWRzs>; Sun, 23 Sep 2001 13:55:48 -0400
Date: Sun, 23 Sep 2001 12:55:39 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David Cinege <dcinege@psychosis.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initrd Dynamic v4.2 - New Feature: Tmpfs root support
In-Reply-To: <Pine.GSO.4.21.0109230415460.14886-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.96.1010923125451.12340A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2001, Alexander Viro wrote:
> As for the code... _all_ you need on the kernel side is "unpack <some_archive>
> to ramfs/tmpfs and do exec()".  That's it.  The rest can be done in userland.
> That includes the logics with loading ramdisk from initrd/floppies, handling
> nfsroot, choosing final root device, yodda, yodda.  And yes, I consider
> ripping that logics from the kernel space a Good Thing(tm).

...as do others...

