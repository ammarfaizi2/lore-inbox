Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVCURJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVCURJZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 12:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVCURJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 12:09:25 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:8903 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261156AbVCURJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 12:09:22 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Subject: Re: 2.6.12-rc1-mm1
Date: Mon, 21 Mar 2005 09:09:01 -0800
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050321025159.1cabd62e.akpm@osdl.org>
In-Reply-To: <20050321025159.1cabd62e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503210909.02026.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 21, 2005 2:51 am, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.
>6.12-rc1-mm1/
>
>
> - We might have a fix here for the recent AGP/DRM problems.  If you were
>   having problems with that, please test and report.
>
> - An update to the hfs and hfsplus filesystems.
>
> - Lots more pcmcia changes.
>
> - Linus is away this week.  Not a lot more should be going into 2.6.12 now
>   and I have a list of ~140 bugs, many of which are post-2.6.10
> regressions. We should fix these.

Len, why does ACPI now depend on PM?  On some platforms it has very little to 
do with power management, and this breaks the build for sn2...

Jesse
