Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUHFRsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUHFRsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUHFRrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:47:31 -0400
Received: from web14924.mail.yahoo.com ([216.136.225.8]:34669 "HELO
	web14924.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266561AbUHFRqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:46:46 -0400
Message-ID: <20040806174645.77462.qmail@web14924.mail.yahoo.com>
Date: Fri, 6 Aug 2004 10:46:45 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: DRM function pointer work..
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4113BDC0.6050604@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Keith Whitwell <keith@tungstengraphics.com> wrote:
> 
> Sorry, I don't buy it.  Graphics drivers are a special case and
> people upgrade them with a passion...  No new interfaces, thankyou.

I get a new kernel from Redhat about every two weeks. Redhat is at
2.6.7 and Linus is at 2.6.8. Nobody releases graphics drivers faster
than that. Why do you want to build a new release mechanism that
bypasses the kernel one?

If people are upgrading faster that every two weeks I would classify
them as developers or people that can deal with broken drivers. That
class of person can deal with pulling the code from CVS and copying it
into their kernel tree.

There are three main ways to get a driver:
1) vendor release - most stable, I get one every two weeks
2) Linus bk - very up to date, not as well tested, once a day
3) copy DRM CVS into Linus bk - bleeding edge, hope you know what you
are doing.

Besides, DRM drivers are relatively stable. It's the user space stuff
that is volatile.


> 
> Keith
> 
> 

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
