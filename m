Return-Path: <linux-kernel-owner+w=401wt.eu-S965108AbXADWUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbXADWUv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbXADWUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:20:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:54141 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965108AbXADWUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:20:49 -0500
Date: Thu, 4 Jan 2007 13:47:47 -0800
From: Greg KH <gregkh@suse.de>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       yi.zhu@intel.com
Subject: Re: 2.6.20-rc2-mm1 -- INFO: possible recursive locking detected
Message-ID: <20070104214747.GD28445@suse.de>
References: <a44ae5cd0612300247n529f48a6t81edb503bc646f73@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0612300247n529f48a6t81edb503bc646f73@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 02:47:20AM -0800, Miles Lane wrote:
> Sorry Andrew, I am not sure which maintainer to contact about this.  I
> CCed gregkh for sysfs and Yi for ipw2200.  Hopefully this is helpful.
> BTW, I also found that none of my network drivers were recognized by
> hal (lshal did not show their "net" entries) unless I set
> CONFIG_SYSFS_DEPRECATED=y.  I am running Ubuntu development (Feisty
> Fawn), so it seems like I ought to be running pretty current hal
> utilities:   hal-device-manager       0.5.8.1-4ubuntu1.  After
> reenabling CONFIG_SYSFS_DEPRECATED, I am able to use my IPW2200
> driver, in spite of this recursive locking message, so this INFO
> message may not indicate a problem.

Does this show up on the 2.6.20-rc3 kernel too?

thanks,

greg k-h
