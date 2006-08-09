Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWHIRoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWHIRoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWHIRoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:44:06 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:12936 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751280AbWHIRoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:44:04 -0400
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend
	to disk on i386
From: john stultz <johnstul@us.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux ACPI <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200608091426.31762.rjw@sisk.pl>
References: <200608091426.31762.rjw@sisk.pl>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 10:44:00 -0700
Message-Id: <1155145440.5418.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 14:26 +0200, Rafael J. Wysocki wrote:
> It looks like the CMOS clock gets corrupted during the suspend to disk
> on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> AMD64-based and the x86_64 kernel doesn't have this problem on it.
> 
> Also, I've done some tests that indicate the corruption doesn't occur before
> saving the suspend image.  It rather happens when the box is powered off
> or rebooted (tested both cases).

Hmmm. Could you better describe the corruption you're seeing? 

I've just gotten a report about uptime reporting odd values after resume
when the CMOS clock was set to the past during a suspend to disk, but
that's somewhat expected and I would think it would occur on x86_64 as
well.

thanks
-john


