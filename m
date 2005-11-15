Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbVKORkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbVKORkS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVKORkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:40:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:49309 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751464AbVKORkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:40:16 -0500
Date: Tue, 15 Nov 2005 09:24:05 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Doug Thompson <norsk5@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] EDAC and the sysfs
Message-ID: <20051115172405.GA13658@kroah.com>
References: <20051114221419.10324.qmail@web50101.mail.yahoo.com> <20051114223105.GA5868@kroah.com> <20051115003026.GA12266@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115003026.GA12266@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 07:30:26PM -0500, Dave Jones wrote:
> On Mon, Nov 14, 2005 at 02:31:05PM -0800, Greg Kroah-Hartman wrote:
>  > On Mon, Nov 14, 2005 at 02:14:19PM -0800, Doug Thompson wrote:
>  > > 
>  > > I am trying to design the sysfs interface tree for the
>  > > new set of EDAC modules that are waiting for this
>  > > interface, before being put into the kernel.  
>  > > 
>  > > Currently the original EDAC (bluesmoke) has its own
>  > > /proc directory (/proc/mc) with files and a directory
>  > > (0,1,2,...)for each memory controller on the system.
>  > > This will be removed and the new information interface
>  > > will be placed in the sysfs.
>  > > 
>  > > One proposal is to place the information in
>  > > /sys/devices/system in the following directories:
>  > 
>  > Why not use /sys/firmware/ instead?
> 
> Probably the same reason we don't have the cpufreq (for eg)
> stuff under /sys/firmware.  Because it's poking hardware,
> not manipulating firmware.
> 
> /sys/devices/system makes a lot more sense, as thats
> where the cpu level machine check stuff is (amongst other
> similar things).

Ok, that does make sense, thanks for explaining it.

greg k-h
