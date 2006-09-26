Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWIZUjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWIZUjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWIZUjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:39:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51927 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932285AbWIZUjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:39:54 -0400
Date: Tue, 26 Sep 2006 13:39:48 -0700
From: Greg KH <gregkh@suse.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.18
Message-ID: <20060926203948.GB15674@suse.de>
References: <20060926053728.GA8970@kroah.com> <1159274045.6433.31.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159274045.6433.31.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 12:34:05PM +0000, Mike Galbraith wrote:
> On Mon, 2006-09-25 at 22:37 -0700, Greg KH wrote:
> > Here are a bunch of driver core and sysfs patches and fixes for 2.6.18.
> 
> Hi,
> 
> Just as an fyi, these patches cause a ~regression on my P4/HT box.
> 
> Suspend stopped here working after 2.6.17.

Does 2.6.18 also have these problems?

If so, it's not due to these patches :)

> I haven't dug into why, but
> since then, I get a message "Class driver suspend failed for cpu0", and
> the suspend fails, but everything works fine afterward.  If I ignore the
> return of drv->suspend(), the box will suspend and resume just fine,
> both with this patch set and without.  (which is what I've been doing
> while waiting for it to fix itself or for my round toit to turn up)

What driver is controling cpu0?
What driver is failing the suspend?
What line did you have to change?

thanks,

greg k-h
