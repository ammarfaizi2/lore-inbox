Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbTDKXzy (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTDKXzy (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:55:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:45971 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262734AbTDKXye (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:54:34 -0400
Date: Fri, 11 Apr 2003 17:08:29 -0700
From: Greg KH <greg@kroah.com>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030412000829.GL4539@kroah.com>
References: <20030411172011.GA1821@kroah.com> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411190717.GH1821@kroah.com> <b77jmr$31d$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b77jmr$31d$1@news.cistron.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 11:39:07PM +0000, Miquel van Smoorenburg wrote:
> In article <20030411190717.GH1821@kroah.com>,
> Greg KH  <greg@kroah.com> wrote:
> >I agree too.  Having /sbin/hotplug send events to a pipe where a daemon
> >can get them from makes a lot of sense.  It will handle most of the
> >synchronization and spawning a zillion tasks problems.
> 
> Why not serialize /sbin/hotplug at the kernel level. Queue hotplug
> events and only allow one /sbin/hotplug to run at the same time.

We don't want the kernel to stop based on a user program.

thanks,

greg k-h
