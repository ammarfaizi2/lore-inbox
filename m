Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbSJQWSQ>; Thu, 17 Oct 2002 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbSJQWSQ>; Thu, 17 Oct 2002 18:18:16 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:59537 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262239AbSJQWSP>;
	Thu, 17 Oct 2002 18:18:15 -0400
Date: Thu, 17 Oct 2002 17:23:23 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Andrew Morton <akpm@digeo.com>
cc: Steve Parker <steve.parker@netops.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.41 still not testable by end users
In-Reply-To: <3DAE2691.76F83D1B@digeo.com>
Message-ID: <Pine.LNX.4.44.0210171717550.18123-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Andrew Morton wrote:

> Steve Parker wrote:
> > 
> > I've been trying to test the 2.5 kernel since 2.5.39, but these warnings
> > really scare me off... 
> > ...
> > Oct 16 21:40:59 declan kernel: Debug: sleeping function called from
> > illegal context at mm/slab.c:1374
> 
> It's just debug.  Everyone gets it.  Don't worry about it.
> 
> It's there to remind the IDE developers to fix it.
> 
> > Oct 16 21:40:59 declan kernel: Call Trace:
> > ...
> > Oct 16 21:40:59 declan kernel:  [__might_sleep+84/96]
> > ...
> > Oct 16 21:41:00 declan kernel:  [init_irq+637/820] init_irq+0x27d/0x334
> >
> 
> One day.  Before we all die.  Please.

I had that as fixed in my problem list.  It should have been integrated by 
2.5.42, certainly 2.5.43.  I'm not seeing any additional reports since 
then.  

