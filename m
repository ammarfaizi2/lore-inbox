Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUHBXJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUHBXJc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUHBXJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:09:31 -0400
Received: from web14924.mail.yahoo.com ([216.136.225.8]:60769 "HELO
	web14924.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263709AbUHBXJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:09:19 -0400
Message-ID: <20040802230913.60350.qmail@web14924.mail.yahoo.com>
Date: Mon, 2 Aug 2004 16:09:13 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: DRM code reorganization
To: Dave Jones <davej@redhat.com>
Cc: Ian Romanick <idr@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
In-Reply-To: <20040802210935.GF12724@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Dave Jones <davej@redhat.com> wrote:
> Another possibility of course is that the BSD & Linux kernel side
> bits go their separate ways. How active is the kernel side of the 
> BSD world ?

I'll probably get flamed to death for suggesting this, but why not?

What about leaving BSD working with the current code and moving forward
on Linux alone? The thread "OLS and console rearchitecture" describes a
lot of changes to the graphics system. Some of these are much easier to
achieve on Linux than BSD since some the underlying operations are
supported in the Linux kernel and not in the BSD one. After we achieve
a new stable point, maybe the first X on GL release, we back port
everything to BSD.

One problem right now is that there are only one or two BSD developers,
all of the rest are Linux based. Most of the Linux based people have no
clue as to BSD's capabilities. Wouldn't it simply be more efficient to
put BSD on hold for a while and then resynch after everything has stabilized?

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Read only the mail you want - Yahoo! Mail SpamGuard.
http://promotions.yahoo.com/new_mail 
