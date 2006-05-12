Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWELUM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWELUM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWELUM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:12:26 -0400
Received: from mx1.suse.de ([195.135.220.2]:39593 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932202AbWELUM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:12:26 -0400
Date: Fri, 12 May 2006 13:10:29 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [GIT PATCH] I2C bugfixes for 2.6.17-rc4 - resend
Message-ID: <20060512201029.GA12248@suse.de>
References: <20060512190332.GA22627@kroah.com> <Pine.LNX.4.64.0605121216540.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605121216540.3866@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 12:18:53PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 12 May 2006, Greg KH wrote:
> However, please fix your scripts:
> 
> > Please pull from:
> > 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> 
> Nobody should use "rsync:", it's just more pain for everybody these days. 
> If you use rsync, and miss an object, because the mirroring was 
> incomplete, you'll never know, you'll just have a strange corrupted 
> archive.
> 
> Use rsync if you mirror things, but not for git.
> 
> So please make that read "git://git.kernel.org/.." instead. 

Oops, sorry, that's a leftover from a long time ago when I first wrote
the "create a pull email" script.  Sorry, I'll go fix that.

thanks,

greg k-h
