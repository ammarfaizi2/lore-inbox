Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280153AbRKEDUr>; Sun, 4 Nov 2001 22:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280159AbRKEDU1>; Sun, 4 Nov 2001 22:20:27 -0500
Received: from taltos.codesourcery.com ([66.92.14.85]:62592 "EHLO
	taltos.codesourcery.com") by vger.kernel.org with ESMTP
	id <S280153AbRKEDUZ>; Sun, 4 Nov 2001 22:20:25 -0500
Date: Sun, 4 Nov 2001 19:20:24 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.20a and gcc 3.0 ?
Message-ID: <20011104192024.H267@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE5EA81.6070400@stesmi.com>
User-Agent: Mutt/1.3.23i
From: Zack Weinberg <zack@codesourcery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>gcc-2.95.4 does not exist! The latest stable release is 2.95.3.
> > Ah, it does exist. You have to check it out from CVS from the GCC people.
> > I've no doubt a release will be made soon.
> 
> That's what's called a not released product.
> 
> 2.95.4 might or might not be released shortly.
> 
> It is not the final 2.95.4 that is in the CVS.
> 
> Another word for it might be BETA...

We're being extremely conservative about patches applied to the 2.95.x
CVS branch.  It is intended always to be release-quality material.

I'm not aware of any plans for an official 2.95.4 anytime soon.
However, system integrators often track that CVS branch with their GCC
packages.  For instance:

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011006 (Debian prerelease)

zw
