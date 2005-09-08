Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVIHHer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVIHHer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 03:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVIHHer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 03:34:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751333AbVIHHer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 03:34:47 -0400
Date: Thu, 8 Sep 2005 00:34:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Len Brown <len.brown@intel.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] ACPI for 2.6.14
Message-Id: <20050908003420.00e49325.akpm@osdl.org>
In-Reply-To: <1126163937.21723.12.camel@toshiba>
References: <1126163937.21723.12.camel@toshiba>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> wrote:
>
> Hi Linus, please pull from the release branch here:
> 
>  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

There are a few bugs which I'd identified as arising from the acpi tree
while it was in -mm.  Is this patch likely to drag them into mainline?

They include:


http://bugzilla.kernel.org/show_bug.cgi?id=4977
            Summary: ACPI 20050708 fails on HP RX2600 platform

http://bugzilla.kernel.org/show_bug.cgi?id=4867
            Summary: bug in ACPI crashes machine when reading
                     /proc/acpi/thermal_zone/THRM/temperature

http://bugzilla.kernel.org/show_bug.cgi?id=4980
            Summary: krash on entering mem sleep

Plus we have all the battery monitor woes, but they're in 2.6.13 already.

Thanks.
