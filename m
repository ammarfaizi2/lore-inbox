Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314030AbSDKMY3>; Thu, 11 Apr 2002 08:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314031AbSDKMY2>; Thu, 11 Apr 2002 08:24:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23888 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314030AbSDKMY2>; Thu, 11 Apr 2002 08:24:28 -0400
Date: Thu, 11 Apr 2002 14:24:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Martin Devera <devik@cdi.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rb_tree methods export request
Message-ID: <20020411142447.G14605@dualathlon.random>
In-Reply-To: <Pine.LNX.4.10.10204111059020.15162-100000@luxik.cdi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 11:03:47AM +0200, Martin Devera wrote:
> Hello Andrea,
> 
> I write to you as to maintainer of rb_tree code in 2.4. I'm
> just finishing module (QoS HTB scheduler) where I need to use 
> balanced tree and your rb_tree implementation seems as the best
> one for it.
> Only problem is that rb_delete and athers are not exported so that
> I can't use them in the module.
> Is there some problem to export the symbols or should I duplicate
> the code ?
 
You don't need to duplicate the code:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre3aa2/00_rb-export-1

It is just included in 2.4.19pre6 mainline btw, so just updating to the
latest kernel should solve your problem with the module.

2.5 is still missing it, but it should be applied there too eventually.

Andrea
