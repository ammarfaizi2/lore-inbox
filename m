Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWHIUNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWHIUNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWHIUNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:13:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:53741 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751352AbWHIUNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:13:49 -0400
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend
	to disk on i386
From: john stultz <johnstul@us.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux ACPI <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200608092204.13711.rjw@sisk.pl>
References: <200608091426.31762.rjw@sisk.pl>
	 <1155145440.5418.21.camel@localhost.localdomain>
	 <200608092204.13711.rjw@sisk.pl>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 13:13:32 -0700
Message-Id: <1155154412.8109.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 22:04 +0200, Rafael J. Wysocki wrote:
> On Wednesday 09 August 2006 19:44, john stultz wrote:
> > On Wed, 2006-08-09 at 14:26 +0200, Rafael J. Wysocki wrote:
> > > It looks like the CMOS clock gets corrupted during the suspend to disk
> > > on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> > > AMD64-based and the x86_64 kernel doesn't have this problem on it.
> > > 
> > > Also, I've done some tests that indicate the corruption doesn't occur before
> > > saving the suspend image.  It rather happens when the box is powered off
> > > or rebooted (tested both cases).
> > 
> > Hmmm. Could you better describe the corruption you're seeing? 
> 
> After I do "echo disk > /sys/power/state" and the system suspends, the
> CMOS clock settings, as visible via the BIOS setup, are more or less random.

And after resuming does time output the time/date properly, or is it
confused as well?

thanks
-john



