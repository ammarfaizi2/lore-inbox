Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWGGKfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWGGKfr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWGGKfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:35:47 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:44455 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932105AbWGGKfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:35:46 -0400
Subject: Re: Linux 2.6.17.4
From: Marcel Holtmann <marcel@holtmann.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200607061824.46990.chase.venters@clientec.com>
References: <20060706222704.GB2946@kroah.com>
	 <20060706222841.GD2946@kroah.com>
	 <200607061824.46990.chase.venters@clientec.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 12:34:52 +0200
Message-Id: <1152268492.3693.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chase,

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

the manual page must change. This paragraph must be removed.

Regards

Marcel


