Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266160AbTLIJ1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbTLIJ1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:27:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:36836 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266168AbTLIJ1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:27:46 -0500
Date: Tue, 9 Dec 2003 01:18:30 -0800
From: Greg KH <greg@kroah.com>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031209091830.GB2753@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <3FD577E7.9040809@nishanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD577E7.9040809@nishanet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 02:21:11AM -0500, Bob wrote:
> 
> hotplug and udev and sysfsutils are together at
> http://www.kernel.org/pub/linux/utils/kernel/hotplug
> so hotplug is part of the sysfs and udev program.

No.

udev uses the /sbin/hotplug notifier to do its work.
udev uses libsysfs (what is under sysfsutils) to access sysfs easier,
instead of making me muck around in sysfs directly.  sysfsutils has
nothing to do with /sbin/hotplug.

greg k-h
