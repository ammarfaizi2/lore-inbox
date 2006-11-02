Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752765AbWKBMek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbWKBMek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 07:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbWKBMek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 07:34:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56332 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1752765AbWKBMej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 07:34:39 -0500
Date: Thu, 2 Nov 2006 12:33:58 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lockup with cpufreq that may be similar to recently fixed acpi_cpufreq
Message-ID: <20061102123357.GA4826@ucw.cz>
References: <1162037001.2465.14.camel@aurora.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162037001.2465.14.camel@aurora.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This may be a single vendor problem. I am having a difficult time
> getting the vendor to respond. However, I have a dual core Turion laptop
> which is locking up on resume from suspend (resume from hibernate now
> works fine). Below is the DWARF2 trace back. It is showing a problem in
> cpufreq_resume (if I read this correctly). I think this may be similar
> to a problem that was recently fixed, that had the same symptoms, in
> acpi_cpufreq. This is 2.6.18.

Try rmmod cpufreq to see if it is cpufreq problem or if something else
causes the lockup.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
