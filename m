Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTLCWgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTLCWgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:36:52 -0500
Received: from aples1.dom1.jhuapl.edu ([128.244.26.85]:16901 "EHLO
	aples1.jhuapl.edu") by vger.kernel.org with ESMTP id S262063AbTLCWgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:36:46 -0500
Message-ID: <E37E01957949D611A4C30008C7E691E20915BBFC@aples3.dom1.jhuapl.edu>
From: "Collins, Bernard F. (Skip)" <Bernard.Collins@jhuapl.edu>
To: "'Greg KH'" <greg@kroah.com>,
       "Collins, Bernard F. (Skip)" <Bernard.Collins@jhuapl.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Visor USB hang
Date: Wed, 3 Dec 2003 17:36:01 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I am running 2.4.23 on a RedHat 9 system. Whenever I try to sync my
> > Visor Deluxe, the system hangs/freezes soon after I press the sync 
> > button on my cradle. Trying to find the cause of the problem, I 
> > preloaded the usbserial and visor modules with "debug=1". Nothing 
> > obviously wrong appears in the logs. The last message before the 
> > system freezes is a usb-uhci.c interrupt message.
> 
> Can you show the log with that enabled?

If you mean debug=1 enabled, the log excerpt I posted was generated with
both the usbserial and visor modules modprobed with debug=1. Perhaps I am
mistaken in assuming that my approach actually enables debugging. I
modprobed both modules and hit the hotsync button. I am assuming that
hotplug does not override the manually loaded module parameters. 

> What happens if you use the uhci.o module instead of usb-uhci.o?

That is not terribly convenient to test right now. Can you suggest a simple
way to unload usb-uhci and load uhci without disabling my usb keyboard and
mouse?

Skip
