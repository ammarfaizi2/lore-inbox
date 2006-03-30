Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWC3QWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWC3QWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWC3QWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:22:11 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:11732 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751261AbWC3QWJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:22:09 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Date: Thu, 30 Mar 2006 18:20:40 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org
References: <200603281601.22521.ncunningham@cyclades.com> <200603301424.50562.rjw@sisk.pl> <20060330125902.GR8485@elf.ucw.cz>
In-Reply-To: <20060330125902.GR8485@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603301820.41344.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 14:59, Pavel Machek wrote:
> On Čt 30-03-06 14:24:50, Rafael J. Wysocki wrote:
> > On Thursday 30 March 2006 14:17, Rafael J. Wysocki wrote:
> > > On Thursday 30 March 2006 14:05, Pavel Machek wrote:
> > > > > > I do not see missing includes, so I'm not sure it will help. Can you
> > > > > > try adding
> > > > > >
> > > > > > ARCH=x86_64
> > > > > >
> > > > > > to Makefile?
> > > > > 
> > > > > Heh. It worked. Maybe you should have something to figure out what arch the 
> > > > > user is using :) It seems a bit strange to tell the compiler that I'm using 
> > > > > the arch it ought to know I'm using.
> > > > 
> > > > Good. Does 
> > > > 
> > > > ARCH=`uname -m`
> > > > 
> > > > work, too?
> > > 
> > > No, it doesn't.
> > 
> > Something like this works, though:
> > 
> > ARCH:=$(shell uname -m)
> 
> looks good, can you commit it (when sf works again :-).

Yup, I will.

Rafael
