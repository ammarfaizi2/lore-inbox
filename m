Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264318AbUEMRbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbUEMRbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUEMRbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:31:37 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:54282
	"EHLO muru.com") by vger.kernel.org with ESMTP id S264318AbUEMRba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:31:30 -0400
Date: Thu, 13 May 2004 10:31:32 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH] Powernow-k8 buggy BIOS override for 2.6.6
Message-ID: <20040513173132.GE28678@atomide.com>
References: <20040512235623.GA9234@atomide.com> <20040513162643.GA4506@atrey.karlin.mff.cuni.cz> <20040513171921.GB28678@atomide.com> <20040513172116.GD4506@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513172116.GD4506@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [040513 10:21]:
> 
> This patch is okay if you insert modules in right order, but not if
> you attempt to insert cpufreq before acpi, right?

For me modprobe powernow-k8 automatically also loads processor.

> Please do not make that go in like it is.

What would you suggest?

Tony
