Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUIQDIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUIQDIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 23:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIQDIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 23:08:24 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:31891 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268331AbUIQDIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 23:08:23 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Nicholas Miell <nmiell@gmail.com>
To: Robert Love <rml@novell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bill Davidsen <davidsen@tmr.com>,
       Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095388176.20763.29.camel@localhost>
References: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
	 <1095376979.23385.176.camel@betsy.boston.ximian.com>
	 <1095377752.23913.3.camel@localhost.localdomain>
	 <1095388176.20763.29.camel@localhost>
Content-Type: text/plain
Message-Id: <1095390499.2878.2.camel@entropy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.njm.1) 
Date: Thu, 16 Sep 2004 20:08:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 19:29, Robert Love wrote:
> I think we want a solution that works well for both cases.
> 
> E.g., we have a few different needs:
> 
> 	- Stuff like Spotlight-esque automatic Indexers.
> 	- File manager notifications
> 	- Other GUI notifications (desktop, menus, etc.)
> 	- To prevent polling (e.g. /proc/mtab)
> 	- Existing dnotify users
> 
> dnotify is pretty lame for any of the above situations.  Even for
> something as trivial as watching the current open directory in Nautilus,
> look at the hoops we have to just through with FAM.
> 
> And dnotify utterly falls apart on removable media or for any "large"
> sort of job, e.g. indexing.

Isn't this the problem that XDSM/DMAPI is supposed to solve? Or is that
one of those specs that's too ugly to be implemented?

