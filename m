Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270296AbTGRSaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 14:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270301AbTGRSaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 14:30:06 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:54285
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270296AbTGRSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 14:30:03 -0400
Date: Fri, 18 Jul 2003 11:45:12 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Greg KH <greg@kroah.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hotplug Oops Re: Linux v2.6.0-test1
Message-ID: <20030718184512.GD2289@matchmail.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030716014650.GB2681@matchmail.com> <20030716023150.GA2302@kroah.com> <20030716201512.GA1821@matchmail.com> <20030718023141.GC5828@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718023141.GC5828@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 07:31:41PM -0700, Greg KH wrote:
> On Wed, Jul 16, 2003 at 01:15:12PM -0700, Mike Fedyk wrote:
> > Ok, I only see it when the system is booting, and after looking at the    
> > hotplug script in init.d there is different behaviour on boot, and on later   
> > invocations.                               
> 
> This is really wierd.  I can't see anything strange in your logs, until
> the oops :)

It looks like it's a bug in the core code because when I was testing 2.5.70,
it was on a athlon XP pr2600, and the via-rhine module oopsed (because it
was started before the usb modules), and then it would hang.

I didn't report it because I wasn't able to capture the oops. :(

I'll do more to try to reproduce manually without the hotplug scripts.
(I'll bet it has something to do with one of the hotplug modules being
loaded).

Mike
