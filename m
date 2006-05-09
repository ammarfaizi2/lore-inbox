Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWEIT1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWEIT1B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWEIT1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:27:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27140 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750956AbWEIT1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:27:00 -0400
Date: Tue, 9 May 2006 21:27:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Cc: Daniel Walker <dwalker@mvista.com>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 25/35] Add Xen time abstractions
Message-ID: <20060509192702.GM3570@stusta.de>
References: <20060509084945.373541000@sous-sol.org> <20060509085157.908244000@sous-sol.org> <1147191789.21536.33.camel@c-67-180-134-207.hsd1.ca.comcast.net> <20060509163814.GM7834@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509163814.GM7834@cl.cam.ac.uk>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 05:38:14PM +0100, Christian Limpach wrote:
> On Tue, May 09, 2006 at 09:23:08AM -0700, Daniel Walker wrote:
> > On Tue, 2006-05-09 at 00:00 -0700, Chris Wright wrote:
> > 
> > > +timers-y			:= timers/
> > > +timers-$(CONFIG_XEN)		:=
> > 
> > 
> > Is this line suppose to be empty ?
> 
> Yes.  We have our own version of time.c which doesn't use any of the
> timer code in timers but works for both i386 and x86_64 instead.

Please add a comment, at first sight it's not even obvious that this 
line does anything (+= and := are easy to confuse).

>     christian

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

