Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130045AbRCAVQF>; Thu, 1 Mar 2001 16:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130016AbRCAVPR>; Thu, 1 Mar 2001 16:15:17 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24740 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130043AbRCAVOY>;
	Thu, 1 Mar 2001 16:14:24 -0500
Date: Thu, 1 Mar 2001 16:13:38 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Pavel Machek <pavel@suse.cz>, Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
In-Reply-To: <3A9EB984.C1F7E499@transmeta.com>
Message-ID: <Pine.GSO.4.21.0103011608360.11577-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Mar 2001, H. Peter Anvin wrote:

> >         * userland issues (what, you thought that limits on the
> > command size will go away?)
> 
> Last I checked, the command line size limit wasn't a userland issue, but
> rather a limit of the kernel exec().  This might have changed.

I _really_ don't want to trust the ability of shell to deal with long
command lines. I also don't like the failure modes with history expansion
causing OOM, etc.

AFAICS right now we hit the kernel limit first, but I really doubt that
raising said limit is a good idea.

xargs is there for purpose...
							Cheers,
								Al

