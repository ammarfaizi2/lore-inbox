Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270401AbRHHHiA>; Wed, 8 Aug 2001 03:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270403AbRHHHhv>; Wed, 8 Aug 2001 03:37:51 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:51076 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S270401AbRHHHhp>; Wed, 8 Aug 2001 03:37:45 -0400
Date: Wed, 8 Aug 2001 17:38:00 +1000
From: john slee <indigoid@higherplane.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1 is available.
Message-ID: <20010808173800.C2770@higherplane.net>
In-Reply-To: <31408.997253881@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31408.997253881@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 04:58:01PM +1000, Keith Owens wrote:
>   Supports separate source and object directories.  You can compile
>   multiple versions of the kernel from a single source tree, using a
>   separate object directory and config for each version.  You can even
>   compile different architectures simultaneously from the same source
>   tree.

ace, less cp -al!

>   Standard support for shipping generated files.  kbuild 2.4 has had
>   continual problems with files that are both generated and shipped.

a subtle reference to aic7xxx? :-/

>   Multiple targets can be specified on the same make command.  You
>   cannot mix clean or mrproper with other targets but everything else
>   can be put on one command.
>     make -j oldconfig installable && sudo make -j install
>   works beautifully.

'make dep bzImage modules modules_install' has worked for me for a long
long time...  am i just lucky?

>   Install targets such as bzImage, zImage, where to install System.map
>   and .config, the install path prefix, which commands to run after
>   install etc. are all CONFIG_ options.  Copy .config from one kernel
>   to another, run make install and it all happens, hands free.

i think you've fixed my only gripes with existing kbuild.
much appreciated. :-)

j.

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
