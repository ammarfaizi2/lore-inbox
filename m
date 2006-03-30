Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWC3M75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWC3M75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWC3M74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:59:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27835 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932197AbWC3M74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:59:56 -0500
Date: Thu, 30 Mar 2006 14:59:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Message-ID: <20060330125902.GR8485@elf.ucw.cz>
References: <200603281601.22521.ncunningham@cyclades.com> <20060330120514.GO8485@elf.ucw.cz> <200603301417.18646.rjw@sisk.pl> <200603301424.50562.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603301424.50562.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 30-03-06 14:24:50, Rafael J. Wysocki wrote:
> On Thursday 30 March 2006 14:17, Rafael J. Wysocki wrote:
> > On Thursday 30 March 2006 14:05, Pavel Machek wrote:
> > > > > I do not see missing includes, so I'm not sure it will help. Can you
> > > > > try adding
> > > > >
> > > > > ARCH=x86_64
> > > > >
> > > > > to Makefile?
> > > > 
> > > > Heh. It worked. Maybe you should have something to figure out what arch the 
> > > > user is using :) It seems a bit strange to tell the compiler that I'm using 
> > > > the arch it ought to know I'm using.
> > > 
> > > Good. Does 
> > > 
> > > ARCH=`uname -m`
> > > 
> > > work, too?
> > 
> > No, it doesn't.
> 
> Something like this works, though:
> 
> ARCH:=$(shell uname -m)

looks good, can you commit it (when sf works again :-).
							Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
