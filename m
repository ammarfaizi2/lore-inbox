Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVBKVBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVBKVBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVBKVBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:01:25 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:43098 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262339AbVBKVBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:01:23 -0500
Date: Fri, 11 Feb 2005 13:01:14 -0800
From: Greg KH <gregkh@suse.de>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211210114.GA21314@suse.de>
References: <20050211004033.GA26624@suse.de> <420D1050.3080405@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420D1050.3080405@t-online.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 09:06:40PM +0100, Harald Dunkel wrote:
> Greg KH wrote:
> >I'd like to announce, yet-another-hotplug based userspace project:
> >linux-ng.  This collection of code replaces the existing linux-hotplug
> >package with very tiny, compiled executable programs, instead of the
> >existing bash scripts.
> >
> 
> cpio is running to setup a test partition.
> 
> But one question: This is yet another package with its
> own private copy of klibc. Whats the reason behind this
> non-modular approach?

Because we don't have an easy way yet to build against a copy of klibc
on a system?  For right now, it's the simplest way to ensure that it
works for everyone, once klibc moves into the kernel tree I can remove
it from udev and hotplug-ng.

Is it causing problems for you?

thanks,

greg k-h
