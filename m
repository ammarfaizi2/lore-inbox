Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269504AbUJLHpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269504AbUJLHpA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 03:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269502AbUJLHpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 03:45:00 -0400
Received: from mail.dif.dk ([193.138.115.101]:64485 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269504AbUJLHok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 03:44:40 -0400
Date: Tue, 12 Oct 2004 09:52:22 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Rajsekar <rajsekar@peacock.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp freezes (fwd)
Message-ID: <Pine.LNX.4.61.0410120950230.2957@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Oct 2004, Rajsekar wrote:

> 
> I am using 2.6.8-rc4-mm1 kernel at my home.  When I try to swap suspend
> (either using swsusp or pmdisk) it figures out how much memory is required
> and all and then sometimes freezes giving a backtrace.  I am interested in
> debugging this problem.  Can someone tell me the basic things required
> (softwares and some docs if any) to debug such kernel codes.  This is my
> first venture into debugging kernel codes, so I am very much a newbie.
> 
You could start by reading Documentation/BUG-HUNTING and 
Documentation/oops-tracing.txt

Also, you could post the Oops to the list so other people can take a look 
at it. Including info on your hardware, kernel version etc is often 
useful. Take a look at 
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html for details 
on what it is usually a good idea to provide (also take a look at the 
other documents linked from that page).


--
Jesper Juhl


PS. That obfuscation of your email address is pretty annoying. Besides, 
once there has been a single reply to you and the list with the edited 
address it's no longer useful to prevent spam, so it's a pretty pointless 
thing to do in the first place.

