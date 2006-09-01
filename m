Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWIASac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWIASac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 14:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWIASac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 14:30:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:59035 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750729AbWIASab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 14:30:31 -0400
Date: Fri, 1 Sep 2006 11:22:39 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - sysctl or module parameters.
Message-ID: <20060901182239.GA9973@kroah.com>
References: <17655.38092.888976.846697@cse.unsw.edu.au> <20060901101001.GA13912@kroah.com> <20060901155715.A03285F9DAB@tzec.mtu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901155715.A03285F9DAB@tzec.mtu.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 07:57:12PM +0400, Andrey Borzenkov wrote:
> Greg KH wrote:
> 
> > On Fri, Sep 01, 2006 at 12:02:52PM +1000, Neil Brown wrote:
> >> 
> >>  - I could make it a module parameter: use_hostnames, and tell
> >>    Jo to put
> >>      options lockd use_hostnames=yes
> >>    in /etc/modprobe.d/lockd  if that is what (s)he wants.
> >>    But that won't work if the module is compiled in (will it?).
> > 
> > Yes it will.  See Documentation/kernel-parameters.txt for how it works.
> > 
> 
> I must be blind today but I failed to find anything about this in mentioned
> file. Nor do I see how it can possibly work. Could you please elaborate a
> bit?

Well, it doesn't work for reading the info from the module parameter
files, sorry, it was a bit late when I wrote that.  What I ment to say
is that the parameter can be set from the kernel command line at boot
time, if the module is built into the kernel.

Sorry for the confusion,

greg k-h
