Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318191AbSGXXDB>; Wed, 24 Jul 2002 19:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318200AbSGXXDB>; Wed, 24 Jul 2002 19:03:01 -0400
Received: from vena.lwn.net ([206.168.112.25]:11790 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S318191AbSGXXDA>;
	Wed, 24 Jul 2002 19:03:00 -0400
Message-ID: <20020724230613.27190.qmail@eklektix.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.28 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "25 Jul 2002 00:30:00 +0200."
             <1027549801.11619.2.camel@sonja.de.interearth.com> 
Date: Wed, 24 Jul 2002 17:06:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > <dalecki@evision.ag>:
> >   o IDE-101
> 
> What on earth is this??? I'm really surprised you accept this as a
> changelog entry especially when considering that there's no further
> information about the latest IDE changes on the mailinglist anymore...

You need to look at the full changelog to see the full entry: see, for
example: http://lwn.net/Articles/5577/.  Or, to save the wear on your web
browser:

  <dalecki@evision.ag>
	[PATCH] IDE-101
	
	Here is a quick fix.  I would like to synchronize with the irq handler
	changes as well.  Becouse right now I know that preemption is killing
	the disk subsystem when moving data between disks using different
	request queues...  In esp.  It get's me in to do_request() with a queue
	in unplugged state.  (Not everything is my fault, after all :-).

This does still leave open the question of why these patches no longer go
to linux-kernel, though...

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
