Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284557AbRLESf4>; Wed, 5 Dec 2001 13:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284554AbRLESfr>; Wed, 5 Dec 2001 13:35:47 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:58099 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S284559AbRLESfc>;
	Wed, 5 Dec 2001 13:35:32 -0500
Date: Wed, 5 Dec 2001 19:35:24 +0100
From: David Weinehall <tao@acc.umu.se>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Todo] Remove usage of (f)suser in kernel
Message-ID: <20011205193524.U360@khan.acc.umu.se>
In-Reply-To: <20011205181558.R360@khan.acc.umu.se> <3C0E63F8.8CD0B9CA@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C0E63F8.8CD0B9CA@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Dec 05, 2001 at 01:14:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 01:14:16PM -0500, Jeff Garzik wrote:
> David Weinehall wrote:
> > After a quick round of grep:ing, I came up with the following files
> > needing fixes to substitute usage of (f)suser for proper capabilities:
> [...]
> > Since I don't know what the maintainers of some of these files want
> > as capabilities, I've decided not to fix this myself. zr36120.c is
> > only a matter of removing an #ifdef/#else/#endif combo and doing some
> > reindenting, though.
> 
> We need to kill those in 2.5 I think.  s/suser/capable(...)/ has been on
> the kernel janitor's list for a while.

That was kind of my intention behind this, yes.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
