Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbVHOA0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbVHOA0T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 20:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVHOA0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 20:26:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47546 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932597AbVHOA0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 20:26:18 -0400
Date: Sun, 14 Aug 2005 17:26:00 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb camera failing in 2.6.13-rc6
Message-Id: <20050814172600.71a4a8cc.zaitcev@redhat.com>
In-Reply-To: <200508150929.21402.kernel@kolivas.org>
References: <mailman.1124005092.8274.linux-kernel2news@redhat.com>
	<200508141842.13209.kernel@kolivas.org>
	<20050814115648.4f12f1ec.zaitcev@redhat.com>
	<200508150929.21402.kernel@kolivas.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005 09:29:20 +1000, Con Kolivas <kernel@kolivas.org> wrote:

> > Remember that dmesg diff you sent? That's the one. If you strace
> > the digikamcameracl, it probably keels over after EBUSY.
> 
> Nice shot! Got it in one. bugzilla updated with confirmation.
> 
> So how do we proceed with this one? Do I need to file a digikam bug
> report too?

Since I never encountered it, I'm not versed in the switching of
the current altsetting. I suppose, this has to be discussed between
digikam developers and linux-usb-devel (Alan Stern probably knows
how that has to be done). It's very likely that all digikam needs
is to claim the interface after the altsetting was switched...
But I really do not know.

-- Pete
