Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUAOW5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUAOW5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:57:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:61342 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263787AbUAOW5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:57:01 -0500
Date: Thu, 15 Jan 2004 14:56:54 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs class patch update [00/10]
Message-ID: <20040115225654.GL22433@kroah.com>
References: <20040115204048.GA22199@kroah.com> <yw1xoet5rktz.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xoet5rktz.fsf@kth.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 09:57:44PM +0100, Måns Rullgård wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > Hi,
> >
> > Here are 10 different patches, all against a clean 2.6.1.  They update
> > my previous sysfs class patches (and those should be dropped from the
> > existing -mm tree).  They fix the race condition in the previous ones,
> > and add new support for raw and lp devices.
> 
> Are these downloadable from some place?  Or even better, BK pullable?

They are all located at:
	kernel.org/pub/linux/kernel/people/gregkh/misc/2.6/sysfs-*-2.6.1.patch

I also have them in my own bk tree at:
	bk://kernel.bkbits.net:/home/gregkh/linux/gregkh-2.6
but that tree is NOT parented off of Linus's bk tree, so odds are you
can not pull from it.  You can clone it if you really want to...

thanks,

greg k-h
