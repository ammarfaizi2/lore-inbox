Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVLCSjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVLCSjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVLCSjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:39:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36318 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932126AbVLCSjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:39:14 -0500
Date: Sat, 3 Dec 2005 18:39:12 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203183912.GA8203@gallifrey>
References: <20051203135608.GJ31395@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203135608.GJ31395@stusta.de>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3 (i686)
X-Uptime: 18:29:52 up 92 days,  6:56, 67 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,
  I would really appreciate such a move to a stable series.
I've had some really bad luck with instability of 2.6.x - in
particular with NFS.

  Would such a stable kernel keep up to date on basic drivers?
I ask since I got into a messy situation on a series of production
servers;  they were really new Dell servers using standard Intel
chipsets but needed SATA stuff that went in recently.
Does 2.6.16 have the basic infrastructure for all the current
hardware so that if you branch now you aren't going to have
to do any really heavy backports to be able to run on
'current' hardware?

I hit the situation where I have a 2.6.5 kernel I use on everything
else and whose NFS works fine; and 2.6.11 or newer which supports
the hardware - but whose NFS is giving me broken locking to some
obscure systems.

IMHO we've also got into a real mess where it is vendor
kernels that have stability fixes in for many things (NFS in
particular) - but the lkml doesn't want to know about vendor
kernels, but at the same time they aren't up for stabilisation.

Good luck with such a branch!

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
