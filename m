Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266586AbRGLUqn>; Thu, 12 Jul 2001 16:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbRGLUqc>; Thu, 12 Jul 2001 16:46:32 -0400
Received: from [194.213.32.142] ([194.213.32.142]:16132 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266573AbRGLUqN>;
	Thu, 12 Jul 2001 16:46:13 -0400
Message-ID: <20010711235312.A425@bug.ucw.cz>
Date: Wed, 11 Jul 2001 23:53:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andreas Dilger <adilger@turbolinux.com>, Zach Brown <zab@osdlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] struct kernel_stat -> struct cpu_stat[NR_CPUS]
In-Reply-To: <20010702163631.B9806@osdlab.org> <200107030649.f636nqB3001452@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200107030649.f636nqB3001452@webber.adilger.int>; from Andreas Dilger on Tue, Jul 03, 2001 at 12:49:51AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > These per cpu statistics are reported via a new /proc/cpustat, a quick
> > tool for processing that output, vmstat-style, can be found near
> 
> Could you consider /proc/cpu/0/stats or similar?  It is much nicer
> than polluting the top-level /proc directory, and I believe there
> are a bunch of other per-cpu items waiting to go there as well
> (process binding, hot-swap CPU stuff, etc)

Add throttling, C-states, and similar acpi stuff. I'd like it to go
into /proc/cpu/0 rather than be buried somewhere into /proc/acpi.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
