Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVIYFuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVIYFuj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 01:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVIYFuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 01:50:39 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:2776 "EHLO
	idefix") by vger.kernel.org with ESMTP id S1751103AbVIYFui convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 01:50:38 -0400
Subject: Re: Suspend to RAM broken with 2.6.13
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050923163200.GC8946@openzaurus.ucw.cz>
References: <1127347633.25357.49.camel@idefix.homelinux.org>
	 <20050923163200.GC8946@openzaurus.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Sat, 24 Sep 2005 21:12:41 +1000
Message-Id: <1127560361.7163.14.camel@142.163.233.220.exetel.com.au>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I'm experiencing problems with suspend to RAM on my Dell D600 laptop.
> > When I run Ubuntu's 2.6.10 kernel I have no problem with suspend to RAM.
> > However, when I run 2.6.13, my laptop sometimes doesn't wake up. It
> > seems like the longer my uptime, the more likely the problem is to occur
> > (which makes it hard to reproduce sometimes). This happens even with a
> > non-preempt kernel.
> 
> Check if it works with minimal drivers and non-preemptible kernel...

I checked with 1) a minimal drivers on a preempt kernel and 2) with a
few more drivers (usb mouse) and a non-preempt kernel. Both didn't wake
up when I suspended after a few days of uptime (right after boot, it's
fine). The default Ubuntu kernel is a preempt-enabled 2.6.10 kernel and
it always resumed from suspend, even with usb devices plugged in (I
still had to reload the driver though). As I said, it's not trivial to
test, because it takes a while before the bug occurs.

	Jean-Marc

-- 
Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Université de Sherbrooke
