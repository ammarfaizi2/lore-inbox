Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbSI1CNF>; Fri, 27 Sep 2002 22:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262686AbSI1CNF>; Fri, 27 Sep 2002 22:13:05 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:61966 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262685AbSI1CNF>;
	Fri, 27 Sep 2002 22:13:05 -0400
Date: Fri, 27 Sep 2002 19:16:43 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sleeping function called from illegal context...
Message-ID: <20020928021643.GB14866@kroah.com>
References: <20020927233044.GA14234@kroah.com> <1033174290.23958.17.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033174290.23958.17.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 08:51:30PM -0400, Robert Love wrote:
> On Fri, 2002-09-27 at 19:30, Greg KH wrote:
> 
> > The system still seems to be running ok, but I think I'll turn off
> > CONFIG_PREEMPT just to be sure.
> 
> Note this has nothing to do with kernel preemption.  IDE explicitly
> sleeps while purposely holding a lock.
> 
> It is just we do not have the ability to measure atomicity w/o
> preemption enabled - e.g. the debugging only works when it is enabled.

Yes, you are correct.  Sorry for stating that.  It's shaking out lots of
potential proplems :)

greg k-h
