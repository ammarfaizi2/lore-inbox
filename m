Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751912AbWIGXzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbWIGXzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWIGXzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:55:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:61112 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751912AbWIGXzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:55:22 -0400
Date: Thu, 7 Sep 2006 16:54:58 -0700
From: Greg KH <gregkh@suse.de>
To: Henk Vergonet <Henk.Vergonet@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix unload oops and memory leak in yealink driver
Message-ID: <20060907235458.GA30701@suse.de>
References: <20060907234614.GA31195@god.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907234614.GA31195@god.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 01:46:14AM +0200, Henk Vergonet wrote:
> I hope we can schedule this for inclusion in 2.6.18 as many users have
> reported problems with kernel oops-en while unloading the driver.
> 
> (tested on 2.6.18-rc6)
> 
> Description:
> 
> This patch fixes a memory leak and a kernel oops when trying to unload
> the driver, due to an unbalanced cleanup.
> Thanks Ivar Jensen for spotting my mistake.
> 
> Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>

How about a version of the patch without the spelling and other stuff in
it, and only the bugfix?

The other stuff can be in a different patch that can be added later.

thanks,

greg k-h
