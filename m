Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268000AbUHWXHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbUHWXHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUHWXHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:07:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:61145 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268000AbUHWXG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:06:29 -0400
Subject: Re: IA32 (2.6.8.1 - 2004-08-22.21.30) - 3 New warnings (gcc 3.2.2)
From: John Cherry <cherry@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040823213431.GA4371@kroah.com>
References: <200408231251.i7NCpJDK006874@cherrypit.pdx.osdl.net>
	 <20040823213431.GA4371@kroah.com>
Content-Type: text/plain
Message-Id: <1093302139.12874.143.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 23 Aug 2004 16:02:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Yes, these are valid warnings (as most warning are).  I am just flagging
these since they are NEW to the build.  These particular warnings are
likely to go away soon after Jan 1, which is good information to know. 
These warning will not show up again as NEW warnings.

BTW, Linus flagged these warning cases as part of changeset 1.1803.1.58.

John


On Mon, 2004-08-23 at 14:34, Greg KH wrote:
> On Mon, Aug 23, 2004 at 05:51:19AM -0700, John Cherry wrote:
> > drivers/cpufreq/cpufreq_userspace.c:157:2: warning: #warning The /proc/sys/cpu/ and sysctl interface to cpufreq will be removed from the 2.6. kernel series soon after 2005-01-01
> > drivers/cpufreq/proc_intf.c:15:2: warning: #warning This module will be removed from the 2.6. kernel series soon after 2005-01-01
> 
> Um, these look like valid warnings to me, you might want to review these
> by hand before sending them out.
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

