Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270045AbTGNKnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 06:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270046AbTGNKnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 06:43:40 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:30479 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S270045AbTGNKnj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 06:43:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Input layer demand loading
Date: Mon, 14 Jul 2003 12:58:24 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200307131839.49112.fredrik@dolda2000.cjb.net> <20030714062217.GA20482@kroah.com>
In-Reply-To: <20030714062217.GA20482@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307141258.24458.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 July 2003 08.22, Greg KH wrote:
> On Sun, Jul 13, 2003 at 06:39:49PM +0200, Fredrik Tolf wrote:
> > Why does the input layer still not have on-demand module loading? How
> > about applying this?
>
> What's wrong with the current hotplug interface for the input layer?  If
> you want to implement this, add some input hotplug scripts to the
> linux-hotplug package.

Correct me if I'm wrong, but AFAIK that can only be smoothly used to load 
hardware driver modules.
If the input layer userspace interface code has been compiled as modules, and 
you have a ordinary (not hotplug) device, eg. a gameport joystick, can really 
the hotplug interface be used to load joydev.o when /dev/input/js0 is opened?
I don't use hotplugging that much, so I can't say that I'm sure about what it 
can do, but in my perception of the hotplug system, it can't be used for 
that.

Fredrik Tolf

