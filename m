Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTJYMEf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 08:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTJYMEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 08:04:35 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:31243 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S262580AbTJYMEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 08:04:33 -0400
Date: Sat, 25 Oct 2003 14:04:25 +0200
From: David Jez <dave.jez@seznam.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: diethotplug-0.4 utility patch
Message-ID: <20031025120422.GB93355@stud.fit.vutbr.cz>
References: <20031023184603.GA81234@stud.fit.vutbr.cz> <20031024054145.GA3233@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031024054145.GA3233@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 10:41:46PM -0700, Greg KH wrote:
> Hm, remove action will not work.  See the linux-hotplug-devel mailing
> list archives for why we can not do this.
  OK, i'll see. But this realy helps me.

> > - adds pci.rc & usb.rc
> 
> Why do you need this?  What's wrong with a small shell script to do
> this?  Are you using this for a system?  I guess it could be useful for
> a system that has no shell.
  Nothing wrong on shell script, but i use this on system without perl,
awk, if, ...etc... binaries.

> > - for USB: matching by vendor & class, not only by vendor (-ENODEV bug)
> 
> Can you split this patch out?  It looks useful.
  of course
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
