Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWALTCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWALTCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWALTCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:02:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:41126 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161148AbWALTCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:02:48 -0500
Date: Thu, 12 Jan 2006 11:01:24 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Mike D. Day" <ncmike@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060112190124.GB12773@kroah.com>
References: <43C53DA0.60704@us.ibm.com> <20060111233118.GA1534@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111233118.GA1534@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 12:31:18AM +0100, Pavel Machek wrote:
> 
> > The comments desired are (1) do the helper routines in xen_sysfs 
> > duplicate code already present in linux (or under development somewhere 
> > else). (2) Is it appropriate for a process to create sysfs attributes 
> > without implementing a driver subsystem
> 
> Not sure, maybe proc is really better.

NO!

{sigh}

Please remember, proc is ONLY FOR PROCESS RELATED THINGS.  Do not add
non-process related things to proc anymore please...

thanks,

greg k-h
