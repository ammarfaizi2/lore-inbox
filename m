Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVBNUkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVBNUkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVBNUkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:40:42 -0500
Received: from fmr16.intel.com ([192.55.52.70]:8595 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261449AbVBNUkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:40:36 -0500
Subject: Re: [PATCH] make ACPI_BLACKLIST_YEAR depend on ACPI
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0502140801570.15516@ppc970.osdl.org>
References: <200502141130.51901@bilbo.math.uni-mannheim.de>
	 <Pine.LNX.4.58.0502140801570.15516@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1108413614.2092.5.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Feb 2005 15:40:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: ACPI_BLACKLIST_YEAR depending on ACPI or ACPI_INTERPRETER -- either
are fine.

Note that I'm planning to delete the separate ACPI_INTERPRETER build
option and just use CONFIG_ACPI in the future.  We tested this in a
config clean-up in -mm a while back, and I should probably revive it for
early 2.6.12.  The reason is that there really isn't a valid concept of
ACPI without the interpreter -- it can't even be used for configuring
interrupts without the interpreter on hand.

thanks,
-Len


