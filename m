Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTEMAIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTEMAIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:08:14 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:40626 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262985AbTEMAIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:08:12 -0400
Date: Mon, 12 May 2003 17:22:40 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513002240.GA4419@kroah.com>
References: <20030512155417.67a9fdec.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512155417.67a9fdec.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 03:54:17PM -0700, Andrew Morton wrote:
> 
> There have been surprisingly few additions.  The original and updated lists
> are at
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/
> 
> Nothing has been deleted.  This means either that nobody is doing anything
> or people forgot to tell me.

People forget to tell you :)

Here's a small patch knocking two things off the list that are now in
Linus's tree.

thanks,

greg k-h


--- must-fix-2.txt.original	2003-05-12 17:18:23.782129948 -0700
+++ must-fix-2.txt	2003-05-12 17:19:36.906235476 -0700
@@ -175,9 +175,6 @@
 
 - Per-cpu support inside modules (have patch, in testing).
 
-- driver class code is getting redone.  I have this now working, and will
-  send it out in a few days.
-
 net/
 ----
 
@@ -561,9 +558,6 @@
   Alternatively, we could re-introduce the fallback to driver ioctl parsing
   for these if not enough drivers get updated.
 
-- fixup the usb-serial core and drivers to provide support for this
-  patch.
-
 drivers/net/
 ------------
 



