Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbUKWGm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbUKWGm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbUKWGm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:42:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:53690 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262281AbUKWGlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:41:55 -0500
Date: Mon, 22 Nov 2004 22:41:20 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration) query support
Message-ID: <20041123064120.GB22493@kroah.com>
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com> <20041122713.g6bh6aqdXIN4RJYR@topspin.com> <20041122222507.GB15634@kroah.com> <527jodbgqo.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527jodbgqo.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 03:34:23PM -0800, Roland Dreier wrote:
>     Greg> No email address of who to bug with issues?
> 
> There's a patch to MAINTAINERS...

Yeah, but a name in each file is much nicer.

>     Greg> What is "RESERVED"?  I must be missing a previous patch
>     Greg> somewhere, I currently don't see all of the series yet.
> 
> It's in part 1/12: http://article.gmane.org/gmane.linux.kernel/257531
> unfortunately some people marked it as spam and it didn't get
> everywhere.

Thanks for pointing this out. 

One comment, the file drivers/infiniband/core/cache.c has a license that
is illegal due to the contents of the file.  Please change the license
of the file to GPL only.

Oh, and how about kernel-doc comments for all functions that are
EXPORT_SYMBOL() marked?  And for your core big structures?

thanks,

greg k-h
