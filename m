Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268660AbUJPGEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268660AbUJPGEY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 02:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268664AbUJPGEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 02:04:24 -0400
Received: from fmr11.intel.com ([192.55.52.31]:30091 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S268660AbUJPGEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 02:04:13 -0400
Subject: Re: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
From: Len Brown <len.brown@intel.com>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <200410051309.02105.david-b@pacbell.net>
References: <200410051309.02105.david-b@pacbell.net>
Content-Type: text/plain
Organization: 
Message-Id: <1097906636.14156.41.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Oct 2004 02:03:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - ACPI (this should probably replace the new /proc/acpi/wakeup)

Agreed.  That file is a temporary solution.
The right solution is for the devices to appear in the right
place in the device tree and to hang the wakeup capabilities
off of them there.

thanks,
-Len


