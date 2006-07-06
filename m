Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWGFX6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWGFX6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWGFX6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:58:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:59842 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751094AbWGFX5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:57:55 -0400
Date: Thu, 6 Jul 2006 16:54:07 -0700
From: Greg KH <greg@kroah.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.17.4
Message-ID: <20060706235407.GB13418@kroah.com>
References: <20060706222704.GB2946@kroah.com> <20060706222841.GD2946@kroah.com> <200607061824.46990.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607061824.46990.chase.venters@clientec.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 06:24:23PM -0500, Chase Venters wrote:
> On Thursday 06 July 2006 17:28, Greg KH wrote:
> >  		case PR_SET_DUMPABLE:
> > -			if (arg2 < 0 || arg2 > 2) {
> > +			if (arg2 < 0 || arg2 > 1) {
> >  				error = -EINVAL;
> >  				break;
> >  			}
> 
> Am I staring at this crooked, or not looking deep enough? My manual page for 
> prctl says 2 is valid there. Specifically:
> 
>               Since  kernel 2.6.13, the value 2 is also permitted; this causes
>               any binary which normally would not be dumped to be dumped read-
>               able   by   root   only.    (See   also   the   description   of
>               /proc/sys/fs/suid_dumpable in proc(5).)
> 
> ...has something changed, and my manpages don't reflect it? Did I miss a 
> conversation about this?

Please refer to the CVE number for details.

thanks,

greg k-h
