Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311748AbSCTH6Z>; Wed, 20 Mar 2002 02:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSCTH6G>; Wed, 20 Mar 2002 02:58:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1435 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S311748AbSCTH5z>;
	Wed, 20 Mar 2002 02:57:55 -0500
Date: Wed, 20 Mar 2002 02:57:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
In-Reply-To: <20020319152502.J14877@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0203200256330.19220-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Mar 2002, Larry McVoy wrote:

> Come on Pavel, in order to make this happen, you have to
> 
> 	a) run the installer as root
> 	b) know the next pid which will be allocated
> 	c) put the symlink in /tmp/installer$pid
> 
> and do all before that pid gets used.  Have you actually be able to
> do that?  I'd like to see how you did so without knowing exactly when
> root was going to install the package and without filling up /tmp with
> 64,000 symlinks.

Or just sit and do getdents() until installer* shows up and then create
data*...

