Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTEBSUC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTEBSUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:20:02 -0400
Received: from [65.198.37.67] ([65.198.37.67]:18615 "EHLO gghcwest.com")
	by vger.kernel.org with ESMTP id S263077AbTEBST7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:19:59 -0400
Date: Fri, 2 May 2003 11:32:22 -0700
From: Jeffrey Baker <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
Subject: Re: centrino
Message-ID: <20030502183222.GA30189@heat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here was my collected experience on a Centrino machine,
before I returned it in favor of an iBook:

The AGP worked in 2.4.21-pre but not in 2.5.68-mm2,
regardless of agp_try_unsupported=1.  The Radeon 9000
Mobility in the Acer Travelmate is supported in XFree86
4.3.0.  Don't know about the IBM.

The IDE DMA seemed to work fine in both 2.4.21 and 2.5.68.

Power management didn't work at all because ACPI is a sick
joke.  In 2.4 ACPI does nothing, and in 2.5.68 it can put
the machine to sleep, but not wake it up.  APM could almost
wake the system from sleep, but then it crashed immediately.
ACPI incorrectly reports the state of the system fans, the
battery, the battery charger, and the temperature sensor.
In other words, no part of it functions correctly .  This is
either a problem with Centrino chipset in general or Acer
BIOS programming in particular.

CPU frequency scaling didn't work in either kernel but there
seem to be rumbles of reverse engineering going on with
that.

The wireless doesn't work in any kernel, and Intel have
stated specifically on their web site that they have no
plans for any future Linux driver for that device.

The Centrino package is altogether hostile to Linux.

-jwb
