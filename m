Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267471AbTHERrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 13:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbTHERrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 13:47:04 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:58531 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S267471AbTHERrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 13:47:02 -0400
Date: Tue, 5 Aug 2003 19:46:57 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Ducrot Bruno <poup@poupinou.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030805174657.GA22909@louise.pinerecords.com>
References: <20030805165117.GH18982@louise.pinerecords.com> <Pine.LNX.4.44.0308051006060.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308051006060.23977-100000@cherise>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [mochel@osdl.org]
> 
> I can buy that. There are actually three levels of power management that 
> we handle:
> 
> - System Power Management (swsusp, CONFIG_ACPI_SLEEP)
> - Device Power Management (kernel/pm.c, future driver model support)
> - CPU Power Management (cpufreq)
> 
> SPM implies that DPM will be enabled, but both DPM and CPM can exist 
> without SPM, and independently of each other. All of them would 
> essentially fall under CONFIG_PM.. 

Ok, that makes a lot of sense.

> Would you willing to whip up a patch for the Kconfig entries? 

Sure, I'll try to put something together so we have a patch to start
playing with.

-- 
Tomas Szepe <szepe@pinerecords.com>
