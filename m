Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTKETqf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbTKETqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:46:35 -0500
Received: from smtp02.web.de ([217.72.192.151]:53259 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263158AbTKETqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:46:31 -0500
Cc: lkml <linux-kernel@vger.kernel.org>, psavo@iki.fi, clepple@ghz.cc
To: Tony Lindgren <tony@atomide.com>, john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
References: <20031104002243.GC1281@atomide.com> <1067971295.11436.66.camel@cog.beaverton.ibm.com> <20031104191504.GB1042@atomide.com>
Message-ID: <oprx6jpvyfwilrtr@smtp.web.de>
From: Felix Maibaum <f.maibaum@web.de>
Content-Type: text/plain; format=flowed; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Wed, 05 Nov 2003 20:42:57 +0100
In-Reply-To: <20031104191504.GB1042@atomide.com>
User-Agent: Opera7.21/Linux M2 build 480
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003 11:15:04 -0800, Tony Lindgren <tony@atomide.com> wrote:


> I've heard of timing problems if it's compiled in, but supposedly they 
> don't
> happen when loaded as module.

As of 2.4.22 they happen regardless of compiling the code as a module or 
statically



> So it looks like there are some dependencies to other drivers that need 
> to
> be sorted out, or amd76x_pm needs to be loaded after some other
> initializations.

In an older thread it was mentioned that the module should sync the TSCs 
to the bios clock, or at least between the processors when it wakes up.

regards

Felix

-- 
LINUX - because booting is for adding hardware!
