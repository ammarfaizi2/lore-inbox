Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVIZHAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVIZHAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 03:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVIZHAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 03:00:19 -0400
Received: from idefix.CeNTIE.NET.au ([202.9.6.83]:16260 "HELO idefix")
	by vger.kernel.org with SMTP id S932415AbVIZHAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 03:00:18 -0400
Subject: Re: Suspend to RAM broken with 2.6.13
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050923163200.GC8946@openzaurus.ucw.cz>
References: <1127347633.25357.49.camel@idefix.homelinux.org>
	 <20050923163200.GC8946@openzaurus.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Mon, 26 Sep 2005 16:59:57 +1000
Message-Id: <1127717997.16318.2.camel@142.163.233.220.exetel.com.au>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm experiencing problems with suspend to RAM on my Dell D600 laptop.
> > When I run Ubuntu's 2.6.10 kernel I have no problem with suspend to RAM.
> > However, when I run 2.6.13, my laptop sometimes doesn't wake up. It
> > seems like the longer my uptime, the more likely the problem is to occur
> > (which makes it hard to reproduce sometimes). This happens even with a
> > non-preempt kernel.
> 
> Check if it works with minimal drivers and non-preemptible kernel...

OK, I can confirm failure to resume even on a non-preempt 2.6.13 with no
USB devices and lots of stuff (e.g. wifi card) turned off. So far,
2.6.10 is resuming (running a non-Ubuntu vanilla 2.6.10 now).

	Jean-Marc
