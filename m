Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUFYFWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUFYFWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 01:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUFYFWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 01:22:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:28378 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266186AbUFYFWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 01:22:54 -0400
Date: Thu, 24 Jun 2004 22:21:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2
Message-Id: <20040624222140.07e01dae.akpm@osdl.org>
In-Reply-To: <200406242257.03397.rjwysocki@sisk.pl>
References: <20040624014655.5d2a4bfb.akpm@osdl.org>
	<200406242257.03397.rjwysocki@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
>
> On Thursday 24 of June 2004 10:46, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-m
> >m2/
> 
> Well, I have alarmingly many problems with this patch (my system is a dual 
> Opteron - full config log attached):
> 
> 1) There is an Oops at early boot time, caused probably by earlyprintk, which 
> makes the serial console stop working (the call trace goes too fast to read 
> and of course it does not go to the serial console ...).

This is fixed, yes?

> 2) There is an Oops when trying to unload the sound driver (snd-intel8x0).  At 
> present I'm unable to grab it. because of 1).

I'm not able to reproduce this.  Can you grab a trace now?

> 3) This breaks fb console on my system quite a bit:
> 
> > +core-fbcon-fixes.patch
> 
> - there is an ugly grey background area behind the penguin logos at startup.  
> The (screen behind the) logos are (is) ok without it. ;-)

I forwarded this to Antonino, but he's hiding.
