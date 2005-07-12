Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVGLSwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVGLSwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVGLSwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:52:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262022AbVGLSun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:50:43 -0400
Date: Tue, 12 Jul 2005 11:50:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: blaisorblade@yahoo.it
Cc: stable@kernel.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [stable] [patch 1/1] uml: fix TT mode by reverting "use fork instead of clone"
Message-ID: <20050712185023.GY19052@shell0.pdx.osdl.net>
References: <20050712172838.271E8D9A84@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712172838.271E8D9A84@zion.home.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> Revert the following patch, because of miscompilation problems in different
> environments leading to UML not working *at all* in TT mode; it was merged
> lately in 2.6 development cycle, a little after being written, and has caused
> problems to lots of people; I know it's a bit too long, but it shouldn't have
> been merged in first place, so I still apply for inclusion in the -stable
> tree. Anyone using this feature currently is either using some older kernel
> (some reports even used 2.6.12-rc4-mm2) or using this patch, as included in my
> -bs patchset.
> 
> For now there's not yet a fix for this patch, so for now the best thing is to
> drop it (which was widely reported to give a working kernel).

And upstream will leave this in, working to real fix?

thanks,
-chris
