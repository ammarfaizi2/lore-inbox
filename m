Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWHIUEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWHIUEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWHIUEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:04:50 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:58595 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751341AbWHIUEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:04:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Date: Wed, 9 Aug 2006 22:04:13 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux ACPI <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
References: <200608091426.31762.rjw@sisk.pl> <1155145440.5418.21.camel@localhost.localdomain>
In-Reply-To: <1155145440.5418.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608092204.13711.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 19:44, john stultz wrote:
> On Wed, 2006-08-09 at 14:26 +0200, Rafael J. Wysocki wrote:
> > It looks like the CMOS clock gets corrupted during the suspend to disk
> > on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> > AMD64-based and the x86_64 kernel doesn't have this problem on it.
> > 
> > Also, I've done some tests that indicate the corruption doesn't occur before
> > saving the suspend image.  It rather happens when the box is powered off
> > or rebooted (tested both cases).
> 
> Hmmm. Could you better describe the corruption you're seeing? 

After I do "echo disk > /sys/power/state" and the system suspends, the
CMOS clock settings, as visible via the BIOS setup, are more or less random.

Rafael
