Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312544AbSCUWfn>; Thu, 21 Mar 2002 17:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312545AbSCUWfd>; Thu, 21 Mar 2002 17:35:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18838 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312544AbSCUWfS>;
	Thu, 21 Mar 2002 17:35:18 -0500
Date: Thu, 21 Mar 2002 17:35:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Henrik Storner <henrik@hswn.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.7] initrd issue
In-Reply-To: <200203212149.g2LLnv304455@hswn.dk>
Message-ID: <Pine.GSO.4.21.0203211734130.26423-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Mar 2002, Henrik Storner wrote:

> adasi@kernel.pl wrote:
> 
> >I was trying to use 2.5.7 with initrd. I checked almost all configuration
> >options, but it's still loading RAM-Disk in one line (ext2 filesystem
> >detected etc.) and 'freeing Xkb initrd memory' in the next one.
> 
> You are not alone. AFAICT, initrd is broken in 2.5.x - it fails
> to mount to ramdisk unless you pass "root=/dev/ram0", and if you
> do that, then it fails to switch to the real root-disk once 
> /linuxrc has executed from the ramdisk. At least, that was my 
> experience when trying it in 2.5.6 and 2.5.7.
> 
> The very same initrd-file worked fine with 2.4.18.

Mind sending your .config to me?  Last time I've checked it the thing
had worked, but that was around 2.5.4 or so.

