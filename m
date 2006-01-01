Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWAATBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWAATBq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 14:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWAATBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 14:01:46 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:39428 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932238AbWAATBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 14:01:45 -0500
Date: Sun, 1 Jan 2006 20:01:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linda Walsh <lkml@tlinx.org>
Subject: Re: tar-pkg with out-out-tree building
Message-ID: <20060101190131.GA15200@mars.ravnborg.org>
References: <20060101132347.GB1298@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060101132347.GB1298@lug-owl.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 02:23:47PM +0100, Jan-Benedict Glaw wrote:
> Fix out-of-tree builds for the tar-pkg targets
> 
> When I wrote the buildtar script, I didn't even think about
> out-of-tree builds because I didn't use these back then. This patch
> throughoutly uses ${objtree} instead of `pwd`.
> 
> Also, the kernel version is no longer manually built. Instead, it will
> properly use $KERNELRELEASE .  Installing modules is only done if
> CONFIG_MODULES is set.

Hi Jan.
I've applied this to my kbuild tree.

Thanks,

	Sam
