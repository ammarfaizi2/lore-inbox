Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264889AbUELBSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUELBSY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264691AbUELBRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:17:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:50841 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264955AbUELBQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:16:19 -0400
Date: Tue, 11 May 2004 18:15:45 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Dave Airlie <airlied@linux.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: From Eric Anholt:
Message-ID: <20040512011545.GA4251@kroah.com>
References: <Pine.LNX.4.58.0405120018360.3826@skynet> <20040512010727.13816.qmail@web14924.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512010727.13816.qmail@web14924.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 06:07:27PM -0700, Jon Smirl wrote:
> Would int16_t and int32_t work?

No, sorry.  See the lkml archives for why.

> Those int's were in there before I started working on it. __u16 and
> __u32 are Linux kernel defines that aren't always there in user space.

Don't share header files between userspace and the kernel.  End of
problem :)

thanks,

greg k-h
