Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbUCPAsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUCPApu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:45:50 -0500
Received: from web14903.mail.yahoo.com ([216.136.225.55]:15422 "HELO
	web14903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262919AbUCPAm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:42:57 -0500
Message-ID: <20040316004254.18671.qmail@web14903.mail.yahoo.com>
Date: Mon, 15 Mar 2004 16:42:54 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: DRM reorganization
To: Ian Romanick <idr@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
In-Reply-To: <40564723.4010105@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Ian Romanick <idr@us.ibm.com> wrote:
> That's part of why I'm asking.  From talking to Linus in the past, I 
> know that merging in changes is a PITA due to our funky directory 
> structure.  I'd like to make that easier. :)

Part of the pain could be caused by the shared/linux split in the DRM tree. The
kernel tree doesn't have that split. 

Also DRM makefile.kernel and the kernel char/drm/Makefile are similar but not
the same. So any changes to the build procedure would need to be updated into
char/drm/Makefile.

drmstat.c/dristat.c should be pulled out of the driver directory and put it in a
directory for apps.

Where should Doxyfile and config.in go?

The savage driver is not currently in the kernel. Should the mach64 driver be
moved out of the branch and into the DRM project?

The best solution would be to have some kind of scipt in the DRM project that
builds a directory that can simply be copied into char/drm.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Mail - More reliable, more storage, less spam
http://mail.yahoo.com
