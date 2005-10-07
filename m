Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVJGJvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVJGJvL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 05:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVJGJvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 05:51:11 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:64387 "EHLO
	idefix") by vger.kernel.org with ESMTP id S932274AbVJGJvJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 05:51:09 -0400
Subject: Re: Suspend to RAM broken with 2.6.13
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051007072835.GG27711@elf.ucw.cz>
References: <1127347633.25357.49.camel@idefix.homelinux.org>
	 <20050923163200.GC8946@openzaurus.ucw.cz>
	 <1128663145.14284.85.camel@localhost.localdomain>
	 <20051007072835.GG27711@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Fri, 07 Oct 2005 19:50:49 +1000
Message-Id: <1128678649.14284.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've done some further testing on suspend to RAM and it seems like it
> > got broken for me between 2.6.11 and 2.6.12. Does that help narrowing
> > down the problem?
> 
> Well, you'd have to track it down in a bit more specific way. If you
> can narrow it down to specific day, or even better with binary search,
> it will help.

Any tip on which version to try first, i.e. when were potentially
problematic patches merged? Keep in mind that it can take several days
to trigger the problem (resume always works on a freshly booted system),
so systematically testing everything (even as a binary search) isn't
really an option. Maybe there a way to recover some information about
what exactly went wrong?

	Jean-Marc

> > Le vendredi 23 septembre 2005 ? 18:32 +0200, Pavel Machek a écrit :
> > > Hi!
> > > 
> > > > I'm experiencing problems with suspend to RAM on my Dell D600 laptop.
> > > > When I run Ubuntu's 2.6.10 kernel I have no problem with suspend to RAM.
> > > > However, when I run 2.6.13, my laptop sometimes doesn't wake up. It
> > > > seems like the longer my uptime, the more likely the problem is to occur
> > > > (which makes it hard to reproduce sometimes). This happens even with a
> > > > non-preempt kernel.
> > > 
> > > Check if it works with minimal drivers and non-preemptible kernel...
> 
> 
> 
