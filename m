Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUHPJb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUHPJb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUHPJb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:31:26 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:54965 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267490AbUHPJbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:31:22 -0400
Date: Mon, 16 Aug 2004 10:30:55 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <20040816101732.A9150@infradead.org>
Message-ID: <Pine.LNX.4.58.0408161019040.21177@skynet>
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org>
 <Pine.LNX.4.58.0408160038320.9944@skynet> <20040816101732.A9150@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Eeek, doing different styles of probing is even worse than what you did
> before.  Please revert to pci_find_device() util you havea proper common
> driver ready.

There was nothing wrong with what we did before it just happened to work
like 2.4. we are now acting like real 2.6 drivers, which we need to do for
sysfs and hotplug to work, Jon Smirl is working on a proper minor device
support (like USB does I think)... we need to get this work done before we
can have proper common drivers and I don't want to do all this work in
hiding and then have it refused because we told no-one,

The DRM will flux a lot over the next while (while we get this common
drm/fb stuff together) and as long as we can keep the changes from
actually breaking it I think people should be able to live with it ...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

