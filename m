Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVEXLtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVEXLtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 07:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVEXLtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 07:49:04 -0400
Received: from colin.muc.de ([193.149.48.1]:50445 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261999AbVEXLtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 07:49:01 -0400
Date: 24 May 2005 13:49:00 +0200
Date: Tue, 24 May 2005 13:49:00 +0200
From: Andi Kleen <ak@muc.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ashok Raj <ashok.raj@intel.com>, zwane@arm.linux.org.uk,
       discuss@x86-64.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/4] CPU hot-plug support for x86_64
Message-ID: <20050524114900.GB86233@muc.de>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050520223417.532048000@csdlinux-2.jf.intel.com> <20050523163816.GA39821@muc.de> <200505232137.08464.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505232137.08464.rjw@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please note that CPU hotplug will be necessary for swsusp on SMP systems
> (e.g. dual-core).  It seems that currently __cpuinit <=> __init, so it's not
> quite suitable for this purpose.

This was only temporary of course because real CPU hotplug was not
yet implemented.

-Andi
